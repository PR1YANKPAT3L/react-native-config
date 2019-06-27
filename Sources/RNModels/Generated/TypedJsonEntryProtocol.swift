import Foundation
import SourceryAutoProtocols

// DO NOT EDIT

// sourcery:AutoMockable
public protocol TypedJsonEntryProtocol
{
    var value: String { get }
    var valueType: String { get }
    var typedValue: TypedJsonEntry.PossibleTypes { get }
}

extension TypedJsonEntryProtocol
{}
