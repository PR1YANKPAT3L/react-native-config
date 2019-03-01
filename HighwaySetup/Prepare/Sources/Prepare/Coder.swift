//
//  SwiftFileWorker.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import SignPost

/// Generates code or plist content and write to corresponding file
public struct Coder {
    
    // MARK: - Static defaults
    
    public static let plistLinesXmlDefault = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
        <dict>
        <key>CFBundleDevelopmentRegion</key>
            <string>$(DEVELOPMENT_LANGUAGE)</string>
        <key>CFBundleExecutable</key>
            <string>$(EXECUTABLE_NAME)</string>
        <key>CFBundleIdentifier</key>
            <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
        <key>CFBundleInfoDictionaryVersion</key>
            <string>6.0</string>
        <key>CFBundleName</key>
            <string>$(PRODUCT_NAME)</string>
        <key>CFBundlePackageType</key>
            <string>FMWK</string>
        <key>CFBundleShortVersionString</key>
            <string>1.0</string>
        <key>CFBundleVersion</key>
            <string>$(CURRENT_PROJECT_VERSION)</string>
        </dict>
    </plist>
    """
    
    public static let currentBuildConfigurationWorkerDefault = """
    import Foundation
    
    /// ⚠️ File is generated and ignored in git. To change it change /PrepareReactNativeConfig/main.swift
    @objc public class CurrentBuildConfigurationWorker: NSObject {
        
        public enum Error: Swift.Error {
            case noInfoDictonary
            case infoDictionaryNotReadableAsDictionary
        }
        
        @objc public class func allValuesDictionary() throws -> [String : String] {
            
            var dict = [String : String]()
            
             try CurrentBuildConfigurationWorker.allConstants().forEach { _case in
                dict[_case.key.rawValue] = _case.value
            }
            return dict
        }
       
        /// All custom environment dependend keys that are added to the plist and in the dictionary
        @objc public func allCustomKeys() -> [String] {
            return Case.allCases.map { $0.rawValue }
        }
        
        /// Keys used in the plist of RNConfiguration module when building for the selected configuration (Debug or Release)
        public enum Case: String, CaseIterable {
            
          case _noCases
            
        }
        
        /// Plist containing custom variables that are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
        public static func readCurrentBuildConfiguration() throws ->  CurrentBuildConfiguration {
            
            guard let infoDict = Bundle(for: CurrentBuildConfigurationWorker.self).infoDictionary else {
                throw Error.noInfoDictonary
            }
            
            let data = try JSONSerialization.data(withJSONObject: infoDict, options: .prettyPrinted)
            
            return try JSONDecoder().decode(CurrentBuildConfiguration.self, from: data)
        }
        
        /// If using swift use plist()
        /// In Objective-C you can access this dictionary containing all custom environment dependend keys.
        /// They are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
        public static func  allConstants() throws ->  [CurrentBuildConfigurationWorker.Case: String] {
            var result = [Case: String]()
            
            let plist = try CurrentBuildConfigurationWorker.readCurrentBuildConfiguration()
            let data = try JSONEncoder().encode(plist)
            
            guard let dict: [String: String] = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String : String] else {
                throw Error.infoDictionaryNotReadableAsDictionary
            }
            
            dict.forEach {
                
                guard let key = Case(rawValue: $0.key) else {
                    return
                }
                result[key] = $0.value
            }
            
