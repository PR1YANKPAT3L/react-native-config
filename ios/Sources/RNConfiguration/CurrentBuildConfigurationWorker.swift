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
