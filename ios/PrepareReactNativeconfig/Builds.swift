//
//  PlatformConfiguarionFileWriter.swift
//  PrepareReactNativeconfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation

struct Builds {
    
    let debug: JSON
    let release: JSON
    let local: JSON?
    
    let casesForEnum: String

    let plistVar: String
    let plistVarString: String
    let plistLinesXmlText: String
    
    // MARK: - Private
    
    private let allKeys: [(case: String, plistVar: String, plistVarString: String, xmlEntry: String)]
    
    // MARK: Initialize
    
    init(configurationFiles: Disk) throws {
        debug = try JSONDecoder().decode(JSON.self, from:  try configurationFiles.inputJSON.debug.read())
        release = try JSONDecoder().decode(JSON.self, from:  try configurationFiles.inputJSON.release.read())
        
        try configurationFiles.android.debug.write(string: try debug.androidEnvEntry())
        try configurationFiles.iOS.debug.write(string: try debug.xcconfigEntry())
        
        try configurationFiles.android.release.write(string: try release.androidEnvEntry())
        try configurationFiles.iOS.release.write(string: try release.xcconfigEntry())
        
        if  let localJSONfile = configurationFiles.inputJSON.local,
            let local = try? JSONDecoder().decode(JSON.self, from: try localJSONfile.read()) {
            
            try configurationFiles.android.local?.write(string: try local.androidEnvEntry())
            try configurationFiles.iOS.local?.write(string: try local.xcconfigEntry())
            self.local = local
        } else {
            local = nil
        }
        
        allKeys = debug.env.enumerated().compactMap {
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
                """
            )
        }
        
        casesForEnum = allKeys
                .map { $0.case }
                .map {"      \($0)"}
                .joined(separator: "\n")
        
        plistVar = allKeys
            .map { $0.plistVar }
            .map {"    \($0)"}
            .joined(separator: "\n")
        
        plistVarString = allKeys
            .map { $0.plistVarString }
            .map { "            * \($0)" }
            .joined(separator: "\n")
        
        plistLinesXmlText  = allKeys
                .map { $0.xmlEntry }
                .map {"      \($0)"}
                .joined(separator: "\n")
    }
    
    // MARK: - JSON struct
    
    struct JSON: Decodable {
        
        let env: [String: JSONEntry]
        
        func xcconfigEntry() throws -> String {
            return try env
                .map { return "\($0.key) = \(try xcconfigRawValue(for: $0.value))"}
                .sorted()
                .joined(separator: "\n")
        }
        
        func androidEnvEntry() throws -> String {
            return try env
                .map { return "\($0.key) = \(try androidEnvRawValue(for: $0.value))" }
                .sorted()
                .joined(separator: "\n")
        }
        
        // MARK: - Private
        
        private func xcconfigRawValue(for jsonEntry: JSONEntry) throws -> String {
            switch jsonEntry.typedValue {
            case let .url(url):
                return url.absoluteString
                    .replacingOccurrences(of: "http://", with: "http:\\/\\/")
                    .replacingOccurrences(of: "https://", with: "https:\\/\\/")
            case let .string(string):
                return string
            case let .int(int):
                return "\(int)"
            }
        }
        
        private func androidEnvRawValue(for jsonEntry: JSONEntry) throws -> String {
            switch jsonEntry.typedValue {
            case let .url(url):
                return url.absoluteString
            case let .string(string):
                return string
            case let .int(int):
                return "\(int)"
            }
        }
    }
    
    
}

func writeToPlatformReadableConfiguarationFiles(from configurationFiles: Disk) throws -> Builds {
   return try Builds(configurationFiles: configurationFiles)
}
