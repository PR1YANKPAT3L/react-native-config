//
//  SwiftFileWorker.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import SignPost
import SourceryAutoProtocols
import ZFile

public protocol CoderProtocol: AutoMockable {
    // sourcery:inline:Coder.AutoGenerateProtocol
    var disk: ConfigurationDisk { get }
    var builds: Builds { get }
    var signPost: SignPostProtocol { get }
    static var rnConfigurationModelDefault_TOP: String { get }
    static var rnConfigurationModelDefault_BOTTOM: String { get }
    static var factoryTop: String { get }
    static var rnConfigurationModelFactoryProtocolDefault: String { get }
    static var plistLinesXmlDefault: String { get }

    func writeRNConfigurationBridge() throws 
    func writeRNConfigurationModel() throws 
    func writeRNConfigurationModelFactory() throws 
    func writeRNConfigurationPlist() throws 
    func writeRNConfigurationPlist(to file: FileProtocol) throws 
    // sourcery:end
}

public protocol RNConfigurationBridgeProtocol: AutoMockable {
    // sourcery:inline:Coder.RNConfigurationBridge.AutoGenerateProtocol
    var envLocal: [String] { get }
    var envDebug: [String] { get }
    var envRelease: [String] { get }
    var envBetaRelease: [String] { get }
    static var top: String { get }
    var env: String { mutating get }
    static var bottom: String { get }
    // sourcery:end
}

// MARK: - Coder

/// Generates code or plist content and write to corresponding file
public struct Coder: CoderProtocol, AutoGenerateProtocol {
    
    public let disk: ConfigurationDisk
    public let builds: Builds
    public let signPost: SignPostProtocol
    
    // MARK: - Init
    
    public init(disk: ConfigurationDisk, builds: Builds, signPost: SignPostProtocol = SignPost.shared) {
        self.disk = disk
        self.builds = builds
        self.signPost = signPost
    }
    
}

// MARK: - Extensions

// MARK: - Writing Functions

// MARK: - RNConfigurationBridge

extension Coder {
    
    // Template
    
    public struct RNConfigurationBridge: RNConfigurationBridgeProtocol, AutoGenerateProtocol {
        
        // MARK: - Code
        
        // "@@"<#key#>" : @"<#value#>"";
        
        public let envLocal: [String]
        public let envDebug: [String]
        public let envRelease: [String]
        public let envBetaRelease: [String]
        
        // MARK: - Code Templates
        
        public static let top = """
        #import "ReactNativeConfig.h"
        #import <Foundation/Foundation.h>

        @implementation ReactNativeConfig

        RCT_EXPORT_MODULE()

        + (BOOL)requiresMainQueueSetup
        {
            return YES;
        }

        """
        
        public private(set) lazy var env: String = """
        + (NSDictionary *)env {
            #ifdef DEBUG
            #ifdef LOCAL
            return @{
                \(self.envLocal.joined(separator: ",\n"))
            };
            #else
            return @{
                \(self.envDebug.joined(separator: ",\n"))
            };
            #endif
            #elif RELEASE
            return @{
                \(self.envRelease.joined(separator: ",\n"))
            };
            #elif BETARELEASE
            return @{
                \(self.envBetaRelease.joined(separator: ",\n"))
            };
            #else
                NSLog(@"⚠️ (react-native-config) ReactNativeConfig.m needs preprocessor macro flag to be set in build settings to RELEASE / DEBUG / LOCAL / BETARELEASE ⚠️");
            return nil;
            #endif
        }
        """
        
        public static let bottom = """
        + (NSString *)envFor: (NSString *)key {
            NSString *value = (NSString *)[self.env objectForKey:key];
            return value;
        }

        - (NSDictionary *)constantsToExport {
            return [ReactNativeConfig env];
        }
        
        @end
        """
    }
    
