import CoderLibrary
import Foundation
import HighwayLibrary
import RNModels
import SignPost
import Terminal
import ZFile

// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - BridgeEnvProtocolMock

open class BridgeEnvProtocolMock: BridgeEnvProtocol
{
    public init() {}

    public var local: [String] = []
    public var debug: [String] = []
    public var release: [String] = []
    public var betaRelease: [String] = []
}

// MARK: - CoderInputProtocolMock

open class CoderInputProtocolMock: CoderInputProtocol
{
    public init() {}

    public static var projectNameWithPrepareScript: String
    {
        get { return underlyingProjectNameWithPrepareScript }
        set(value) { underlyingProjectNameWithPrepareScript = value }
    }

    public static var underlyingProjectNameWithPrepareScript: String = "AutoMockable filled value"
    public static var jsonFileName: String
    {
        get { return underlyingJsonFileName }
        set(value) { underlyingJsonFileName = value }
    }

    public static var underlyingJsonFileName: String = "AutoMockable filled value"
    public var inputJSONFile: FileProtocol
    {
        get { return underlyingInputJSONFile }
        set(value) { underlyingInputJSONFile = value }
    }

    public var underlyingInputJSONFile: FileProtocol!
}

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
    public var debug: FileProtocol
    {
        get { return underlyingDebug }
        set(value) { underlyingDebug = value }
    }

    public var underlyingDebug: FileProtocol!
    public var release: FileProtocol
    {
        get { return underlyingRelease }
        set(value) { underlyingRelease = value }
    }

    public var underlyingRelease: FileProtocol!
    public var local: FileProtocol?
    public var betaRelease: FileProtocol?
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
    public var rnConfigurationModelFactorySwiftFile: FileProtocol
    {
        get { return underlyingRnConfigurationModelFactorySwiftFile }
        set(value) { underlyingRnConfigurationModelFactorySwiftFile = value }
    }

    public var underlyingRnConfigurationModelFactorySwiftFile: FileProtocol!
    public var infoPlistRNConfiguration: FileProtocol
    {
        get { return underlyingInfoPlistRNConfiguration }
        set(value) { underlyingInfoPlistRNConfiguration = value }
    }

    public var underlyingInfoPlistRNConfiguration: FileProtocol!
    public var infoPlistRNConfigurationTests: FileProtocol
    {
        get { return underlyingInfoPlistRNConfigurationTests }
        set(value) { underlyingInfoPlistRNConfigurationTests = value }
    }

    public var underlyingInfoPlistRNConfigurationTests: FileProtocol!
    public var rnConfigurationModelSwiftFile: FileProtocol
    {
        get { return underlyingRnConfigurationModelSwiftFile }
        set(value) { underlyingRnConfigurationModelSwiftFile = value }
    }

    public var underlyingRnConfigurationModelSwiftFile: FileProtocol!
    public var rnConfigurationBridgeObjectiveCMFile: FileProtocol
    {
        get { return underlyingRnConfigurationBridgeObjectiveCMFile }
        set(value) { underlyingRnConfigurationBridgeObjectiveCMFile = value }
    }

    public var underlyingRnConfigurationBridgeObjectiveCMFile: FileProtocol!

    // MARK: - <writeDefaultsToFiles> - parameters

    public var writeDefaultsToFilesThrowableError: Error?
    public var writeDefaultsToFilesCallsCount = 0
    public var writeDefaultsToFilesCalled: Bool
    {
        return writeDefaultsToFilesCallsCount > 0
    }

    // MARK: - <writeDefaultsToFiles> - closure mocks

    public var writeDefaultsToFilesClosure: (() throws -> Void)?

    // MARK: - <writeDefaultsToFiles> - method mocked

    open func writeDefaultsToFiles() throws
    {
        // <writeDefaultsToFiles> - Throwable method implementation

        if let error = writeDefaultsToFilesThrowableError
        {
            throw error
        }

        writeDefaultsToFilesCallsCount += 1

        // <writeDefaultsToFiles> - Void return mock implementation

        try writeDefaultsToFilesClosure?()
    }
}

// MARK: - CoderProtocolMock

open class CoderProtocolMock: CoderProtocol
{
    public init() {}

    public var input: CoderInputProtocol
    {
        get { return underlyingInput }
        set(value) { underlyingInput = value }
    }

