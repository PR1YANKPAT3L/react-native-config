//
//  PlatformConfiguarionFileWriter.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Errors
import Foundation
import RNModels
import SourceryAutoProtocols
import ZFile

/**
 Will load input and decode input JSON -> Use RNConfigurationModel.create from this JSON.

 It will read the json files and give code sampels to the Coder to write code to files.
 */
public struct JSONToCodeSampler: JSONToCodeSamplerProtocol, AutoGenerateProtocol
{
    public typealias Sample = [(case: String, configurationModelVar: String, configurationModelVarDescription: String, xmlEntry: String, decoderInit: String)]

    public let casesForEnum: String
    public let configurationModelVar: String
    public let configurationModelVarDescription: String
    public let plistLinesXmlText: String
    public let decoderInit: String
    public let bridgeEnv: [RNModels.Configuration: [String]]

    // MARK: Initialize

    public init(
        from input: CoderInputProtocol,
        to output: CoderOutputProtocol,
        decoder: JSONDecoder = JSONDecoder()
    ) throws
    {
        let json = try decoder.decode(JSONEnvironments.self, from: try input.inputJSONFile.read())
        let allKeys = JSONToCodeSampler.setupCodeSamples(json: json.debug)

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

        bridgeEnv = [
            .Local: (json.local.typed?
                .mapValues { $0.value }
                .map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? [])
                + (json.local.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
            .Debug: (json.debug.typed?
                .mapValues { $0.value }
                .map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? [])
                + (json.debug.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
            .Release: (json.release.typed?
                .mapValues { $0.value }
                .map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? [])
                + (json.release.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
            .BetaRelease: (json.betaRelease.typed?
                .mapValues { $0.value }
                .map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? [])
                + (json.betaRelease.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
        ]
    }

    // MARK: - Private

    private static func setupCodeSamples(json: JSONEnvironmentProtocol) -> JSONToCodeSampler.Sample
    {
        var allKeys: Sample = json.typed?.enumerated().compactMap
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

        if let booleanKeys: Sample = (
            json.booleans?.enumerated().compactMap
            {
                let key = $0.element.key
                let typedValue = TypedJsonEntry.PossibleTypes.bool($0.element.value)
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

        return allKeys
    }
}
