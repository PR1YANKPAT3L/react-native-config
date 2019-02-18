//
//  PlatformConfiguarionFileWriter.swift
//  PrepareReactNativeconfig
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
    }
    
    public struct Input {
        public let debug: JSON
        public let release: JSON
        public let local: JSON?
    }
    
    // MARK: - Private
    
    private let allKeys: Builds.MappingKeys
    
    // MARK: Initialize
    
    public init(configurationFiles: Disk) throws {
        let debug = try JSONDecoder().decode(JSON.self, from:  try configurationFiles.inputJSON.debug.read())
        let release = try JSONDecoder().decode(JSON.self, from:  try configurationFiles.inputJSON.release.read())
        
        try configurationFiles.android.debug.write(string: try debug.androidEnvEntry())
        try configurationFiles.iOS.debug.write(string: try debug.xcconfigEntry())
        
        try configurationFiles.android.release.write(string: try release.androidEnvEntry())
        try configurationFiles.iOS.release.write(string: try release.xcconfigEntry())
        
        
        if  let localJSONfile = configurationFiles.inputJSON.local,
            let local = try? JSONDecoder().decode(JSON.self, from: try localJSONfile.read()) {
            
            try configurationFiles.android.local?.write(string: try local.androidEnvEntry())
            try configurationFiles.iOS.local?.write(string: try local.xcconfigEntry())
            input = Input(debug: debug, release: release, local: local)
        } else {
            input = Input(debug: debug, release: release, local: nil)
        }
        
        var allKeys: MappingKeys = debug.typed.enumerated().compactMap {
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
        }
        
        let booleanKeys: MappingKeys = debug.booleans.enumerated().compactMap {
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
        }
        allKeys.append(contentsOf: booleanKeys)
        
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
        
        
        if let local = input.local {
            output = Output(
                debug: try Builds.config(for: input.debug),
                release: try Builds.config(for: input.release),
                local:  try Builds.config(for: local)
            )
        } else {
            output = Output(
                debug: try Builds.config(for: input.debug),
                release: try Builds.config(for: input.release),
                local: nil
            )
        }
        
    }
    
    private static func config(for json: JSON) throws -> CurrentBuildConfiguration {
        var jsonTyped = "{"
        jsonTyped.append(contentsOf: json.typed.compactMap {
            return "\"\($0.key)\": \"\($0.value.value)\","
            }.joined(separator: "\n"))
        
        let jsonBooleans = json.booleans.compactMap {
            return "\"\($0.key)\": \"\($0.value)\","
            }.joined(separator: "\n")
        
        jsonTyped.append(contentsOf: jsonBooleans)
        jsonTyped.removeLast()
        jsonTyped.append(contentsOf: "}")
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(CurrentBuildConfiguration.self, from: jsonTyped.data(using: .utf8)!)
    }
    
}

func writeToPlatformReadableConfiguarationFiles(from configurationFiles: Disk) throws -> Builds {
   return try Builds(configurationFiles: configurationFiles)
}
