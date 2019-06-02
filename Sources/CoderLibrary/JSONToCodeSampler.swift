//
//  PlatformConfiguarionFileWriter.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import RNModels
import SourceryAutoProtocols

public protocol JSONToCodeSamplerProtocol: AutoMockable {
    // sourcery:inline:JSONToCodeSampler.AutoGenerateProtocol
    // sourcery:end
}

/**
 Will load input and decode input JSON -> Use RNConfigurationModel.create from this JSON.
 
 It will read the json files and give code sampels to the Coder to write code to files.
*/
public struct JSONToCodeSampler: JSONToCodeSamplerProtocol, AutoGenerateProtocol
{
    private typealias MappingKeys = [(case: String, configurationModelVar: String, configurationModelVarDescription: String, xmlEntry: String, decoderInit: String)]

    public let input: Input

    public let casesForEnum: String

    public let configurationModelVar: String
    public let configurationModelVarDescription: String
    public let plistLinesXmlText: String
    public let decoderInit: String
    public let bridgeEnv: JSONToCodeSampler.BridgeEnv

    public struct BridgeEnv
    {
        public let local: [String]
        public let debug: [String]
        public let release: [String]
        public let betaRelease: [String]
    }

    // MARK: - INPUT

    public struct Input
    {
        public let debug: RNModels.JSON
        public let release: JSON
        public let local: JSON?
        public let betaRelease: JSON?
    }

    // MARK: - Private

    private let allKeys: JSONToCodeSampler.MappingKeys
    private let decoder: JSONDecoder

    // MARK: Initialize

    public init(from disk: ConfigurationDisk, decoder: JSONDecoder = JSONDecoder()) throws
    {
        self.decoder = decoder
        let debug = try decoder.decode(JSON.self, from: try disk.inputJSON.debug.read())
        let release = try decoder.decode(JSON.self, from: try disk.inputJSON.release.read())

        try disk.android.debug.write(string: try debug.androidEnvEntry())
        let entry = try debug.xcconfigEntry()
        try disk.iOS.debug.write(string: entry)

        try disk.android.release.write(string: try release.androidEnvEntry())
        try disk.iOS.release.write(string: try release.xcconfigEntry())

        var local: JSON?
        var betaRelease: JSON?

        if let localJSONfile = disk.inputJSON.local
        {
            local = try decoder.decode(JSON.self, from: try localJSONfile.read())
            try disk.android.local?.write(string: try local!.androidEnvEntry())
            try disk.iOS.local?.write(string: try local!.xcconfigEntry())
        }
        else
        {
            local = nil
        }

        if let betaReleaseJSONfile = disk.inputJSON.betaRelease
        {
            betaRelease = try decoder.decode(JSON.self, from: try betaReleaseJSONfile.read())

            try disk.android.betaRelease?.write(string: try betaRelease!.androidEnvEntry())
            try disk.iOS.betaRelease?.write(string: try betaRelease!.xcconfigEntry())
        }
        else
        {
            betaRelease = nil
        }

        input = Input(debug: debug, release: release, local: local, betaRelease: betaRelease)

        var allKeys: MappingKeys = debug.typed?.enumerated().compactMap
        {
            let key = $0.element.key
            let typedValue = $0.element.value.typedValue
            let swiftTypeString = typedValue.typeSwiftString
            let xmlType = typedValue.typePlistString

            return (
                case: "case \(key)",
                configurationModelVar: "public let \(key): \(swiftTypeString)",
                configurationModelVarDescription: "\(key): \\(\(key))",
                xmlEntry: """
                <key>\(key)</key>
                <\(xmlType)>$(\(key))</\(xmlType)>
                """,
                decoderInit: "\(key) = try container.decode(\(swiftTypeString).self, forKey: .\(key))"
            )
        } ?? [(case: String, configurationModelVar: String, configurationModelVarDescription: String, xmlEntry: String, decoderInit: String)]()

        if let booleanKeys: MappingKeys = (
            debug.booleans?.enumerated().compactMap
            {
                let key = $0.element.key
                let typedValue = JSONEntry.PossibleTypes.bool($0.element.value)
                let swiftTypeString = typedValue.typeSwiftString

                return (
                    case: "case \(key)",
                    configurationModelVar: "public let \(key): \(swiftTypeString)",
                    configurationModelVarDescription: "\(key): \\(\(key))",
                    xmlEntry: """
                    <key>\(key)</key>
                    <string>$(\(key))</string>
                    """,
                    decoderInit: """
                    
                            guard let \(key) = Bool(try container.decode(String.self, forKey: .\(key))) else { throw Error.invalidBool(forKey: \"\(key)\")}
                    
                            self.\(key) = \(key)
                    """
                )
            }
        )
        {
            allKeys.append(contentsOf: booleanKeys)
        }

        self.allKeys = allKeys

        casesForEnum = allKeys
            .map { $0.case }
            .map { "      \($0)" }
            .sorted()
            .joined(separator: "\n")

        configurationModelVar = allKeys
            .map { $0.configurationModelVar }
            .map { "    \($0)" }
            .sorted()
            .joined(separator: "\n")

        configurationModelVarDescription = allKeys
            .map { $0.configurationModelVarDescription }
            .map { "            * \($0)" }
            .sorted()
            .joined(separator: "\n")

        plistLinesXmlText = allKeys
            .map { $0.xmlEntry }
            .map { "      \($0)" }
            .sorted()
            .joined(separator: "\n")

        decoderInit = allKeys
            .map { $0.decoderInit }
            .sorted()
            .map { "         \($0)" }
            .joined(separator: "\n")

        bridgeEnv = BridgeEnv(
            local: (input.local?.typed?.mapValues { $0.value }.map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? []) + (input.local?.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
            debug: (input.debug.typed?.mapValues { $0.value }.map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? []) + (input.debug.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
            release: (input.release.typed?.mapValues { $0.value }.map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? []) + (input.release.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
            betaRelease: (input.betaRelease?.typed?.mapValues { $0.value }.map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? []) + (input.betaRelease?.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? [])
        )
    }
}


