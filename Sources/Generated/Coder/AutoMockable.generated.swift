import Coder
import CoderLibrary
import Foundation
import HighwayLibrary
import RNModels
import SignPost
import Terminal
import ZFile

// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

/**
 # Protocols that mocks where generated for
 * AutoCases
 * AutoEquatable
 * AutoGenerateProtocol
 * AutoGenerateSelectiveProtocol
 * AutoMockable
 * AutoObjcMockable
 */

// MARK: - OBJECTIVE-C

// MARK: - Sourcery Errors

public enum SourceryMockError: Swift.Error, Hashable
{
    case implementErrorCaseFor(String)
    case subclassMockBeforeUsing(String)

    public var debugDescription: String
    {
        switch self
        {
        case let .implementErrorCaseFor(message):
            return """
            🧙‍♂️ SourceryMockError.implementErrorCaseFor:
            message: \(message)
            """
        case let .subclassMockBeforeUsing(message):
            return """
            \n
            🧙‍♂️ SourceryMockError.subclassMockBeforeUsing:
            message: \(message)
            """
        }
    }
}
