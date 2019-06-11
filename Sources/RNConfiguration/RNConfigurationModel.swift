import Foundation
import RNModels
import SourceryAutoProtocols

/**
 ⚠️ File is generated and ignored in git. To change it change /RNConfigurationHighwaySetup/main.swift
 */

public protocol RNConfigurationModelProtocol: AutoMockable
{
    // sourcery:inline:RNConfigurationModel.AutoGenerateProtocol
    var exampleBool: Bool { get }
    var example_url: URLEscaped { get }
    var description: String { get }

    static func create(from json: JSON) throws -> RNConfigurationModelProtocol
    // sourcery:end
}

public struct RNConfigurationModel: Codable, CustomStringConvertible, RNConfigurationModelProtocol, AutoGenerateProtocol
{
    // MARK: - Custom plist properties are added here

    public let exampleBool: Bool
    public let example_url: URLEscaped

    public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let exampleBool = Bool(try container.decode(String.self, forKey: .exampleBool)) else { throw Error.invalidBool(forKey: "exampleBool") }

        self.exampleBool = exampleBool
        example_url = try container.decode(URLEscaped.self, forKey: .example_url)
    }

    public static func create(from json: JSON) throws -> RNConfigurationModelProtocol
    {
        let typed = json.typed ?? [String: JSONEntry]()

        var jsonTyped = "{"

        jsonTyped.append(
            contentsOf: typed.compactMap
            {
                "\"\($0.key)\": \"\($0.value.value)\","
            }.joined(separator: "\n")
        )

        if let jsonBooleans = (
            json.booleans?
                .compactMap { "\"\($0.key)\": \"\($0.value)\"," }
                .joined(separator: "\n"))
        {
            jsonTyped.append(contentsOf: jsonBooleans)
        }

        if jsonTyped.count > 1 { jsonTyped.removeLast() }

        jsonTyped.append(contentsOf: "}")

        return try JSONDecoder().decode(RNConfigurationModel.self, from: jsonTyped.data(using: .utf8)!)
    }

    public enum Error: Swift.Error
    {
        case invalidBool(forKey: String)
    }

    public var description: String
    {
        return """
        Configuration.swift read from Info.plist of RNConfiguration framework

        // Custom environment dependend constants from .env.<CONFIGURATION>.json

                    * exampleBool: \(exampleBool)
            * example_url: \(example_url)
        """
    }
}
