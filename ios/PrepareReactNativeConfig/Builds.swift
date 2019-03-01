//
//  PlatformConfiguarionFileWriter.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import ReactNativeConfigSwift

public struct Builds {
    
    private typealias MappingKeys = [(case: String, plistVar: String, plistVarString: String, xmlEntry: String, decoderInit: String)]

    
    public let input: Input
    public let output: Output
    
    public let casesForEnum: String

    public let plistVar: String
    public let plistVarString: String
    public let plistLinesXmlText: String
    public let decoderInit: String
    
    // MARK: - Structs
    
    public struct Output {
        public let debug: CurrentBuildConfiguration
        public let release: CurrentBuildConfiguration
        public let local: CurrentBuildConfiguration?
        public let betaRelease: CurrentBuildConfiguration?
    }
    
    public struct Input {
        public let debug: JSON
        public let release: JSON
        public let local: JSON?
        public let betaRelease: JSON?
    }
    
    // MARK: - Private
    
    private let allKeys: Builds.MappingKeys
    private let decoder: JSONDecoder
    
    // MARK: Initialize
    
    public init(from disk: ConfigurationDisk, decoder: JSONDecoder = JSONDecoder()) throws {

        self.decoder = decoder
        let debug = try decoder.decode(JSON.self, from:  try disk.inputJSON.debug.read())
        let release = try decoder.decode(JSON.self, from:  try disk.inputJSON.release.read())
        
        try disk.android.debug.write(string: try debug.androidEnvEntry())
        let entry = try debug.xcconfigEntry()
        try disk.iOS.debug.write(string: entry )
        
        try disk.android.release.write(string: try release.androidEnvEntry())
        try disk.iOS.release.write(string: try release.xcconfigEntry())
        
        var local: JSON?
        var betaRelease: JSON?
        
        if  let localJSONfile = disk.inputJSON.local {
            local = try decoder.decode(JSON.self, from: try localJSONfile.read())
            try disk.android.local?.write(string: try local!.androidEnvEntry())
            try disk.iOS.local?.write(string: try local!.xcconfigEntry())
        } else {
            local = nil
        }
        
        if  let betaReleaseJSONfile = disk.inputJSON.betaRelease{
            
            betaRelease = try decoder.decode(JSON.self, from: try betaReleaseJSONfile.read())
            
            try disk.android.betaRelease?.write(string: try betaRelease!.androidEnvEntry())
            try disk.iOS.betaRelease?.write(string: try betaRelease!.xcconfigEntry())
        } else {
            betaRelease = nil
        }
        
        input = Input(debug: debug, release: release, local: local, betaRelease: betaRelease)

        var allKeys: MappingKeys = debug.typed?.enumerated().compactMap {
            let key = $0.element.key
            let typedValue = $0.element.value.typedValue
            let swiftTypeString = typedValue.typeSwiftString
            let xmlType = typedValue.typePlistString
            
            return (
                case: "case \(key)",
                plistVar: "public let \(key): \(swiftTypeString)",
                plistVarString: "\(key): \\(\(key))",
                xmlEntry: """
                <key>\(key)</key>
                <\(xmlType)>$(\(key))</\(xmlType)>
                """,
                decoderInit: "\(key) = try container.decode(\(swiftTypeString).self, forKey: .\(key))"
            )
        } ?? [(case: String, plistVar: String, plistVarString: String, xmlEntry: String, decoderInit: String)]()
        
        if let booleanKeys: MappingKeys = (debug.booleans?.enumerated().compactMap {
            let key = $0.element.key
            let typedValue = JSONEntry.PossibleTypes.bool($0.element.value)
            let swiftTypeString = typedValue.typeSwiftString
            let xmlType = typedValue.typePlistString
            
            return (
                case: "case \(key)",
                plistVar: "public let \(key): \(swiftTypeString)",
                plistVarString: "\(key): \\(\(key))",
                xmlEntry: """
                <key>\(key)</key>
                <\(xmlType)>$(\(key))</\(xmlType)>
                """,
                decoderInit:"""
                
                        guard let \(key) = Bool(try container.decode(String.self, forKey: .\(key))) else { throw Error.invalidBool(forKey: \"\(key)\")}
                
                        self.\(key) = \(key)
                """
            )
        }) {
            allKeys.append(contentsOf: booleanKeys)
        }
        
        self.allKeys = allKeys
        
        casesForEnum = allKeys
                .map { $0.case }
                .map {"      \($0)"}
                .sorted()
                .joined(separator: "\n")
        
        plistVar = allKeys
                .map { $0.plistVar }
                .map {"    \($0)"}
                .sorted()
                .joined(separator: "\n")
        
        plistVarString = allKeys
                .map { $0.plistVarString }
                .map { "            * \($0)" }
                .sorted()
                .joined(separator: "\n")
        
        plistLinesXmlText  = allKeys
                .map { $0.xmlEntry }
                .map {"      \($0)"}
                .sorted()
                .joined(separator: "\n")
        
        decoderInit  = allKeys
            .map { $0.decoderInit }
            .sorted()
            .map {"         \($0)"}
            .joined(separator: "\n")
        
        output = Output(
            debug: try Builds.config(for: input.debug, decoder),
            release: try Builds.config(for: input.release, decoder),
            local:  local != nil ? try Builds.config(for: local!, decoder) : nil,
            betaRelease: betaRelease != nil ? try Builds.config(for: betaRelease!, decoder) : nil
        )
        
    }
    
    private static func config(for json: JSON, _ decoder: JSONDecoder) throws -> CurrentBuildConfiguration {

        let typed = json.typed ?? [String: JSONEntry]()
        
        var jsonTyped = "{"
        
        jsonTyped.append(contentsOf: typed.compactMap {
            return "\"\($0.key)\": \"\($0.value.value)\","
            }.joined(separator: "\n"))
        
        if let jsonBooleans = (
            json.booleans?
            .compactMap { return "\"\($0.key)\": \"\($0.value)\"," }
            .joined(separator: "\n")) {
            
            jsonTyped.append(contentsOf: jsonBooleans)

        }
        
        if jsonTyped.count > 1 { jsonTyped.removeLast() }
        
        jsonTyped.append(contentsOf: "}")
        
        return try decoder.decode(CurrentBuildConfiguration.self, from: jsonTyped.data(using: .utf8)!)
    }
    
}