    public var underlyingInput: CoderInputProtocol!
    public var output: CoderOutputProtocol
    {
        get { return underlyingOutput }
        set(value) { underlyingOutput = value }
    }

    public var underlyingOutput: CoderOutputProtocol!
    public var codeSampler: JSONToCodeSamplerProtocol
    {
        get { return underlyingCodeSampler }
        set(value) { underlyingCodeSampler = value }
    }

    public var underlyingCodeSampler: JSONToCodeSamplerProtocol!
    public var signPost: SignPostProtocol
    {
        get { return underlyingSignPost }
        set(value) { underlyingSignPost = value }
    }

    public var underlyingSignPost: SignPostProtocol!
    public static var rnConfigurationModelDefault_TOP: String
    {
        get { return underlyingRnConfigurationModelDefault_TOP }
        set(value) { underlyingRnConfigurationModelDefault_TOP = value }
    }

    public static var underlyingRnConfigurationModelDefault_TOP: String = "AutoMockable filled value"
    public static var rnConfigurationModelDefault_BOTTOM: String
    {
        get { return underlyingRnConfigurationModelDefault_BOTTOM }
        set(value) { underlyingRnConfigurationModelDefault_BOTTOM = value }
    }

    public static var underlyingRnConfigurationModelDefault_BOTTOM: String = "AutoMockable filled value"
    public static var factoryTop: String
    {
        get { return underlyingFactoryTop }
        set(value) { underlyingFactoryTop = value }
    }

    public static var underlyingFactoryTop: String = "AutoMockable filled value"
    public static var rnConfigurationModelFactoryProtocolDefault: String
    {
        get { return underlyingRnConfigurationModelFactoryProtocolDefault }
        set(value) { underlyingRnConfigurationModelFactoryProtocolDefault = value }
    }

    public static var underlyingRnConfigurationModelFactoryProtocolDefault: String = "AutoMockable filled value"

    // MARK: - <attempt> - parameters

    public var attemptThrowableError: Error?
    public var attemptCallsCount = 0
    public var attemptCalled: Bool
    {
        return attemptCallsCount > 0
    }

    public var attemptReturnValue: CoderOutputProtocol?

    // MARK: - <attempt> - closure mocks

    public var attemptClosure: (() throws -> CoderOutputProtocol)?

    // MARK: - <attempt> - method mocked

