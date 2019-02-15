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

      case BE_BOLIDES_RELEASE_CHANNEL
      case BOLIDES_ITSME_SECURE_KEY
      case BOLIDES_BASE_URL
      case ONESIGNAL_APP_ID

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
