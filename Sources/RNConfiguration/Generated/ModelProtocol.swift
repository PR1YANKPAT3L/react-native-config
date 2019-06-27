import Foundation
import RNModels
import SourceryAutoProtocols

// DO NOT EDIT

// sourcery:AutoMockable
public protocol ModelProtocol
{
    var exampleBool: Bool { get }
    var example_url: URLEscaped { get }
    var description: String { get }

    static func create(from json: JSONEnvironment) throws -> ModelProtocol
}

extension ModelProtocol
{}
