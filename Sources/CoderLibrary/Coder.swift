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
import SourceryAutoProtocols
import RNModels

/**
 Generates code or plist content and write to corresponding file
 
 As only iOS has code that is shared to React native and that code is used in Android this only writes to iOS files.
 
 But maybe in the future it can write Android too. The TextFileWriter now writes to needed config files for Android.
 */
public struct Coder: CoderProtocol, AutoGenerateProtocol {
    
    // MARK: - Private
        
    private let sampler: JSONToCodeSamplerProtocol
    private let signPost: SignPostProtocol
    private let terminal: TerminalProtocol
    private let system: SystemProtocol
    private let plistWriter: PlistWriterProtocol
    private let textFileWriter: TextFileWriterProtocol
    private let bridge: JSBridgeCodeSampleProtocol
    
    // MARK: - Init
    
    public init(
        sampler: JSONToCodeSamplerProtocol,
        plistWriter: PlistWriterProtocol = PlistWriter(),
        bridge: JSBridgeCodeSampleProtocol = JSBridgeCodeSample(),
        textFileWriter: TextFileWriterProtocol = TextFileWriter(),
        signPost: SignPostProtocol = SignPost.shared,
        decoder: JSONDecoder = JSONDecoder(),
        terminal: TerminalProtocol = Terminal.shared,
        system: SystemProtocol = System.shared
    ) {
        self.sampler = sampler
        self.signPost = signPost
        self.terminal = terminal
        self.system = system
        self.plistWriter = plistWriter
        self.textFileWriter = textFileWriter
        self.bridge = bridge
    }
    
    public struct Config
    {
        public let plist: FileProtocol
        public let xcconfig: FileProtocol
    }
    
}

// MARK: - Executable functions

extension Coder {
    
    public func attemptCode(to output: CoderOutputProtocol) throws -> CoderOutputProtocol
    {
        signPost.message(pretty_function() + " ...")
        do
        {
          
            try textFileWriter.writeIOSAndAndroidConfigFiles(from: sampler.jsonEnvironments, output: output)
            
            try writeFactory(to: output)
            try writeRNConfigurationModel(to: output)
            
            try plistWriter.writeRNConfigurationPlist(output: output, sampler: sampler)
            
            // TODO: write to header also
            try bridge.writeRNConfigurationBridge(to: output.ios.jsBridgeImplementation, sampler: sampler)
            signPost.message(pretty_function() + " ✅")
            return output
        }
        catch
        {
            signPost.message(pretty_function() + " ❌")
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }
    
}

// MARK: - Extensions

// MARK: - Writing Functions

// MARK: - Model

extension Coder {
    
    public func writeRNConfigurationModel(to output: CoderOutputProtocol) throws {
        
        var lines = Coder.modelDefault_TOP + Coder.modelDefault_BOTTOM
        
        guard sampler.configurationModelVar.count > 0 else {
            try output.ios.model.write(string: lines.replacingOccurrences(of: ", CustomStringConvertible", with: "")  + "\n}")
            return
        }
        
        lines = """
            \(Coder.modelDefault_TOP)
        
            // MARK: - Custom plist properties are added here
        
            \(sampler.configurationModelVar)
        
            public init(from decoder: Decoder) throws {
        
                let container = try decoder.container(keyedBy: CodingKeys.self)
        
                \(sampler.decoderInit)
                }
                \(Coder.modelDefault_BOTTOM)
        
                public var description: String {
                return \"""
                Configuration.swift read from Info.plist of RNConfiguration framework
        
                // Custom environment dependend constants from .env.<CONFIGURATION>.json
        
                \(sampler.configurationModelVarDescription)
                \"""
                }
            }
        
        """
        try output.ios.model.write(string: lines)
    }
    
    
    
    public static let modelDefault_TOP = """
    import Foundation
    import RNModels

    /**
        ⚠️ File is generated and ignored in git. To change it change /RNConfigurationHighwaySetup/main.swift
    */
    // sourcery:AutoMockable
    public protocol ModelProtocol {
        // sourcery:inline:Model.AutoGenerateProtocol
        // sourcery:end
    }
    
    // sourcery:AutoGenerateProtocol
    public struct Model: Codable, CustomStringConvertible, ModelProtocol {

    """
    public static let modelDefault_BOTTOM = """
         
        public static func create(from json: JSONEnvironment) throws -> ModelProtocol {
                let typed = json.typed ?? [String: TypedJsonEntry]()
    
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
    
                return try JSONDecoder().decode(Model.self, from: jsonTyped.data(using: .utf8)!)
        }
            
        public enum Error: Swift.Error {
            case invalidBool(forKey: String)
        }
    """
}

// MARK: - Factory

extension Coder {
    
    
    public static let factoryTop = """
    import Foundation
    import RNModels
    
    /**
     ⚠️ File is generated and ignored in git. To change it change /RNConfigurationHighwaySetup/main.swift
     */

    // sourcery:AutoObjcMockable
    public protocol FactoryProtocol
    {
        // sourcery:inline:Factory.AutoGenerateProtocol

        static func allValuesDictionary() throws -> [String: String]
        func allCustomKeys() -> [String]
        
        // sourcery:end
    }

    // sourcery:AutoGenerateProtocol
    @objc public class Factory: NSObject, FactoryProtocol
    {
        public static var infoDict: [String: Any]? = Bundle(for: Factory.self).infoDictionary
    """

    public func writeFactory(to output: CoderOutputProtocol) throws {
        
        var lines = Coder.factoryDefault
        
        guard sampler.casesForEnum.count > 0 else {
            try output.ios.model.write(string: lines)
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
        
                try Factory.allConstants().forEach { _case in
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
        
            \(sampler.casesForEnum)
        
            }
        
            /**
                Plist containing custom variables that are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
            */
            public static func readCurrentBuildConfiguration() throws ->  ModelProtocol {
        
                guard let infoDict = Factory.infoDict else {
                    throw Error.noInfoDictonary
                }
        
                let data = try JSONSerialization.data(withJSONObject: infoDict, options: .prettyPrinted)
        
                return try JSONDecoder().decode(Model.self, from: data)
            }
        
            /**
                If using swift use plist()
                In Objective-C you can access this dictionary containing all custom environment dependend keys.
                They are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
            */
            public static func allConstants() throws -> [Factory.Case: String] {
        
                var result = [Case: String]()
        
                let plist = try Factory.readCurrentBuildConfiguration() as! Model
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
        
        try output.ios.factory.write(string: lines)
    }
    
    public static let factoryDefault = """
    \(Coder.factoryTop)
        
        public enum Error: Swift.Error {
            case noInfoDictonary
            case infoDictionaryNotReadableAsDictionary
        }
        
        @objc public class func allValuesDictionary() throws -> [String : String] {
            
            var dict = [String : String]()
            
             try Factory.allConstants().forEach { _case in
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
        public static func readCurrentBuildConfiguration() throws ->  Model {
            
            guard let infoDict = Factory.infoDict else {
                throw Error.noInfoDictonary
            }
            
            let data = try JSONSerialization.data(withJSONObject: infoDict, options: .prettyPrinted)
            
            return try JSONDecoder().decode(Model.self, from: data)
        }
        
        /**
            If using swift use plist()
            In Objective-C you can access this dictionary containing all custom environment dependend keys.
            They are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
        */
        public static func allConstants() throws -> [Factory.Case: String] {
    
            guard let infoDict = Factory.infoDict else
            {
                throw Error.noInfoDictonary
            }
            var result = [Case: String]()
            
            let plist = try Factory.readCurrentBuildConfiguration(infoDict: infoDict)
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
