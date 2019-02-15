//
//  SwiftFileWorker.swift
//  PrepareReactNativeconfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation

/// Generates code or plist content and write to corresponding file
struct Coder {
    
    let disk: Disk
    let builds: Builds
    
    func generateConfigurationWorker() throws {
        
        let swiftLines = """
        //
        //  CurrentBuildConfigurationWorker
        //  ReactNativeConfigSwift
        //
        //  Created by Stijn on 29/01/2019.
        //  Copyright © 2019 Pedro Belo. All rights reserved.
        //
        
        import Foundation
        
        /// ⚠️ File is generated and ignored in git. To change it change /PrepareReactNativeconfig/main.swift
        @objc public class CurrentBuildConfigurationWorker: NSObject {
        
        public enum Error: Swift.Error {
            case noInfoDictonary
            case infoDictionaryNotReadableAsDictionary
        }
        
        @objc public class func allValuesDictionary() throws -> [String : String] {
        
            var dict = [String : String]()
        
            try Environment.allConstants().forEach { _case in
                dict[_case.key.rawValue] = _case.value
            }
            return dict
        }
        
        /// All custom environment dependend keys that are added to the plist and in the dictionary
        @objc public func allCustomKeys() -> [String] {
            return Case.allCases.map { $0.rawValue }
        }
        
        /// Keys used in the plist of ReactNativeConfigSwift module when building for the selected configuration (Debug or Release)
        public enum Case: String, CaseIterable {
        
        \(builds.casesForEnum)
        
        }
        
        /// Plist containing custom variables that are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
        public static func plist() throws ->  CurrentBuildConfiguration {
        
            guard let infoDict = Bundle(for: Environment.self).infoDictionary else {
                throw Error.noInfoDictonary
            }
            
            let data = try JSONSerialization.data(withJSONObject: infoDict, options: .prettyPrinted)
            
                return try JSONDecoder().decode(Plist.self, from: data)
            }
            
            /// If using swift use plist()
            /// In Objective-C you can access this dictionary containing all custom environment dependend keys.
            /// They are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
            public static func  allConstants() throws ->  [Environment.Case: String] {
            var result = [Case: String]()
            
            let plist = try Environment.plist()
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
        
        try disk.configurationWorkerFile.write(data: swiftLines.data(using: .utf8)!)
    }
    
    func generateConfigurationForCurrentBuild() throws {
        let plistLinesSwift = """
        //
        //  Configuration.swift
        //  ReactNativeConfigSwift
        //
        //  Created by Stijn on 30/01/2019.
        //  Copyright © 2019 Pedro Belo. All rights reserved.
        //
        
        import Foundation
        
        //⚠️ File is generated and ignored in git. To change it change /PrepareReactNativeconfig/main.swift
        
        public struct Configuration: Codable, CustomStringConvertible {
        
        
        // These are the normal plist things
        
        public let CFBundleDevelopmentRegion: String
        public let CFBundleExecutable: String
        public let CFBundleIdentifier: String
        public let CFBundleInfoDictionaryVersion: String
        public let CFBundleName: String
        public let CFBundlePackageType: String
        public let CFBundleShortVersionString: String
        public let CFBundleVersion: String
        
        // Custom plist properties are added here
        \(builds.plistVar)
        
        public var description: String {
        return \"""
        Configuration.swift read from Info.plist of ReactNativeConfigSwift framework
        
        // Config variable of Framework ReactNativeConfigSwift
        
        * CFBundleDevelopmentRegion = \\(CFBundleDevelopmentRegion)
        * CFBundleExecutable = \\(CFBundleExecutable)
        * CFBundleIdentifier = \\(CFBundleIdentifier)
        * CFBundleInfoDictionaryVersion = \\(CFBundleInfoDictionaryVersion)
        * CFBundleName = \\(CFBundleName)
        * CFBundlePackageType = \\(CFBundlePackageType)
        * CFBundleShortVersionString = \\(CFBundleShortVersionString)
        * CFBundleVersion = \\(CFBundleVersion)
        
        // Custom environment dependend constants from .env.debug.json or .env.release.json
        
        \(builds.plistVarString)
        \"""
        }
        
        }
        
        """
        try disk.configurationFile.write(string: plistLinesSwift)
    }
    
    func genereateInfoPlistForFrameworkForAllBuilds() throws {
        let plistLinesXml = """
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
        
        try disk.plistFile.write(string: plistLinesXml)
    }
}


