    import Foundation
    
    //⚠️ File is generated and ignored in git. To change it change /PrepareReactNativeconfig/main.swift
    public struct CurrentBuildConfiguration: Codable, CustomStringConvertible {

        public var description: String {
            return """
        Configuration.swift has nothing to show
        """
        }

        public static func create(from json: JSON) throws -> CurrentBuildConfiguration {
            let data = try JSONEncoder().encode(json)

            return try JSONDecoder().decode(CurrentBuildConfiguration.self, from: data)
        }

        enum Error: Swift.Error {
            case invalidBool(forKey: String)
        }

    }