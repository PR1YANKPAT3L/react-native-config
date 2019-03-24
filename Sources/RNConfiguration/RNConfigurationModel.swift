    import Foundation
    import RNModels

    //⚠️ File is generated and ignored in git. To change it change /RNConfigurationHighwaySetup/main.swift
    public struct RNConfigurationModel: Codable, CustomStringConvertible {


    // MARK: - Custom plist properties are added here

    public let BE_BOLIDES_BASE_URL: URLEscaped
    public let BE_BOLIDES_EXPO_RELEASE_CHANNEL: String
    public let BE_BOLIDES_EXPO_RELEASE_MANIFEST_URL: URLEscaped
    public let BE_BOLIDES_ITSME_SECURE_KEY: String
    public let ONESIGNAL_APP_ID: String

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

         BE_BOLIDES_BASE_URL = try container.decode(URLEscaped.self, forKey: .BE_BOLIDES_BASE_URL)
         BE_BOLIDES_EXPO_RELEASE_CHANNEL = try container.decode(String.self, forKey: .BE_BOLIDES_EXPO_RELEASE_CHANNEL)
         BE_BOLIDES_EXPO_RELEASE_MANIFEST_URL = try container.decode(URLEscaped.self, forKey: .BE_BOLIDES_EXPO_RELEASE_MANIFEST_URL)
         BE_BOLIDES_ITSME_SECURE_KEY = try container.decode(String.self, forKey: .BE_BOLIDES_ITSME_SECURE_KEY)
         ONESIGNAL_APP_ID = try container.decode(String.self, forKey: .ONESIGNAL_APP_ID)
    }
     
    public static func create(from json: JSON) throws -> RNConfigurationModel {
            let typed = json.typed ?? [String: JSONEntry]()

            var jsonTyped = "{"

            jsonTyped.append(contentsOf: typed.compactMap {
            return "\"\($0.key)\": \"\($0.value.value)\","
            }.joined(separator: "\n"))

            if let jsonBooleans = (
            json.booleans?
            .compactMap { return "\"\($0.key)\": \"\($0.value)\"," }
            .joined(separator: "\n")) {

            jsonTyped.append(contentsOf: jsonBooleans)

            }

            if jsonTyped.count > 1 { jsonTyped.removeLast() }

            jsonTyped.append(contentsOf: "}")

            return try JSONDecoder().decode(RNConfigurationModel.self, from: jsonTyped.data(using: .utf8)!)
    }
        
    public enum Error: Swift.Error {
        case invalidBool(forKey: String)
    }

    public var description: String {
        return """
        Configuration.swift read from Info.plist of RNConfiguration framework

        // Custom environment dependend constants from .env.<CONFIGURATION>.json

                    * BE_BOLIDES_BASE_URL: \(BE_BOLIDES_BASE_URL)
            * BE_BOLIDES_EXPO_RELEASE_CHANNEL: \(BE_BOLIDES_EXPO_RELEASE_CHANNEL)
            * BE_BOLIDES_EXPO_RELEASE_MANIFEST_URL: \(BE_BOLIDES_EXPO_RELEASE_MANIFEST_URL)
            * BE_BOLIDES_ITSME_SECURE_KEY: \(BE_BOLIDES_ITSME_SECURE_KEY)
            * ONESIGNAL_APP_ID: \(ONESIGNAL_APP_ID)
        """
    }
}
