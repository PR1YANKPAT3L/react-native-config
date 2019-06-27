import Foundation
import RNModels
import SourceryAutoProtocols

// DO NOT EDIT

// sourcery:AutoMockable
public protocol FactoryProtocol: AnyObject
{
    static var infoDict: [String: Any]? { get set }

    static func allValuesDictionary() throws -> [String: String]

    func allCustomKeys() -> [String]

    static func readCurrentBuildConfiguration() throws -> ModelProtocol

    static func allConstants() throws -> [Factory.Case: String]
}

extension FactoryProtocol
{}
