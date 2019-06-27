import Foundation
import SourceryAutoProtocols

// DO NOT EDIT

// sourcery:AutoMockable
public protocol JSONEnvironmentProtocol
{
    var typed: [String: TypedJsonEntry]? { get }
    var booleans: [String: Bool]? { get }

    func xcconfigEntry(for configuration: Configuration) throws -> String

    func androidEnvEntry() throws -> String
}

extension JSONEnvironmentProtocol
{}
