    import Foundation
    import RNModels

    //⚠️ File is generated and ignored in git. To change it change /PrepareReactNativeconfig/main.swift
    public struct RNConfigurationModel: Codable {
     
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
}