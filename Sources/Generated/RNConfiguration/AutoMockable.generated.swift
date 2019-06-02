import Foundation
import RNConfiguration
import RNModels
import SourceryAutoProtocols

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - RNConfigurationModelProtocolMock

open class RNConfigurationModelProtocolMock: RNConfigurationModelProtocol
{
    public init() {}

    public var exampleBool: Bool
    {
        get { return underlyingExampleBool }
        set(value) { underlyingExampleBool = value }
    }

    public var underlyingExampleBool: Bool = false
    public var example_url: URLEscaped
    {
        get { return underlyingExample_url }
        set(value) { underlyingExample_url = value }
    }

    public var underlyingExample_url: URLEscaped!
    public var description: String
    {
        get { return underlyingDescription }
        set(value) { underlyingDescription = value }
    }

    public var underlyingDescription: String = "AutoMockable filled value"

    // MARK: - <create> - parameters

    public static var createFromThrowableError: Error?
    public static var createFromCallsCount = 0
    public static var createFromCalled: Bool
    {
        return createFromCallsCount > 0
    }

    public static var createFromReceivedJson: JSON?
    public static var createFromReturnValue: RNConfigurationModelProtocol?

    // MARK: - <create> - closure mocks

    public static var createFromClosure: ((JSON) throws -> RNConfigurationModelProtocol)?

    // MARK: - <create> - method mocked

    public static func create(from json: JSON) throws -> RNConfigurationModelProtocol
    {
        // <create> - Throwable method implementation

        if let error = createFromThrowableError
        {
            throw error
        }

        createFromCallsCount += 1
        createFromReceivedJson = json

        // <create> - Return Value mock implementation

        guard let closureReturn = createFromClosure else
        {
            guard let returnValue = createFromReturnValue else
            {
                let message = "No returnValue implemented for createFromClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement RNConfigurationModelProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn(json)
    }
}

// MARK: - OBJECTIVE-C

// MARK: - RNConfigurationModelFactoryProtocolMock

open class RNConfigurationModelFactoryProtocolMock: NSObject, RNConfigurationModelFactoryProtocol
{
    public override init() { super.init() }

    public static var infoDict: [String: Any]?

    // MARK: - <allValuesDictionary> - parameters

    public static var allValuesDictionaryThrowableError: Error?
    public static var allValuesDictionaryCallsCount = 0
    public static var allValuesDictionaryCalled: Bool
    {
        return allValuesDictionaryCallsCount > 0
    }

    public static var allValuesDictionaryReturnValue: [String: String]?

    // MARK: - <allValuesDictionary> - closure mocks

    public static var allValuesDictionaryClosure: (() throws -> [String: String])?

    // MARK: - <allValuesDictionary> - method mocked

    public static func allValuesDictionary() throws -> [String: String]
    {
        // <allValuesDictionary> - Throwable method implementation

        if let error = allValuesDictionaryThrowableError
        {
            throw error
        }

        allValuesDictionaryCallsCount += 1

        // <allValuesDictionary> - Return Value mock implementation

        guard let closureReturn = allValuesDictionaryClosure else
        {
            guard let returnValue = allValuesDictionaryReturnValue else
            {
                let message = "No returnValue implemented for allValuesDictionaryClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [String : String]

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <allCustomKeys> - parameters

    public var allCustomKeysCallsCount = 0
    public var allCustomKeysCalled: Bool
    {
        return allCustomKeysCallsCount > 0
    }

    public var allCustomKeysReturnValue: [String]?

    // MARK: - <allCustomKeys> - closure mocks

    public var allCustomKeysClosure: (() -> [String])?

    // MARK: - <allCustomKeys> - method mocked

    open func allCustomKeys() -> [String]
    {
        allCustomKeysCallsCount += 1

        // <allCustomKeys> - Return Value mock implementation

        guard let closureReturn = allCustomKeysClosure else
        {
            guard let returnValue = allCustomKeysReturnValue else
            {
                let message = "No returnValue implemented for allCustomKeysClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [String]

                print("❌ \(error)")

                fatalError("\(self) \(#function) should be mocked with return value or be able to throw")
            }
            return returnValue
        }

        return closureReturn()
    }

    // MARK: - <readCurrentBuildConfiguration> - parameters

    public static var readCurrentBuildConfigurationThrowableError: Error?
    public static var readCurrentBuildConfigurationCallsCount = 0
    public static var readCurrentBuildConfigurationCalled: Bool
    {
        return readCurrentBuildConfigurationCallsCount > 0
    }

    public static var readCurrentBuildConfigurationReturnValue: RNConfigurationModelProtocol?

    // MARK: - <readCurrentBuildConfiguration> - closure mocks

    public static var readCurrentBuildConfigurationClosure: (() throws -> RNConfigurationModelProtocol)?

    // MARK: - <readCurrentBuildConfiguration> - method mocked

    public static func readCurrentBuildConfiguration() throws -> RNConfigurationModelProtocol
    {
        // <readCurrentBuildConfiguration> - Throwable method implementation

        if let error = readCurrentBuildConfigurationThrowableError
        {
            throw error
        }

        readCurrentBuildConfigurationCallsCount += 1

        // <readCurrentBuildConfiguration> - Return Value mock implementation

        guard let closureReturn = readCurrentBuildConfigurationClosure else
        {
            guard let returnValue = readCurrentBuildConfigurationReturnValue else
            {
                let message = "No returnValue implemented for readCurrentBuildConfigurationClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement RNConfigurationModelProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <allConstants> - parameters

    public static var allConstantsThrowableError: Error?
    public static var allConstantsCallsCount = 0
    public static var allConstantsCalled: Bool
    {
        return allConstantsCallsCount > 0
    }

    public static var allConstantsReturnValue: [RNConfigurationModelFactory.Case: String]?

    // MARK: - <allConstants> - closure mocks

    public static var allConstantsClosure: (() throws -> [RNConfigurationModelFactory.Case: String])?

    // MARK: - <allConstants> - method mocked

    public static func allConstants() throws -> [RNConfigurationModelFactory.Case: String]
    {
        // <allConstants> - Throwable method implementation

        if let error = allConstantsThrowableError
        {
            throw error
        }

        allConstantsCallsCount += 1

        // <allConstants> - Return Value mock implementation

        guard let closureReturn = allConstantsClosure else
        {
            guard let returnValue = allConstantsReturnValue else
            {
                let message = "No returnValue implemented for allConstantsClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [RNConfigurationModelFactory.Case: String]

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }
}

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
