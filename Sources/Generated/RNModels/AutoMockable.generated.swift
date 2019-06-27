import Foundation
import RNModels
import SourceryAutoProtocols

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
 * JSONEnvironmentProtocol
 * JSONEnvironmentsProtocol
 * TypedJsonEntryProtocol
 * URLEscapedProtocol
 */

// MARK: - JSONEnvironmentProtocolMock

open class JSONEnvironmentProtocolMock: JSONEnvironmentProtocol
{
    public init() {}

    public var typed: [String: TypedJsonEntry]?
    public var booleans: [String: Bool]?

    // MARK: - <xcconfigEntry > - parameters

    public var xcconfigEntryForThrowableError: Error?
    public var xcconfigEntryForCallsCount = 0
    public var xcconfigEntryForCalled: Bool
    {
        return xcconfigEntryForCallsCount > 0
    }

    public var xcconfigEntryForReceived: Configuration?
    public var xcconfigEntryForReturnValue: String?

    // MARK: - <xcconfigEntry > - closure mocks

    public var xcconfigEntryForClosure: ((Configuration) throws -> String)?

    // MARK: - <xcconfigEntry > - method mocked

    open func xcconfigEntry(for configuration: Configuration) throws -> String
    {
        // <xcconfigEntry > - Throwable method implementation

        if let error = xcconfigEntryForThrowableError
        {
            throw error
        }

        xcconfigEntryForCallsCount += 1
        xcconfigEntryForReceived = configuration

        // <xcconfigEntry > - Return Value mock implementation

        guard let closureReturn = xcconfigEntryForClosure else
        {
            guard let returnValue = xcconfigEntryForReturnValue else
            {
                let message = """
                No returnValue implemented for xcconfigEntry(for:)
                arguments passed where
                \(xcconfigEntryForReceived!)
                """
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement String

                throw error
            }
            return returnValue
        }

        return try closureReturn(configuration)
    }

    // MARK: - <androidEnvEntry > - parameters

    public var androidEnvEntryThrowableError: Error?
    public var androidEnvEntryCallsCount = 0
    public var androidEnvEntryCalled: Bool
    {
        return androidEnvEntryCallsCount > 0
    }

    public var androidEnvEntryReturnValue: String?

    // MARK: - <androidEnvEntry > - closure mocks

    public var androidEnvEntryClosure: (() throws -> String)?

    // MARK: - <androidEnvEntry > - method mocked

    open func androidEnvEntry() throws -> String
    {
        // <androidEnvEntry > - Throwable method implementation

        if let error = androidEnvEntryThrowableError
        {
            throw error
        }

        androidEnvEntryCallsCount += 1

        // <androidEnvEntry > - Return Value mock implementation

        guard let closureReturn = androidEnvEntryClosure else
        {
            guard let returnValue = androidEnvEntryReturnValue else
            {
                let message = """
                No returnValue implemented for androidEnvEntry
                """
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement String

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }
}

// MARK: - JSONEnvironmentsProtocolMock

open class JSONEnvironmentsProtocolMock: JSONEnvironmentsProtocol
{
    public init() {}

    public var debug: JSONEnvironment
    {
        get { return underlyingDebug }
        set(value) { underlyingDebug = value }
    }

    public var underlyingDebug: JSONEnvironment!
    public var release: JSONEnvironment
    {
        get { return underlyingRelease }
        set(value) { underlyingRelease = value }
    }

    public var underlyingRelease: JSONEnvironment!
    public var local: JSONEnvironment
    {
        get { return underlyingLocal }
        set(value) { underlyingLocal = value }
    }

    public var underlyingLocal: JSONEnvironment!
    public var betaRelease: JSONEnvironment
    {
        get { return underlyingBetaRelease }
        set(value) { underlyingBetaRelease = value }
    }

    public var underlyingBetaRelease: JSONEnvironment!
    public var config: [RNModels.Configuration: JSONEnvironment] = [:]
}

// MARK: - TypedJsonEntryProtocolMock

open class TypedJsonEntryProtocolMock: TypedJsonEntryProtocol
{
    public init() {}

    public var value: String
    {
        get { return underlyingValue }
        set(value) { underlyingValue = value }
    }

    public var underlyingValue: String = "AutoMockable filled value"
    public var valueType: String
    {
        get { return underlyingValueType }
        set(value) { underlyingValueType = value }
    }

    public var underlyingValueType: String = "AutoMockable filled value"
    public var typedValue: TypedJsonEntry.PossibleTypes
    {
        get { return underlyingTypedValue }
        set(value) { underlyingTypedValue = value }
    }

    public var underlyingTypedValue: TypedJsonEntry.PossibleTypes!
}

// MARK: - URLEscapedProtocolMock

open class URLEscapedProtocolMock: URLEscapedProtocol
{
    public init() {}

    public var url: URL
    {
        get { return underlyingUrl }
        set(value) { underlyingUrl = value }
    }

    public var underlyingUrl: URL!

    // MARK: - <encode > - parameters

    public var encodeToThrowableError: Error?
    public var encodeToCallsCount = 0
    public var encodeToCalled: Bool
    {
        return encodeToCallsCount > 0
    }

    public var encodeToReceived: Encoder?

    // MARK: - <encode > - closure mocks

    public var encodeToClosure: ((Encoder) throws -> Void)?

    // MARK: - <encode > - method mocked

    open func encode(to encoder: Encoder) throws
    {
        // <encode > - Throwable method implementation

        if let error = encodeToThrowableError
        {
            throw error
        }

        encodeToCallsCount += 1
        encodeToReceived = encoder

        // <encode > - Void return mock implementation

        try encodeToClosure?(encoder)
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
