import Foundation
import RNModels
import SourceryAutoProtocols

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - EnvJSONsProtocolMock

open class EnvJSONsProtocolMock: EnvJSONsProtocol
{
    public init() {}

    public var debug: JSONProtocol
    {
        get { return underlyingDebug }
        set(value) { underlyingDebug = value }
    }

    public var underlyingDebug: JSONProtocol!
    public var release: JSONProtocol
    {
        get { return underlyingRelease }
        set(value) { underlyingRelease = value }
    }

    public var underlyingRelease: JSONProtocol!
    public var local: JSONProtocol?
    public var betaRelease: JSONProtocol?
}

// MARK: - JSONProtocolMock

open class JSONProtocolMock: JSONProtocol
{
    public init() {}

    public var typed: [String: JSONEntry]?
    public var booleans: [String: Bool]?

    // MARK: - <xcconfigEntry> - parameters

    public var xcconfigEntryForThrowableError: Error?
    public var xcconfigEntryForCallsCount = 0
    public var xcconfigEntryForCalled: Bool
    {
        return xcconfigEntryForCallsCount > 0
    }

    public var xcconfigEntryForReceivedConfiguration: Configuration?
    public var xcconfigEntryForReturnValue: String?

    // MARK: - <xcconfigEntry> - closure mocks

    public var xcconfigEntryForClosure: ((Configuration) throws -> String)?

    // MARK: - <xcconfigEntry> - method mocked

    open func xcconfigEntry(for configuration: Configuration) throws -> String
    {
        // <xcconfigEntry> - Throwable method implementation

        if let error = xcconfigEntryForThrowableError
        {
            throw error
        }

        xcconfigEntryForCallsCount += 1
        xcconfigEntryForReceivedConfiguration = configuration

        // <xcconfigEntry> - Return Value mock implementation

        guard let closureReturn = xcconfigEntryForClosure else
        {
            guard let returnValue = xcconfigEntryForReturnValue else
            {
                let message = "No returnValue implemented for xcconfigEntryForClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement String

                throw error
            }
            return returnValue
        }

        return try closureReturn(configuration)
    }

    // MARK: - <androidEnvEntry> - parameters

    public var androidEnvEntryThrowableError: Error?
    public var androidEnvEntryCallsCount = 0
    public var androidEnvEntryCalled: Bool
    {
        return androidEnvEntryCallsCount > 0
    }

    public var androidEnvEntryReturnValue: String?

    // MARK: - <androidEnvEntry> - closure mocks

    public var androidEnvEntryClosure: (() throws -> String)?

    // MARK: - <androidEnvEntry> - method mocked

    open func androidEnvEntry() throws -> String
    {
        // <androidEnvEntry> - Throwable method implementation

        if let error = androidEnvEntryThrowableError
        {
            throw error
        }

        androidEnvEntryCallsCount += 1

        // <androidEnvEntry> - Return Value mock implementation

        guard let closureReturn = androidEnvEntryClosure else
        {
            guard let returnValue = androidEnvEntryReturnValue else
            {
                let message = "No returnValue implemented for androidEnvEntryClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement String

                throw error
            }
            return returnValue
        }

        return try closureReturn()
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