    public func writeRNConfigurationBridge() throws {
        
        var bridgeCode = RNConfigurationBridge(
            envLocal: builds.bridgeEnv.local,
            envDebug: builds.bridgeEnv.debug,
            envRelease: builds.bridgeEnv.release,
            envBetaRelease: builds.bridgeEnv.betaRelease,
            env: nil
        )
        
        try disk.code.rnConfigurationBridgeObjectiveCMFile.write(data: """
            \(RNConfigurationBridge.top)
            \(bridgeCode.env)
            \(RNConfigurationBridge.bottom)
            """.data(using: .utf8)!
        )
        
    }
}

// MARK: - RNConfigurationModel

extension Coder {
    
    public func writeRNConfigurationModel() throws {
        
        var lines = Coder.rnConfigurationModelDefault_TOP + Coder.rnConfigurationModelDefault_BOTTOM
        
        guard builds.configurationModelVar.count > 0 else {
            try disk.code.rnConfigurationModelSwiftFile.write(string: lines.replacingOccurrences(of: ", CustomStringConvertible", with: "")  + "\n}")
            return
        }
        
        lines = """
            \(Coder.rnConfigurationModelDefault_TOP)
        
            // MARK: - Custom plist properties are added here
        
            \(builds.configurationModelVar)
        
            public init(from decoder: Decoder) throws {
        
                let container = try decoder.container(keyedBy: CodingKeys.self)
        
                \(builds.decoderInit)
                }
                \(Coder.rnConfigurationModelDefault_BOTTOM)
        
                public var description: String {
                return \"""
                Configuration.swift read from Info.plist of RNConfiguration framework
        
                // Custom environment dependend constants from .env.<CONFIGURATION>.json
        
                \(builds.configurationModelVarDescription)
                \"""
                }
            }
        
        """
        try disk.code.rnConfigurationModelSwiftFile.write(string: lines)
    }
    
    
    
    public static let rnConfigurationModelDefault_TOP = """
    import Foundation
    import RNModels
    import SourceryAutoProtocols

    /**
        ⚠️ File is generated and ignored in git. To change it change /RNConfigurationHighwaySetup/main.swift
    */

    public protocol RNConfigurationModelProtocol: AutoMockable {
        // sourcery:inline:RNConfigurationModel.AutoGenerateProtocol
        // sourcery:end
    }
    
    public struct RNConfigurationModel: Codable, CustomStringConvertible, RNConfigurationModelProtocol, AutoGenerateProtocol {

    """
    public static let rnConfigurationModelDefault_BOTTOM = """
         
        public static func create(from json: JSON) throws -> RNConfigurationModelProtocol {
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
    
                return try JSONDecoder().decode(RNConfigurationModel.self, from: jsonTyped.data(using: .utf8)!)
        }
            
        public enum Error: Swift.Error {
            case invalidBool(forKey: String)
        }
    """
}

// MARK: - RNConfigurationModelFactory

extension Coder {
    
    
    public static let factoryTop = """
    import Foundation
    import SourceryAutoProtocols
    import RNModels
    
    /**
     ⚠️ File is generated and ignored in git. To change it change /RNConfigurationHighwaySetup/main.swift
     */

    public protocol RNConfigurationModelFactoryProtocol: AutoObjcMockable
    {
        // sourcery:inline:RNConfigurationModelFactory.AutoGenerateProtocol

        static func allValuesDictionary() throws -> [String: String]
        func allCustomKeys() -> [String]
        
        // sourcery:end
    }

    @objc public class RNConfigurationModelFactory: NSObject, RNConfigurationModelFactoryProtocol, AutoGenerateProtocol
    {
        public static var infoDict: [String: Any]? = Bundle(for: RNConfigurationModelFactory.self).infoDictionary
    """

