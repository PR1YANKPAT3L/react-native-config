//
//  Configuration.swift
//  ReactNativeConfigSwift
//
//  Created by Stijn on 30/01/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation

//⚠️ File is generated and ignored in git. To change it change /PrepareReactNativeconfig/main.swift

public struct CurrentBuildConfiguration: Codable, CustomStringConvertible {

    // Custom plist properties are added here
    public let BE_BOLIDES_RELEASE_CHANNEL: String
    public let BE_BOLIDES_RELEASE_MANIFEST_URL: URLEscaped
    public let BE_BOLIDES_SHOULD_OVERRIDE_MANIFEST_URL: Bool
    public let BOLIDES_BASE_URL: URLEscaped
    public let BOLIDES_ITSME_SECURE_KEY: String
    public let ONESIGNAL_APP_ID: String

    public var description: String {
        return """
            Configuration.swift read from Info.plist of ReactNativeConfigSwift framework

            // Custom environment dependend constants from .env.<CONFIGURATION>.json

            * BE_BOLIDES_RELEASE_CHANNEL: \(BE_BOLIDES_RELEASE_CHANNEL)
            * BE_BOLIDES_RELEASE_MANIFEST_URL: \(BE_BOLIDES_RELEASE_MANIFEST_URL)
            * BE_BOLIDES_SHOULD_OVERRIDE_MANIFEST_URL: \(BE_BOLIDES_SHOULD_OVERRIDE_MANIFEST_URL)
            * BOLIDES_BASE_URL: \(BOLIDES_BASE_URL)
            * BOLIDES_ITSME_SECURE_KEY: \(BOLIDES_ITSME_SECURE_KEY)
            * ONESIGNAL_APP_ID: \(ONESIGNAL_APP_ID)
            """
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

         
        guard let BE_BOLIDES_SHOULD_OVERRIDE_MANIFEST_URL = Bool(try container.decode(String.self, forKey: .BE_BOLIDES_SHOULD_OVERRIDE_MANIFEST_URL)) else { throw Error.invalidBool(forKey: "BE_BOLIDES_SHOULD_OVERRIDE_MANIFEST_URL")}

        self.BE_BOLIDES_SHOULD_OVERRIDE_MANIFEST_URL = BE_BOLIDES_SHOULD_OVERRIDE_MANIFEST_URL
         BE_BOLIDES_RELEASE_CHANNEL = try container.decode(String.self, forKey: .BE_BOLIDES_RELEASE_CHANNEL)
         BE_BOLIDES_RELEASE_MANIFEST_URL = try container.decode(URLEscaped.self, forKey: .BE_BOLIDES_RELEASE_MANIFEST_URL)
         BOLIDES_BASE_URL = try container.decode(URLEscaped.self, forKey: .BOLIDES_BASE_URL)
         BOLIDES_ITSME_SECURE_KEY = try container.decode(String.self, forKey: .BOLIDES_ITSME_SECURE_KEY)
         ONESIGNAL_APP_ID = try container.decode(String.self, forKey: .ONESIGNAL_APP_ID)

    }

    public static func create(from json: JSON) throws -> CurrentBuildConfiguration {
        let data = try JSONEncoder().encode(json)

        return try JSONDecoder().decode(CurrentBuildConfiguration.self, from: data)
    }

    enum Error: Swift.Error {
        case invalidBool(forKey: String)
    }

}


