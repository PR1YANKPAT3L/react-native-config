import Foundation
import RNModels
import SourceryAutoProtocols

/**
 ⚠️ File is generated and ignored in git. To change it change /RNConfigurationHighwaySetup/main.swift
 */

public protocol RNConfigurationModelFactoryProtocol: AutoObjcMockable
{
    // sourcery:inline:RNConfigurationModelFactory.AutoGenerateProtocol
    static var infoDict: [String: Any]? { get set }

    static func allValuesDictionary() throws -> [String: String]
    func allCustomKeys() -> [String]
    static func readCurrentBuildConfiguration() throws -> RNConfigurationModelProtocol
    static func allConstants() throws -> [RNConfigurationModelFactory.Case: String]

    // sourcery:end
}

@objc public class RNConfigurationModelFactory: NSObject, RNConfigurationModelFactoryProtocol, AutoGenerateProtocol
{
    public static var infoDict: [String: Any]? = Bundle(for: RNConfigurationModelFactory.self).infoDictionary

    public enum Error: Swift.Error
    {
        case noInfoDictonary
        case infoDictionaryNotReadableAsDictionary
    }

    @objc public class func allValuesDictionary() throws -> [String: String]
    {
        var dict = [String: String]()

        try RNConfigurationModelFactory.allConstants().forEach
        { _case in
            dict[_case.key.rawValue] = _case.value
        }
        return dict
    }

    /**
     All custom environment dependend keys that are added to the plist and in the dictionary
     */
    @objc public func allCustomKeys() -> [String]
    {
        return Case.allCases.map { $0.rawValue }
    }

    /**
     Keys used in the plist of RNConfiguration module when building for the selected configuration (Debug or Release)
     */
    public enum Case: String, CaseIterable
    {
        case exampleBool
        case example_url
    }

    /**
     Plist containing custom variables that are set from the .env.debug.json or .env.release.json dependend on the configuration you build for.
     */
    public static func readCurrentBuildConfiguration() throws -> RNConfigurationModelProtocol
    {
        guard let infoDict = RNConfigurationModelFactory.infoDict else
        {
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
    public static func allConstants() throws -> [RNConfigurationModelFactory.Case: String]
    {
        var result = [Case: String]()

        let plist = try RNConfigurationModelFactory.readCurrentBuildConfiguration() as! RNConfigurationModel
        let data = try JSONEncoder().encode(plist)

        guard let dict: [String: String] = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: String] else
        {
            throw Error.infoDictionaryNotReadableAsDictionary
        }

        dict.forEach
        {
            guard let key = Case(rawValue: $0.key) else
            {
                return
            }
            result[key] = $0.value
        }

        return result
    }
}
