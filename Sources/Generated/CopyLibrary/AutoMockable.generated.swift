import CoderLibrary
import CopyLibrary
import Foundation
import Terminal
import ZFile

// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - CopyProtocolMock

open class CopyProtocolMock: CopyProtocol
{
    public init() {}

    // MARK: - <copy> - parameters

    public var copyToCopyToFolderNameThrowableError: Error?
    public var copyToCopyToFolderNameCallsCount = 0
    public var copyToCopyToFolderNameCalled: Bool
    {
        return copyToCopyToFolderNameCallsCount > 0
    }

    public var copyToCopyToFolderNameReceivedArguments: (yourSrcRoot: FolderProtocol, copyToFolderName: String)?

    // MARK: - <copy> - closure mocks

    public var copyToCopyToFolderNameClosure: ((FolderProtocol, String) throws -> Void)?

    // MARK: - <copy> - method mocked

    open func copy(to yourSrcRoot: FolderProtocol, copyToFolderName: String) throws
    {
        // <copy> - Throwable method implementation

        if let error = copyToCopyToFolderNameThrowableError
        {
            throw error
        }

        copyToCopyToFolderNameCallsCount += 1
        copyToCopyToFolderNameReceivedArguments = (yourSrcRoot: yourSrcRoot, copyToFolderName: copyToFolderName)

        // <copy> - Void return mock implementation

        try copyToCopyToFolderNameClosure?(yourSrcRoot, copyToFolderName)
    }
}

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
