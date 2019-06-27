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
 * CoderOutputAndroidProtocol
 * CoderOutputProtocol
 * CoderOutputiOSProtocol
 * CoderProtocol
 * JSBridgeCodeSampleProtocol
 * JSONToCodeSamplerProtocol
 * PlatformSpecificConfigurationWriterProtocol
 * PlistWriterProtocol
 */

// MARK: - CoderOutputAndroidProtocolMock

open class CoderOutputAndroidProtocolMock: CoderOutputAndroidProtocol
{
    public init() {}

    public var sourcesFolder: FolderProtocol
    {
        get { return underlyingSourcesFolder }
        set(value) { underlyingSourcesFolder = value }
    }

    public var underlyingSourcesFolder: FolderProtocol!
    public var configFiles: [RNModels.Configuration: FileProtocol] = [:]
}

// MARK: - CoderOutputProtocolMock

open class CoderOutputProtocolMock: CoderOutputProtocol
{
    public init() {}

    public var android: CoderOutputAndroidProtocol
    {
        get { return underlyingAndroid }
        set(value) { underlyingAndroid = value }
    }

    public var underlyingAndroid: CoderOutputAndroidProtocol!
    public var ios: CoderOutputiOSProtocol
    {
        get { return underlyingIos }
        set(value) { underlyingIos = value }
    }

    public var underlyingIos: CoderOutputiOSProtocol!
}

// MARK: - CoderOutputiOSProtocolMock

open class CoderOutputiOSProtocolMock: CoderOutputiOSProtocol
{
    public init() {}

    public var sourcesFolder: FolderProtocol
    {
        get { return underlyingSourcesFolder }
        set(value) { underlyingSourcesFolder = value }
    }

    public var underlyingSourcesFolder: FolderProtocol!
    public var xcconfigFile: FileProtocol
    {
        get { return underlyingXcconfigFile }
        set(value) { underlyingXcconfigFile = value }
    }

    public var underlyingXcconfigFile: FileProtocol!
    public var factory: FileProtocol
    {
        get { return underlyingFactory }
        set(value) { underlyingFactory = value }
    }

    public var underlyingFactory: FileProtocol!
    public var model: FileProtocol
    {
        get { return underlyingModel }
        set(value) { underlyingModel = value }
    }

    public var underlyingModel: FileProtocol!
    public var plists: [FileProtocol] = []
    public var jsBridgeHeader: FileProtocol
    {
        get { return underlyingJsBridgeHeader }
        set(value) { underlyingJsBridgeHeader = value }
    }

    public var underlyingJsBridgeHeader: FileProtocol!
    public var jsBridgeImplementation: FileProtocol
    {
        get { return underlyingJsBridgeImplementation }
        set(value) { underlyingJsBridgeImplementation = value }
    }

    public var underlyingJsBridgeImplementation: FileProtocol!
}

// MARK: - CoderProtocolMock

open class CoderProtocolMock: CoderProtocol
{
    public init() {}

    public static var modelDefault_TOP: String
    {
        get { return underlyingModelDefault_TOP }
        set(value) { underlyingModelDefault_TOP = value }
    }

    public static var underlyingModelDefault_TOP: String = "AutoMockable filled value"
    public static var modelDefault_BOTTOM: String
    {
        get { return underlyingModelDefault_BOTTOM }
        set(value) { underlyingModelDefault_BOTTOM = value }
    }

    public static var underlyingModelDefault_BOTTOM: String = "AutoMockable filled value"
    public static var factoryTop: String
    {
        get { return underlyingFactoryTop }
        set(value) { underlyingFactoryTop = value }
    }

    public static var underlyingFactoryTop: String = "AutoMockable filled value"
    public static var factoryDefault: String
    {
        get { return underlyingFactoryDefault }
        set(value) { underlyingFactoryDefault = value }
    }

    public static var underlyingFactoryDefault: String = "AutoMockable filled value"

    // MARK: - <attemptCode > - parameters

    public var attemptCodeToThrowableError: Error?
    public var attemptCodeToCallsCount = 0
    public var attemptCodeToCalled: Bool
    {
        return attemptCodeToCallsCount > 0
    }

    public var attemptCodeToReceived: CoderOutputProtocol?
    public var attemptCodeToReturnValue: CoderOutputProtocol?

    // MARK: - <attemptCode > - closure mocks

    public var attemptCodeToClosure: ((CoderOutputProtocol) throws -> CoderOutputProtocol)?

