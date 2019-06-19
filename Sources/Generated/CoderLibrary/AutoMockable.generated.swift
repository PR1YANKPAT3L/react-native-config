import CoderLibrary
import Foundation
import HighwayLibrary
import RNModels
import SignPost
import Terminal
import ZFile

// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

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

    // MARK: - <attemptCode> - parameters

    public var attemptCodeToThrowableError: Error?
    public var attemptCodeToCallsCount = 0
    public var attemptCodeToCalled: Bool
    {
        return attemptCodeToCallsCount > 0
    }

    public var attemptCodeToReceivedOutput: CoderOutputProtocol?
    public var attemptCodeToReturnValue: CoderOutputProtocol?

    // MARK: - <attemptCode> - closure mocks

    public var attemptCodeToClosure: ((CoderOutputProtocol) throws -> CoderOutputProtocol)?

    // MARK: - <attemptCode> - method mocked

    open func attemptCode(to output: CoderOutputProtocol) throws -> CoderOutputProtocol
    {
        // <attemptCode> - Throwable method implementation

        if let error = attemptCodeToThrowableError
        {
            throw error
        }

        attemptCodeToCallsCount += 1
        attemptCodeToReceivedOutput = output

        // <attemptCode> - Return Value mock implementation

        guard let closureReturn = attemptCodeToClosure else
        {
            guard let returnValue = attemptCodeToReturnValue else
            {
                let message = "No returnValue implemented for attemptCodeToClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement CoderOutputProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn(output)
    }

    // MARK: - <writeRNConfigurationModel> - parameters

    public var writeRNConfigurationModelToThrowableError: Error?
    public var writeRNConfigurationModelToCallsCount = 0
    public var writeRNConfigurationModelToCalled: Bool
    {
        return writeRNConfigurationModelToCallsCount > 0
    }

    public var writeRNConfigurationModelToReceivedOutput: CoderOutputProtocol?

    // MARK: - <writeRNConfigurationModel> - closure mocks

    public var writeRNConfigurationModelToClosure: ((CoderOutputProtocol) throws -> Void)?

    // MARK: - <writeRNConfigurationModel> - method mocked

    open func writeRNConfigurationModel(to output: CoderOutputProtocol) throws
    {
        // <writeRNConfigurationModel> - Throwable method implementation

        if let error = writeRNConfigurationModelToThrowableError
        {
            throw error
        }

        writeRNConfigurationModelToCallsCount += 1
        writeRNConfigurationModelToReceivedOutput = output

        // <writeRNConfigurationModel> - Void return mock implementation

        try writeRNConfigurationModelToClosure?(output)
    }

    // MARK: - <writeFactory> - parameters

    public var writeFactoryToThrowableError: Error?
    public var writeFactoryToCallsCount = 0
    public var writeFactoryToCalled: Bool
    {
        return writeFactoryToCallsCount > 0
    }

    public var writeFactoryToReceivedOutput: CoderOutputProtocol?

    // MARK: - <writeFactory> - closure mocks

    public var writeFactoryToClosure: ((CoderOutputProtocol) throws -> Void)?

    // MARK: - <writeFactory> - method mocked

    open func writeFactory(to output: CoderOutputProtocol) throws
    {
        // <writeFactory> - Throwable method implementation

        if let error = writeFactoryToThrowableError
        {
            throw error
        }

        writeFactoryToCallsCount += 1
        writeFactoryToReceivedOutput = output

        // <writeFactory> - Void return mock implementation

        try writeFactoryToClosure?(output)
    }
}

// MARK: - JSBridgeCodeSampleProtocolMock

open class JSBridgeCodeSampleProtocolMock: JSBridgeCodeSampleProtocol
{
    public init() {}

    // MARK: - <writeRNConfigurationBridge> - parameters

    public var writeRNConfigurationBridgeToSamplerThrowableError: Error?
    public var writeRNConfigurationBridgeToSamplerCallsCount = 0
    public var writeRNConfigurationBridgeToSamplerCalled: Bool
    {
        return writeRNConfigurationBridgeToSamplerCallsCount > 0
    }

    public var writeRNConfigurationBridgeToSamplerReceivedArguments: (file: FileProtocol, sampler: JSONToCodeSamplerProtocol)?

    // MARK: - <writeRNConfigurationBridge> - closure mocks

    public var writeRNConfigurationBridgeToSamplerClosure: ((FileProtocol, JSONToCodeSamplerProtocol) throws -> Void)?

    // MARK: - <writeRNConfigurationBridge> - method mocked

    open func writeRNConfigurationBridge(to file: FileProtocol, sampler: JSONToCodeSamplerProtocol) throws
    {
        // <writeRNConfigurationBridge> - Throwable method implementation

        if let error = writeRNConfigurationBridgeToSamplerThrowableError
        {
            throw error
        }

        writeRNConfigurationBridgeToSamplerCallsCount += 1
        writeRNConfigurationBridgeToSamplerReceivedArguments = (file: file, sampler: sampler)

        // <writeRNConfigurationBridge> - Void return mock implementation

        try writeRNConfigurationBridgeToSamplerClosure?(file, sampler)
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

    // MARK: - <writeRNConfigurationPlist> - parameters

    public var writeRNConfigurationPlistOutputSamplerThrowableError: Error?
    public var writeRNConfigurationPlistOutputSamplerCallsCount = 0
    public var writeRNConfigurationPlistOutputSamplerCalled: Bool
    {
        return writeRNConfigurationPlistOutputSamplerCallsCount > 0
    }

    public var writeRNConfigurationPlistOutputSamplerReceivedArguments: (output: CoderOutputProtocol, sampler: JSONToCodeSamplerProtocol)?

    // MARK: - <writeRNConfigurationPlist> - closure mocks

    public var writeRNConfigurationPlistOutputSamplerClosure: ((CoderOutputProtocol, JSONToCodeSamplerProtocol) throws -> Void)?

    // MARK: - <writeRNConfigurationPlist> - method mocked

    open func writeRNConfigurationPlist(output: CoderOutputProtocol, sampler: JSONToCodeSamplerProtocol) throws
    {
        // <writeRNConfigurationPlist> - Throwable method implementation

        if let error = writeRNConfigurationPlistOutputSamplerThrowableError
        {
            throw error
        }

        writeRNConfigurationPlistOutputSamplerCallsCount += 1
        writeRNConfigurationPlistOutputSamplerReceivedArguments = (output: output, sampler: sampler)

        // <writeRNConfigurationPlist> - Void return mock implementation

        try writeRNConfigurationPlistOutputSamplerClosure?(output, sampler)
    }
}

// MARK: - TextFileWriterProtocolMock

open class TextFileWriterProtocolMock: TextFileWriterProtocol
{
    public init() {}

    public static var shared: TextFileWriterProtocol
    {
        get { return underlyingShared }
        set(value) { underlyingShared = value }
    }

    public static var underlyingShared: TextFileWriterProtocol!
    public var decoder: JSONDecoder
    {
        get { return underlyingDecoder }
        set(value) { underlyingDecoder = value }
    }

    public var underlyingDecoder: JSONDecoder!

    // MARK: - <writeIOSAndAndroidConfigFiles> - parameters

    public var writeIOSAndAndroidConfigFilesFromOutputThrowableError: Error?
    public var writeIOSAndAndroidConfigFilesFromOutputCallsCount = 0
    public var writeIOSAndAndroidConfigFilesFromOutputCalled: Bool
    {
        return writeIOSAndAndroidConfigFilesFromOutputCallsCount > 0
    }

    public var writeIOSAndAndroidConfigFilesFromOutputReceivedArguments: (json: JSONEnvironmentsProtocol, output: CoderOutputProtocol)?

    // MARK: - <writeIOSAndAndroidConfigFiles> - closure mocks

    public var writeIOSAndAndroidConfigFilesFromOutputClosure: ((JSONEnvironmentsProtocol, CoderOutputProtocol) throws -> Void)?

    // MARK: - <writeIOSAndAndroidConfigFiles> - method mocked

    open func writeIOSAndAndroidConfigFiles(from json: JSONEnvironmentsProtocol, output: CoderOutputProtocol) throws
    {
        // <writeIOSAndAndroidConfigFiles> - Throwable method implementation

        if let error = writeIOSAndAndroidConfigFilesFromOutputThrowableError
        {
            throw error
        }

        writeIOSAndAndroidConfigFilesFromOutputCallsCount += 1
        writeIOSAndAndroidConfigFilesFromOutputReceivedArguments = (json: json, output: output)

        // <writeIOSAndAndroidConfigFiles> - Void return mock implementation

        try writeIOSAndAndroidConfigFilesFromOutputClosure?(json, output)
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
