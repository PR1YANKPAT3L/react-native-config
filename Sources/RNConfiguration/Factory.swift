import Foundation
import RNModels

/**
 ⚠️ File is generated and ignored in git. To change it change /RNConfigurationHighwaySetup/main.swift
 */

// sourcery:AutoObjcMockable
public protocol FactoryProtocol
{
    // sourcery:inline:Factory.AutoGenerateProtocol
    static var infoDict: [String: Any]? { get set }

    static func allValuesDictionary() throws -> [String: String]
    func allCustomKeys() -> [String]
    static func readCurrentBuildConfiguration() throws -> ModelProtocol
    static func allConstants() throws -> [Factory.Case: String]

    // sourcery:end
}

// sourcery:AutoGenerateProtocol
@objc public class Factory: NSObject, FactoryProtocol
{
    public static var infoDict: [String: Any]? = Bundle(for: Factory.self).infoDictionary

    public enum Error: Swift.Error
    {
        case noInfoDictonary
        case infoDictionaryNotReadableAsDictionary
    }

    @objc public class func allValuesDictionary() throws -> [String: String]
    {
        var dict = [String: String]()

        try Factory.allConstants().forEach
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
    public static func readCurrentBuildConfiguration() throws -> ModelProtocol
    {
        guard let infoDict = Factory.infoDict else
        {
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
    public static func allConstants() throws -> [Factory.Case: String]
    {
        var result = [Case: String]()

        let plist = try Factory.readCurrentBuildConfiguration() as! Model
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