    // MARK: - <attemptCode > - method mocked

    open func attemptCode(to output: CoderOutputProtocol) throws -> CoderOutputProtocol
    {
        // <attemptCode > - Throwable method implementation

        if let error = attemptCodeToThrowableError
        {
            throw error
        }

        attemptCodeToCallsCount += 1
        attemptCodeToReceived = output

        // <attemptCode > - Return Value mock implementation

        guard let closureReturn = attemptCodeToClosure else
        {
            guard let returnValue = attemptCodeToReturnValue else
            {
                let message = """
                No returnValue implemented for attemptCode(to:)
                arguments passed where
                \(attemptCodeToReceived!)
                """
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement CoderOutputProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn(output)
    }

    // MARK: - <writeModel > - parameters

    public var writeModelToThrowableError: Error?
    public var writeModelToCallsCount = 0
    public var writeModelToCalled: Bool
    {
        return writeModelToCallsCount > 0
    }

    public var writeModelToReceived: CoderOutputProtocol?

    // MARK: - <writeModel > - closure mocks

    public var writeModelToClosure: ((CoderOutputProtocol) throws -> Void)?

    // MARK: - <writeModel > - method mocked

    open func writeModel(to output: CoderOutputProtocol) throws
    {
        // <writeModel > - Throwable method implementation

        if let error = writeModelToThrowableError
        {
            throw error
        }

        writeModelToCallsCount += 1
        writeModelToReceived = output

        // <writeModel > - Void return mock implementation

        try writeModelToClosure?(output)
    }

    // MARK: - <writeFactory > - parameters

    public var writeFactoryToThrowableError: Error?
    public var writeFactoryToCallsCount = 0
    public var writeFactoryToCalled: Bool
    {
        return writeFactoryToCallsCount > 0
    }

    public var writeFactoryToReceived: CoderOutputProtocol?

    // MARK: - <writeFactory > - closure mocks

    public var writeFactoryToClosure: ((CoderOutputProtocol) throws -> Void)?

    // MARK: - <writeFactory > - method mocked

    open func writeFactory(to output: CoderOutputProtocol) throws
    {
        // <writeFactory > - Throwable method implementation

        if let error = writeFactoryToThrowableError
        {
            throw error
        }

        writeFactoryToCallsCount += 1
        writeFactoryToReceived = output

        // <writeFactory > - Void return mock implementation

        try writeFactoryToClosure?(output)
    }
}

// MARK: - JSBridgeCodeSampleProtocolMock

open class JSBridgeCodeSampleProtocolMock: JSBridgeCodeSampleProtocol
{
    public init() {}

    // MARK: - <writeBridge > - parameters

    public var writeBridgeToSamplerThrowableError: Error?
    public var writeBridgeToSamplerCallsCount = 0
    public var writeBridgeToSamplerCalled: Bool
    {
        return writeBridgeToSamplerCallsCount > 0
    }

    public var writeBridgeToSamplerReceivedArguments: (file: FileProtocol, sampler: JSONToCodeSamplerProtocol)?

    // MARK: - <writeBridge > - closure mocks

    public var writeBridgeToSamplerClosure: ((FileProtocol, JSONToCodeSamplerProtocol) throws -> Void)?

    // MARK: - <writeBridge > - method mocked

    open func writeBridge(to file: FileProtocol, sampler: JSONToCodeSamplerProtocol) throws
    {
        // <writeBridge > - Throwable method implementation

        if let error = writeBridgeToSamplerThrowableError
        {
            throw error
        }

        writeBridgeToSamplerCallsCount += 1
        writeBridgeToSamplerReceivedArguments = (file: file, sampler: sampler)

        // <writeBridge > - Void return mock implementation

        try writeBridgeToSamplerClosure?(file, sampler)
    }
}

// MARK: - JSONToCodeSamplerProtocolMock

open class JSONToCodeSamplerProtocolMock: JSONToCodeSamplerProtocol
{
    public init() {}

    public var jsonEnvironments: JSONEnvironmentsProtocol
    {
        get { return underlyingJsonEnvironments }
        set(value) { underlyingJsonEnvironments = value }
    }

    public var underlyingJsonEnvironments: JSONEnvironmentsProtocol!
    public var casesForEnum: String
    {
        get { return underlyingCasesForEnum }
        set(value) { underlyingCasesForEnum = value }
    }

    public var underlyingCasesForEnum: String = "AutoMockable filled value"
    public var configurationModelVar: String
    {
        get { return underlyingConfigurationModelVar }
        set(value) { underlyingConfigurationModelVar = value }
    }

    public var underlyingConfigurationModelVar: String = "AutoMockable filled value"
    public var configurationModelVarDescription: String
    {
        get { return underlyingConfigurationModelVarDescription }
        set(value) { underlyingConfigurationModelVarDescription = value }
    }

    public var underlyingConfigurationModelVarDescription: String = "AutoMockable filled value"
    public var plistLinesXmlText: String
    {
        get { return underlyingPlistLinesXmlText }
        set(value) { underlyingPlistLinesXmlText = value }
    }

    public var underlyingPlistLinesXmlText: String = "AutoMockable filled value"
    public var decoderInit: String
    {
        get { return underlyingDecoderInit }
        set(value) { underlyingDecoderInit = value }
    }

    public var underlyingDecoderInit: String = "AutoMockable filled value"
    public var bridgeEnv: [RNModels.Configuration: [String]] = [:]
}

// MARK: - PlatformSpecificConfigurationWriterProtocolMock

open class PlatformSpecificConfigurationWriterProtocolMock: PlatformSpecificConfigurationWriterProtocol
{
    public init() {}

    public static var shared: PlatformSpecificConfigurationWriterProtocol
    {
        get { return underlyingShared }
        set(value) { underlyingShared = value }
    }

    public static var underlyingShared: PlatformSpecificConfigurationWriterProtocol!
    public var decoder: JSONDecoder
    {
        get { return underlyingDecoder }
        set(value) { underlyingDecoder = value }
    }

    public var underlyingDecoder: JSONDecoder!

    // MARK: - <writeToAllPlatforms > - parameters

    public var writeToAllPlatformsFromOutputThrowableError: Error?
    public var writeToAllPlatformsFromOutputCallsCount = 0
    public var writeToAllPlatformsFromOutputCalled: Bool
    {
        return writeToAllPlatformsFromOutputCallsCount > 0
    }

    public var writeToAllPlatformsFromOutputReceivedArguments: (json: JSONEnvironmentsProtocol, output: CoderOutputProtocol)?

    // MARK: - <writeToAllPlatforms > - closure mocks

    public var writeToAllPlatformsFromOutputClosure: ((JSONEnvironmentsProtocol, CoderOutputProtocol) throws -> Void)?

    // MARK: - <writeToAllPlatforms > - method mocked

    open func writeToAllPlatforms(from json: JSONEnvironmentsProtocol, output: CoderOutputProtocol) throws
    {
        // <writeToAllPlatforms > - Throwable method implementation

        if let error = writeToAllPlatformsFromOutputThrowableError
        {
            throw error
        }

        writeToAllPlatformsFromOutputCallsCount += 1
        writeToAllPlatformsFromOutputReceivedArguments = (json: json, output: output)

        // <writeToAllPlatforms > - Void return mock implementation

        try writeToAllPlatformsFromOutputClosure?(json, output)
    }
}

// MARK: - PlistWriterProtocolMock

open class PlistWriterProtocolMock: PlistWriterProtocol
{
    public init() {}

    public static var plistLinesXmlDefault: String
    {
        get { return underlyingPlistLinesXmlDefault }
        set(value) { underlyingPlistLinesXmlDefault = value }
    }

    public static var underlyingPlistLinesXmlDefault: String = "AutoMockable filled value"

    // MARK: - <write > - parameters

    public var writeOutputSamplerThrowableError: Error?
    public var writeOutputSamplerCallsCount = 0
    public var writeOutputSamplerCalled: Bool
    {
        return writeOutputSamplerCallsCount > 0
    }

    public var writeOutputSamplerReceivedArguments: (output: CoderOutputProtocol, sampler: JSONToCodeSamplerProtocol)?

    // MARK: - <write > - closure mocks

    public var writeOutputSamplerClosure: ((CoderOutputProtocol, JSONToCodeSamplerProtocol) throws -> Void)?

    // MARK: - <write > - method mocked

    open func write(output: CoderOutputProtocol, sampler: JSONToCodeSamplerProtocol) throws
    {
        // <write > - Throwable method implementation

        if let error = writeOutputSamplerThrowableError
        {
            throw error
        }

        writeOutputSamplerCallsCount += 1
        writeOutputSamplerReceivedArguments = (output: output, sampler: sampler)

        // <write > - Void return mock implementation

        try writeOutputSamplerClosure?(output, sampler)
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