    public func writeRNConfigurationModelFactory() throws {
        
        var lines = Coder.rnConfigurationModelFactoryProtocolDefault
        
        guard builds.casesForEnum.count > 0 else {
            try disk.code.rnConfigurationModelFactorySwiftFile.write(string: lines)
            return
        }
        
        lines = """
        \(Coder.factoryTop)
        
            public enum Error: Swift.Error {
                case noInfoDictonary
                case infoDictionaryNotReadableAsDictionary
            }
        
            @objc public class func allValuesDictionary() throws -> [String : String] {
        
                var dict = [String : String]()
        
                try RNConfigurationModelFactory.allConstants().forEach { _case in
                    dict[_case.key.rawValue] = _case.value
                }
                return dict
            }
        
            /**
                All custom environment dependend keys that are added to the plist and in the dictionary
            */
            @objc public func allCustomKeys() -> [String] {
                return Case.allCases.map { $0.rawValue }
            }
        
            /**
                Keys used in the plist of RNConfiguration module when building for the selected configuration (Debug or Release)
            */
            public enum Case: String, CaseIterable {
        
            \(builds.casesForEnum)
        
            }
        
            /**
                Plist containing custom variables that are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
            */
            public static func readCurrentBuildConfiguration() throws ->  RNConfigurationModelProtocol {
        
                guard let infoDict = RNConfigurationModelFactory.infoDict else {
                    throw Error.noInfoDictonary
                }
        
                let data = try JSONSerialization.data(withJSONObject: infoDict, options: .prettyPrinted)
        
                return try JSONDecoder().decode(RNConfigurationModel.self, from: data)
            }
        
            /**
                If using swift use plist()
                In Objective-C you can access this dictionary containing all custom environment dependend keys.
                They are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
            */
            public static func allConstants() throws -> [RNConfigurationModelFactory.Case: String] {
        
                var result = [Case: String]()
        
                let plist = try RNConfigurationModelFactory.readCurrentBuildConfiguration() as! RNConfigurationModel
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
        
        try disk.code.rnConfigurationModelFactorySwiftFile.write(string: lines)
    }
    
    public static let rnConfigurationModelFactoryProtocolDefault = """
    \(Coder.factoryTop)
        
        public enum Error: Swift.Error {
            case noInfoDictonary
            case infoDictionaryNotReadableAsDictionary
        }
        
        @objc public class func allValuesDictionary() throws -> [String : String] {
            
            var dict = [String : String]()
            
             try RNConfigurationModelFactory.allConstants().forEach { _case in
                dict[_case.key.rawValue] = _case.value
            }
            return dict
        }
       
        /**
            All custom environment dependend keys that are added to the plist and in the dictionary
        */
        @objc public func allCustomKeys() -> [String] {
            return Case.allCases.map { $0.rawValue }
        }
        
        /**
            Keys used in the plist of RNConfiguration module when building for the selected configuration (Debug or Release)
        */
        public enum Case: String, CaseIterable {
            
          case _noCases
            
        }
        
        /**
            Plist containing custom variables that are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
        */
        public static func readCurrentBuildConfiguration() throws ->  RNConfigurationModel {
            
            guard let infoDict = RNConfigurationModelFactory.infoDict else {
                throw Error.noInfoDictonary
            }
            
            let data = try JSONSerialization.data(withJSONObject: infoDict, options: .prettyPrinted)
            
            return try JSONDecoder().decode(RNConfigurationModel.self, from: data)
        }
        
        /**
            If using swift use plist()
            In Objective-C you can access this dictionary containing all custom environment dependend keys.
            They are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
        */
        public static func allConstants() throws -> [RNConfigurationModelFactory.Case: String] {
    
            guard let infoDict = RNConfigurationModelFactory.infoDict else
            {
                throw Error.noInfoDictonary
            }
            var result = [Case: String]()
            
            let plist = try RNConfigurationModelFactory.readCurrentBuildConfiguration(infoDict: infoDict)
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
    
}

// MARK: - RNConfigurationPlist

extension Coder {
    
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
    
    public func writeRNConfigurationPlist() throws {
        
        try writeRNConfigurationPlist(to: disk.code.infoPlistRNConfiguration)
        try writeRNConfigurationPlist(to: disk.code.infoPlistRNConfigurationTests)
    }
    
    public func writeRNConfigurationPlist(to file: FileProtocol) throws {
        
        var plistLinesXml = Coder.plistLinesXmlDefault
        
        guard builds.plistLinesXmlText.count > 0 else {
            try  file.write(string: plistLinesXml)
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
        
        try file.write(string: plistLinesXml)
    }
}

extension Coder {
    
   
}
