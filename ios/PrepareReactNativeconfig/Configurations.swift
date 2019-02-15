//
//  PlatformConfiguarionFileWriter.swift
//  PrepareReactNativeconfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation

struct Configurations {
    
    let debug: JSON
    let release: JSON
    let local: JSON?
    
    struct JSON: Decodable {
        
        let dictionary: [String: JSONEntry]
        
        func xcconfigEntry() throws -> String {
            return try dictionary
                .map { return "\($0.key) = \(try xcconfigRawValue(for: $0.value))"}
                .sorted()
                .joined(separator: "\n")
        }
        
        func androidEnvEntry() throws -> String {
            return try dictionary
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
    
    let text: [(case: String, plistVar: String, plistVarString: String, xmlEntry: String)]
    
    init(configurationFiles: ConfigurationFiles) throws {
        debug = try JSONDecoder().decode(JSON.self, from:  try configurationFiles.debugJSONfile.read())
        release = try JSONDecoder().decode(JSON.self, from:  try configurationFiles.releaseJSONfile.read())
        
        try configurationFiles.debugAndroidConfigurationFile.write(string: try debug.androidEnvEntry())
        try configurationFiles.debugXconfigFile.write(string: try debug.xcconfigEntry())
        
        try configurationFiles.releaseAndroidConfigurationFile.write(string: try release.androidEnvEntry())
        try configurationFiles.releaseXconfigFile.write(string: try release.xcconfigEntry())
        
        if  let localJSONfile = configurationFiles.localJSONfile,
            let local = try? JSONDecoder().decode(JSON.self, from: try localJSONfile.read()) {
            
            try configurationFiles.localAndroidConfigurationFile?.write(string: try local.androidEnvEntry())
            try configurationFiles.localXconfigFile?.write(string: try local.xcconfigEntry())
            self.local = local
        } else {
            local = nil
        }
        
        text = debug.dictionary.enumerated().compactMap {
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
        
    }
    
    
}

func writeToPlatformReadableConfiguarationFiles(from configurationFiles: ConfigurationFiles) throws -> Configurations {
   return try Configurations(configurationFiles: configurationFiles)
}
