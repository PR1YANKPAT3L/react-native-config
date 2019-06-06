//
//  SwiftFileWorker.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import SignPost
import ZFile
import Terminal
import Errors

// sourcery:AutoMockable
public protocol CoderProtocol {
    // sourcery:inline:Coder.AutoGenerateProtocol
    var configurationDisk: ConfigurationDiskProtocol { get }
    var codeSampler: JSONToCodeSamplerProtocol { get }
    var signPost: SignPostProtocol { get }
    static var rnConfigurationModelDefault_TOP: String { get }
    static var rnConfigurationModelDefault_BOTTOM: String { get }
    static var factoryTop: String { get }
    static var rnConfigurationModelFactoryProtocolDefault: String { get }

    func attempt() throws  -> Coder.Config
    func writeRNConfigurationBridge() throws 
    func writeRNConfigurationModel() throws 
    func writeRNConfigurationModelFactory() throws 
   
    // sourcery:end
}

// sourcery:AutoMockable
public protocol RNConfigurationBridgeProtocol {
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

/**
 Generates code or plist content and write to corresponding file
 
 As only iOS has code that is shared to React native and that code is used in Android this only writes to iOS files.
 
 But maybe in the future it can write Android too. The TextFileWriter now writes to needed config files for Android.
 */
// sourcery:AutoGenerateProtocol
public struct Coder: CoderProtocol {
    
    // MARK: - Private
    
    public let configurationDisk: ConfigurationDiskProtocol
    public let codeSampler: JSONToCodeSamplerProtocol
    public let signPost: SignPostProtocol
    private let terminal: TerminalProtocol
    private let system: SystemProtocol
    
    // MARK: - Init
    
    public init(
        disk: ConfigurationDiskProtocol,
        builds: JSONToCodeSamplerProtocol,
        signPost: SignPostProtocol = SignPost.shared,
        decoder: JSONDecoder = JSONDecoder(),
        terminal: TerminalProtocol = Terminal.shared,
        system: SystemProtocol = System.shared
    ) {
        self.configurationDisk = disk
        self.codeSampler = builds
        self.signPost = signPost
        self.terminal = terminal
        self.system = system
    }
    
    public struct Config
    {
        public let plist: FileProtocol
        public let xcconfig: FileProtocol
    }
    
}

// MARK: - Executable functions

extension Coder {
    
    public func attempt() throws -> Coder.Config
    {
        do
        {
            try configurationDisk.code.writeDefaultsToFiles()
            
            signPost.verbose(
                """
                🚀 Env read from
                \(configurationDisk.inputJSON.debug)
                \(configurationDisk.inputJSON.release)
                \(String(describing: configurationDisk.inputJSON.local))
                \(String(describing: configurationDisk.inputJSON.betaRelease))
                ...
                """
            )
            
            signPost.verbose(
                """
                🚀 Written to config files
                
                # ios
                
                * \(configurationDisk.xcconfigFile)
                
                # android
                
                * \(configurationDisk.android.debug)
                * \(configurationDisk.android.release)
                * \(String(describing: configurationDisk.android.local))
                * \(String(describing: configurationDisk.android.betaRelease))
                
                """
            )
            
            signPost.message("🏗🧙‍♂️ Generating SWIFT code RNConfigurationModel.swift & RNConfigurationModelFactory.swift ...")
            try writeRNConfigurationModelFactory()
            try writeRNConfigurationModel()
            signPost.message("🏗🧙‍♂️ Generating SWIFT code RNConfigurationModel.swift & RNConfigurationModelFactory.swift ✅")
            
            signPost.message("🏗🧙‍♂️ Generating Plist with build dependend keys ...")
            try writeRNConfigurationPlist()
            signPost.message("🏗🧙‍♂️ Generating Plist with build dependend keys ✅")
            
            signPost.message("🏗🧙‍♂️ Generating Objective-C to Javascript bridge code - RNConfigurationBridge ...")
            try writeRNConfigurationBridge()
            signPost.message("🏗🧙‍♂️ Generating Objective-C to Javascript bridge code - RNConfigurationBridge ✅")
            
            // TODO: this should only be one config when we write it
            
            return Config(plist: configurationDisk.code.infoPlistRNConfiguration, xcconfig: configurationDisk.xcconfigFile)
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }
    
}

// MARK: - Extensions

// MARK: - Writing Functions

// MARK: - RNConfigurationBridge

extension Coder {
    
    // Template
    
    // sourcery:AutoGenerateProtocol
    public struct RNConfigurationBridge: RNConfigurationBridgeProtocol {
        
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
                NSLog(@"⚠️ (Coder) ReactNativeConfig.m needs preprocessor macro flag to be set in build settings to RELEASE / DEBUG / LOCAL / BETARELEASE ⚠️");
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
            envLocal: codeSampler.bridgeEnv.local,
            envDebug: codeSampler.bridgeEnv.debug,
            envRelease: codeSampler.bridgeEnv.release,
            envBetaRelease: codeSampler.bridgeEnv.betaRelease,
            env: nil
        )
        
        try configurationDisk.code.rnConfigurationBridgeObjectiveCMFile.write(string: """
            \(RNConfigurationBridge.top)
            \(bridgeCode.env)
            \(RNConfigurationBridge.bottom)
            """
        )
        
    }
}

// MARK: - RNConfigurationModel

extension Coder {
    
    public func writeRNConfigurationModel() throws {
        
        var lines = Coder.rnConfigurationModelDefault_TOP + Coder.rnConfigurationModelDefault_BOTTOM
        
        guard codeSampler.configurationModelVar.count > 0 else {
            try configurationDisk.code.rnConfigurationModelSwiftFile.write(string: lines.replacingOccurrences(of: ", CustomStringConvertible", with: "")  + "\n}")
            return
        }
        
        lines = """
            \(Coder.rnConfigurationModelDefault_TOP)
        
            // MARK: - Custom plist properties are added here
        
            \(codeSampler.configurationModelVar)
        
            public init(from decoder: Decoder) throws {
        
                let container = try decoder.container(keyedBy: CodingKeys.self)
        
                \(codeSampler.decoderInit)
                }
                \(Coder.rnConfigurationModelDefault_BOTTOM)
        
                public var description: String {
                return \"""
                Configuration.swift read from Info.plist of RNConfiguration framework
        
                // Custom environment dependend constants from .env.<CONFIGURATION>.json
        
                \(codeSampler.configurationModelVarDescription)
                \"""
                }
            }
        
        """
        try configurationDisk.code.rnConfigurationModelSwiftFile.write(string: lines)
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
        
        guard codeSampler.casesForEnum.count > 0 else {
            try configurationDisk.code.rnConfigurationModelFactorySwiftFile.write(string: lines)
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
        
            \(codeSampler.casesForEnum)
        
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
        
        try configurationDisk.code.rnConfigurationModelFactorySwiftFile.write(string: lines)
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