    open func attempt() throws -> CoderOutputProtocol
    {
        // <attempt> - Throwable method implementation

        if let error = attemptThrowableError
        {
            throw error
        }

        attemptCallsCount += 1

        // <attempt> - Return Value mock implementation

        guard let closureReturn = attemptClosure else
        {
            guard let returnValue = attemptReturnValue else
            {
                let message = "No returnValue implemented for attemptClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement CoderOutputProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <writeRNConfigurationBridge> - parameters

    public var writeRNConfigurationBridgeThrowableError: Error?
    public var writeRNConfigurationBridgeCallsCount = 0
    public var writeRNConfigurationBridgeCalled: Bool
    {
        return writeRNConfigurationBridgeCallsCount > 0
    }

    // MARK: - <writeRNConfigurationBridge> - closure mocks

    public var writeRNConfigurationBridgeClosure: (() throws -> Void)?

    // MARK: - <writeRNConfigurationBridge> - method mocked

    open func writeRNConfigurationBridge() throws
    {
        // <writeRNConfigurationBridge> - Throwable method implementation

        if let error = writeRNConfigurationBridgeThrowableError
        {
            throw error
        }

        writeRNConfigurationBridgeCallsCount += 1

        // <writeRNConfigurationBridge> - Void return mock implementation

        try writeRNConfigurationBridgeClosure?()
    }

    // MARK: - <writeRNConfigurationModel> - parameters

    public var writeRNConfigurationModelThrowableError: Error?
    public var writeRNConfigurationModelCallsCount = 0
    public var writeRNConfigurationModelCalled: Bool
    {
        return writeRNConfigurationModelCallsCount > 0
    }

    // MARK: - <writeRNConfigurationModel> - closure mocks

    public var writeRNConfigurationModelClosure: (() throws -> Void)?

    // MARK: - <writeRNConfigurationModel> - method mocked

    open func writeRNConfigurationModel() throws
    {
        // <writeRNConfigurationModel> - Throwable method implementation

        if let error = writeRNConfigurationModelThrowableError
        {
            throw error
        }

        writeRNConfigurationModelCallsCount += 1

        // <writeRNConfigurationModel> - Void return mock implementation

        try writeRNConfigurationModelClosure?()
    }

    // MARK: - <writeRNConfigurationModelFactory> - parameters

    public var writeRNConfigurationModelFactoryThrowableError: Error?
    public var writeRNConfigurationModelFactoryCallsCount = 0
    public var writeRNConfigurationModelFactoryCalled: Bool
    {
        return writeRNConfigurationModelFactoryCallsCount > 0
    }

    // MARK: - <writeRNConfigurationModelFactory> - closure mocks

    public var writeRNConfigurationModelFactoryClosure: (() throws -> Void)?

    // MARK: - <writeRNConfigurationModelFactory> - method mocked

    open func writeRNConfigurationModelFactory() throws
    {
        // <writeRNConfigurationModelFactory> - Throwable method implementation

        if let error = writeRNConfigurationModelFactoryThrowableError
        {
            throw error
        }

        writeRNConfigurationModelFactoryCallsCount += 1

        // <writeRNConfigurationModelFactory> - Void return mock implementation

        try writeRNConfigurationModelFactoryClosure?()
    }
}

// MARK: - JSONToCodeSamplerProtocolMock

open class JSONToCodeSamplerProtocolMock: JSONToCodeSamplerProtocol
{
    public init() {}

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
    public var bridgeEnv: BridgeEnvProtocol
    {
        get { return underlyingBridgeEnv }
        set(value) { underlyingBridgeEnv = value }
    }

    public var underlyingBridgeEnv: BridgeEnvProtocol!
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
    public var output: CoderOutputProtocol
    {
        get { return underlyingOutput }
        set(value) { underlyingOutput = value }
    }

    public var underlyingOutput: CoderOutputProtocol!
    public var sampler: JSONToCodeSamplerProtocol
    {
        get { return underlyingSampler }
        set(value) { underlyingSampler = value }
    }

    public var underlyingSampler: JSONToCodeSamplerProtocol!

    // MARK: - <writeRNConfigurationPlist> - parameters

    public var writeRNConfigurationPlistThrowableError: Error?
    public var writeRNConfigurationPlistCallsCount = 0
    public var writeRNConfigurationPlistCalled: Bool
    {
        return writeRNConfigurationPlistCallsCount > 0
    }

    // MARK: - <writeRNConfigurationPlist> - closure mocks

    public var writeRNConfigurationPlistClosure: (() throws -> Void)?

    // MARK: - <writeRNConfigurationPlist> - method mocked

    open func writeRNConfigurationPlist() throws
    {
        // <writeRNConfigurationPlist> - Throwable method implementation

        if let error = writeRNConfigurationPlistThrowableError
        {
            throw error
        }

        writeRNConfigurationPlistCallsCount += 1

        // <writeRNConfigurationPlist> - Void return mock implementation

        try writeRNConfigurationPlistClosure?()
    }
}

// MARK: - RNConfigurationBridgeProtocolMock

open class RNConfigurationBridgeProtocolMock: RNConfigurationBridgeProtocol
{
    public init() {}

    public var envLocal: [String] = []
    public var envDebug: [String] = []
    public var envRelease: [String] = []
    public var envBetaRelease: [String] = []
    public static var top: String
    {
        get { return underlyingTop }
        set(value) { underlyingTop = value }
    }

    public static var underlyingTop: String = "AutoMockable filled value"
    public var env: String
    {
        get { return underlyingEnv }
        set(value) { underlyingEnv = value }
    }

    public var underlyingEnv: String = "AutoMockable filled value"
    public static var bottom: String
    {
        get { return underlyingBottom }
        set(value) { underlyingBottom = value }
    }

    public static var underlyingBottom: String = "AutoMockable filled value"
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

    // MARK: - <writeConfigIfNeeded> - parameters

    public var writeConfigIfNeededFromForAndroidIosThrowableError: Error?
    public var writeConfigIfNeededFromForAndroidIosCallsCount = 0
    public var writeConfigIfNeededFromForAndroidIosCalled: Bool
    {
        return writeConfigIfNeededFromForAndroidIosCallsCount > 0
    }

    public var writeConfigIfNeededFromForAndroidIosReceivedArguments: (jsonFile: (FileProtocol)?, configuration: Configuration, android: (FileProtocol)?, ios: (FileProtocol)?)?

    // MARK: - <writeConfigIfNeeded> - closure mocks

    public var writeConfigIfNeededFromForAndroidIosClosure: ((FileProtocol?, Configuration, FileProtocol?, FileProtocol?) throws -> Void)?

    // MARK: - <writeConfigIfNeeded> - method mocked

    open func writeConfigIfNeeded(from jsonFile: FileProtocol?, for configuration: Configuration, android: FileProtocol?, ios: FileProtocol?) throws
    {
        // <writeConfigIfNeeded> - Throwable method implementation

        if let error = writeConfigIfNeededFromForAndroidIosThrowableError
        {
            throw error
        }

        writeConfigIfNeededFromForAndroidIosCallsCount += 1
        writeConfigIfNeededFromForAndroidIosReceivedArguments = (jsonFile: jsonFile, configuration: configuration, android: android, ios: ios)

        // <writeConfigIfNeeded> - Void return mock implementation

        try writeConfigIfNeededFromForAndroidIosClosure?(jsonFile, configuration, android, ios)
    }

    // MARK: - <writeIOSAndAndroidConfigFiles> - parameters

    public var writeIOSAndAndroidConfigFilesFromOutputThrowableError: Error?
    public var writeIOSAndAndroidConfigFilesFromOutputCallsCount = 0
    public var writeIOSAndAndroidConfigFilesFromOutputCalled: Bool
    {
        return writeIOSAndAndroidConfigFilesFromOutputCallsCount > 0
    }

    public var writeIOSAndAndroidConfigFilesFromOutputReceivedArguments: (input: CoderInputProtocol, output: CoderOutputProtocol)?

    // MARK: - <writeIOSAndAndroidConfigFiles> - closure mocks

    public var writeIOSAndAndroidConfigFilesFromOutputClosure: ((CoderInputProtocol, CoderOutputProtocol) throws -> Void)?

    // MARK: - <writeIOSAndAndroidConfigFiles> - method mocked

    open func writeIOSAndAndroidConfigFiles(from input: CoderInputProtocol, output: CoderOutputProtocol) throws
    {
        // <writeIOSAndAndroidConfigFiles> - Throwable method implementation

        if let error = writeIOSAndAndroidConfigFilesFromOutputThrowableError
        {
            throw error
        }

        writeIOSAndAndroidConfigFilesFromOutputCallsCount += 1
        writeIOSAndAndroidConfigFilesFromOutputReceivedArguments = (input: input, output: output)

        // <writeIOSAndAndroidConfigFiles> - Void return mock implementation

        try writeIOSAndAndroidConfigFilesFromOutputClosure?(input, output)
    }

    // MARK: - <setupCodeSamples> - parameters

    public var setupCodeSamplesJsonCallsCount = 0
    public var setupCodeSamplesJsonCalled: Bool
    {
        return setupCodeSamplesJsonCallsCount > 0
    }

    public var setupCodeSamplesJsonReceivedJson: JSONEnvironmentProtocol?
    public var setupCodeSamplesJsonReturnValue: TextFileWriter.Sample?

    // MARK: - <setupCodeSamples> - closure mocks

    public var setupCodeSamplesJsonClosure: ((JSONEnvironmentProtocol) -> TextFileWriter.Sample)?

    // MARK: - <setupCodeSamples> - method mocked

    open func setupCodeSamples(json: JSONEnvironmentProtocol) -> TextFileWriter.Sample
    {
        setupCodeSamplesJsonCallsCount += 1
        setupCodeSamplesJsonReceivedJson = json

        // <setupCodeSamples> - Return Value mock implementation

        guard let closureReturn = setupCodeSamplesJsonClosure else
        {
            guard let returnValue = setupCodeSamplesJsonReturnValue else
            {
                let message = "No returnValue implemented for setupCodeSamplesJsonClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement TextFileWriter.Sample

                print("❌ \(error)")

                fatalError("\(self) \(#function) should be mocked with return value or be able to throw")
            }
            return returnValue
        }

        return closureReturn(json)
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
