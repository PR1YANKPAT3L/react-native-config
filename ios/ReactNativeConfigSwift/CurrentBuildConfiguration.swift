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
    public let hasConfiguration: Bool

    public var description: String {
        return """
            Configuration.swift read from Info.plist of ReactNativeConfigSwift framework

            // Custom environment dependend constants from .env.<CONFIGURATION>.json

            * hasConfiguration: \(hasConfiguration)
            """
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

         
        guard let hasConfiguration = Bool(try container.decode(String.self, forKey: .hasConfiguration)) else { throw Error.invalidBool(forKey: "hasConfiguration")}

        self.hasConfiguration = hasConfiguration

    }

    public static func create(from json: JSON) throws -> CurrentBuildConfiguration {
        let data = try JSONEncoder().encode(json)

        return try JSONDecoder().decode(CurrentBuildConfiguration.self, from: data)
    }

    enum Error: Swift.Error {
        case invalidBool(forKey: String)
    }

}