            return result
        }
        
    }
    """
    
    public static let currentBuildConfigurationDefault_TOP = """
        import Foundation
        
        //⚠️ File is generated and ignored in git. To change it change /PrepareReactNativeconfig/main.swift
        public struct CurrentBuildConfiguration: Codable, CustomStringConvertible {

    """
    public static let currentBuildConfigurationDefault_BOTTOM = """
         public static func create(from json: JSON) throws -> CurrentBuildConfiguration {
                        let typed = json.typed ?? [String: JSONEntry]()
            
                        var jsonTyped = "{"
            
                        jsonTyped.append(contentsOf: typed.compactMap {
                        return "\\"\\($0.key)\\": \\"\\($0.value.value)\\","
                        }.joined(separator: "\\n"))
            
                        if let jsonBooleans = (
                        json.booleans?
                        .compactMap { return "\\"\\($0.key)\\": \\"\\($0.value)\\"," }
                        .joined(separator: "\\n")) {
            
                        jsonTyped.append(contentsOf: jsonBooleans)
            
                        }
            
                        if jsonTyped.count > 1 { jsonTyped.removeLast() }
            
                        jsonTyped.append(contentsOf: "}")
            
                        return try JSONDecoder().decode(CurrentBuildConfiguration.self, from: jsonTyped.data(using: .utf8)!)
                    }
            
                    enum Error: Swift.Error {
                        case invalidBool(forKey: String)
                    }
            
                }
    """
    
    public let disk: ConfigurationDisk
    public let builds: Builds
    public let signPost: SignPostProtocol
    
    public init(disk: ConfigurationDisk, builds: Builds, signPost: SignPostProtocol = SignPost.shared) {
        self.disk = disk
        self.builds = builds
        self.signPost = signPost
    }
    
    public func generateConfigurationWorker() throws {
        
        var lines = Coder.currentBuildConfigurationWorkerDefault
        
        guard builds.casesForEnum.count > 0 else {
            try disk.code.configurationWorkerFile.write(data: lines.data(using: .utf8)!)
            return
        }
        
        lines = """
        import Foundation

        /// ⚠️ File is generated and ignored in git. To change it change /PrepareReactNativeConfig/main.swift
        @objc public class CurrentBuildConfigurationWorker: NSObject {
            
            public enum Error: Swift.Error {
                case noInfoDictonary
                case infoDictionaryNotReadableAsDictionary
            }
            
            @objc public class func allValuesDictionary() throws -> [String : String] {
                
                var dict = [String : String]()
                
                 try CurrentBuildConfigurationWorker.allConstants().forEach { _case in
                    dict[_case.key.rawValue] = _case.value
                }
                return dict
            }
           
            /// All custom environment dependend keys that are added to the plist and in the dictionary
            @objc public func allCustomKeys() -> [String] {
                return Case.allCases.map { $0.rawValue }
            }
            
            /// Keys used in the plist of RNConfiguration module when building for the selected configuration (Debug or Release)
            public enum Case: String, CaseIterable {
                
        \(builds.casesForEnum)
                
            }
            
            /// Plist containing custom variables that are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
            public static func readCurrentBuildConfiguration() throws ->  CurrentBuildConfiguration {
                
                guard let infoDict = Bundle(for: CurrentBuildConfigurationWorker.self).infoDictionary else {
                    throw Error.noInfoDictonary
                }
                
                let data = try JSONSerialization.data(withJSONObject: infoDict, options: .prettyPrinted)
                
                return try JSONDecoder().decode(CurrentBuildConfiguration.self, from: data)
            }
            
            /// If using swift use plist()
            /// In Objective-C you can access this dictionary containing all custom environment dependend keys.
            /// They are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
            public static func  allConstants() throws ->  [CurrentBuildConfigurationWorker.Case: String] {
                var result = [Case: String]()
                
                let plist = try CurrentBuildConfigurationWorker.readCurrentBuildConfiguration()
                let data = try JSONEncoder().encode(plist)
                
                guard let dict: [String: String] = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String : String] else {
                    throw Error.infoDictionaryNotReadableAsDictionary
                }
                
                dict.forEach {
                    
                    guard let key = Case(rawValue: $0.key) else {
                        return
                    }
                    result[key] = $0.value
                }
                
                return result
            }
            
            
        }

        
        """
        
        try disk.code.configurationWorkerFile.write(data: lines.data(using: .utf8)!)
    }
    
    public func generateConfigurationForCurrentBuild() throws {
        
        var lines = Coder.currentBuildConfigurationDefault_TOP + Coder.currentBuildConfigurationDefault_BOTTOM
        
        guard builds.plistVar.count > 0 else {
            try disk.code.currentBuild.write(string: lines.replacingOccurrences(of: ", CustomStringConvertible", with: ""))
            return
        }
        
        lines = """
        \(Coder.currentBuildConfigurationDefault_TOP)
        
        // MARK: - Custom plist properties are added here
        \(builds.plistVar)
        
            public init(from decoder: Decoder) throws {
        
                let container = try decoder.container(keyedBy: CodingKeys.self)
        
        \(builds.decoderInit)
        
        \(Coder.currentBuildConfigurationDefault_BOTTOM)
        
        public var description: String {
            return \"""
            Configuration.swift read from Info.plist of RNConfiguration framework
        
            // Custom environment dependend constants from .env.<CONFIGURATION>.json
        
            \(builds.plistVarString)
            \"""
        }
        
        """
        try disk.code.currentBuild.write(string: lines)
    }
    
    public func genereateInfoPlistForFrameworkForAllBuildsWithPlaceholders() throws {
        
        var plistLinesXml = Coder.plistLinesXmlDefault
        
        guard builds.plistLinesXmlText.count > 0 else {
            try disk.code.infoPlist.write(string: plistLinesXml)
            return
        }
        
        plistLinesXml = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
        <key>CFBundleDevelopmentRegion</key>
            <string>$(DEVELOPMENT_LANGUAGE)</string>
        <key>CFBundleExecutable</key>
            <string>$(EXECUTABLE_NAME)</string>
        <key>CFBundleIdentifier</key>
            <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
        <key>CFBundleInfoDictionaryVersion</key>
        <string>6.0</string>
        <key>CFBundleName</key>
            <string>$(PRODUCT_NAME)</string>
        <key>CFBundlePackageType</key>
            <string>FMWK</string>
        <key>CFBundleShortVersionString</key>
            <string>1.0</string>
        <key>CFBundleVersion</key>
            <string>$(CURRENT_PROJECT_VERSION)</string>
        \(builds.plistLinesXmlText)
        </dict>
        </plist>
        """
        
        try disk.code.infoPlist.write(string: plistLinesXml)
    }
    
}


