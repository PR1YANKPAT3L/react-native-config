import CoderLibrary
import Foundation
import HighwayLibrary
import RNModels
import SignPost
import Terminal
import ZFile

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
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

// MARK: - CoderProtocolMock

open class CoderProtocolMock: CoderProtocol
{
    public init() {}

    public var configurationDisk: ConfigurationDiskProtocol
    {
        get { return underlyingConfigurationDisk }
        set(value) { underlyingConfigurationDisk = value }
    }

    public var underlyingConfigurationDisk: ConfigurationDiskProtocol!
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
    public static var plistLinesXmlDefault: String
    {
        get { return underlyingPlistLinesXmlDefault }
        set(value) { underlyingPlistLinesXmlDefault = value }
    }

    public static var underlyingPlistLinesXmlDefault: String = "AutoMockable filled value"

    // MARK: - <attempt> - parameters

    public var attemptThrowableError: Error?
    public var attemptCallsCount = 0
    public var attemptCalled: Bool
    {
        return attemptCallsCount > 0
    }

    public var attemptReturnValue: Coder.Config?

    // MARK: - <attempt> - closure mocks

    public var attemptClosure: (() throws -> Coder.Config)?

    // MARK: - <attempt> - method mocked

    open func attempt() throws -> Coder.Config
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

                // You should implement Coder.Config

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

    // MARK: - <writeRNConfigurationPlist> - parameters

    public var writeRNConfigurationPlistToThrowableError: Error?
    public var writeRNConfigurationPlistToCallsCount = 0
    public var writeRNConfigurationPlistToCalled: Bool
    {
        return writeRNConfigurationPlistToCallsCount > 0
    }

    public var writeRNConfigurationPlistToReceivedFile: FileProtocol?

    // MARK: - <writeRNConfigurationPlist> - closure mocks

    public var writeRNConfigurationPlistToClosure: ((FileProtocol) throws -> Void)?

    // MARK: - <writeRNConfigurationPlist> - method mocked

    open func writeRNConfigurationPlist(to file: FileProtocol) throws
    {
        // <writeRNConfigurationPlist> - Throwable method implementation

        if let error = writeRNConfigurationPlistToThrowableError
        {
            throw error
        }

        writeRNConfigurationPlistToCallsCount += 1
        writeRNConfigurationPlistToReceivedFile = file

        // <writeRNConfigurationPlist> - Void return mock implementation

        try writeRNConfigurationPlistToClosure?(file)
    }
}

// MARK: - ConfigurationDiskProtocolMock

open class ConfigurationDiskProtocolMock: ConfigurationDiskProtocol
{
    public init() {}

    public static var projectNameWithPrepareScript: String
    {
        get { return underlyingProjectNameWithPrepareScript }
        set(value) { underlyingProjectNameWithPrepareScript = value }
    }

    public static var underlyingProjectNameWithPrepareScript: String = "AutoMockable filled value"
    public var environmentJsonFilesFolder: FolderProtocol
    {
        get { return underlyingEnvironmentJsonFilesFolder }
        set(value) { underlyingEnvironmentJsonFilesFolder = value }
    }

    public var underlyingEnvironmentJsonFilesFolder: FolderProtocol!
    public var rnConfigurationSourcesFolder: FolderProtocol
    {
        get { return underlyingRnConfigurationSourcesFolder }
        set(value) { underlyingRnConfigurationSourcesFolder = value }
    }

    public var underlyingRnConfigurationSourcesFolder: FolderProtocol!
    public var rnConfigurationBridgeSourcesFolder: FolderProtocol
    {
        get { return underlyingRnConfigurationBridgeSourcesFolder }
        set(value) { underlyingRnConfigurationBridgeSourcesFolder = value }
    }

    public var underlyingRnConfigurationBridgeSourcesFolder: FolderProtocol!
    public var inputJSON: JSONFileProtocol
    {
        get { return underlyingInputJSON }
        set(value) { underlyingInputJSON = value }
    }

    public var underlyingInputJSON: JSONFileProtocol!
    public var androidFolder: FolderProtocol
    {
        get { return underlyingAndroidFolder }
        set(value) { underlyingAndroidFolder = value }
    }

    public var underlyingAndroidFolder: FolderProtocol!
    public var iosFolder: FolderProtocol
    {
        get { return underlyingIosFolder }
        set(value) { underlyingIosFolder = value }
    }

    public var underlyingIosFolder: FolderProtocol!
    public var xcconfigFile: FileProtocol
    {
        get { return underlyingXcconfigFile }
        set(value) { underlyingXcconfigFile = value }
    }

    public var underlyingXcconfigFile: FileProtocol!
    public var android: OutputFilesProtocol
    {
        get { return underlyingAndroid }
        set(value) { underlyingAndroid = value }
    }

    public var underlyingAndroid: OutputFilesProtocol!
    public var code: GeneratedCodeProtocol
    {
        get { return underlyingCode }
        set(value) { underlyingCode = value }
    }

    public var underlyingCode: GeneratedCodeProtocol!
}

// MARK: - GeneratedCodeProtocolMock

open class GeneratedCodeProtocolMock: GeneratedCodeProtocol
{
    public init() {}

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

// MARK: - JSONFileProtocolMock

open class JSONFileProtocolMock: JSONFileProtocol
{
    public init() {}

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

// MARK: - JSONToCodeSamplerProtocolMock

open class JSONToCodeSamplerProtocolMock: JSONToCodeSamplerProtocol
{
    public init() {}

    public var input: EnvJSONsProtocol
    {
        get { return underlyingInput }
        set(value) { underlyingInput = value }
    }

    public var underlyingInput: EnvJSONsProtocol!
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

// MARK: - OutputFilesProtocolMock

open class OutputFilesProtocolMock: OutputFilesProtocol
{
    public init() {}

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

    public var writeConfigIfNeededFromForAndroidIosReceivedArguments: (jsonFile: FileProtocol?, configuration: Configuration, android: FileProtocol?, ios: FileProtocol?)?
    public var writeConfigIfNeededFromForAndroidIosReturnValue: JSONProtocol??

    // MARK: - <writeConfigIfNeeded> - closure mocks

    public var writeConfigIfNeededFromForAndroidIosClosure: ((FileProtocol?, Configuration, FileProtocol?, FileProtocol?) throws -> JSONProtocol?)?

    // MARK: - <writeConfigIfNeeded> - method mocked

    open func writeConfigIfNeeded(from jsonFile: FileProtocol?, for configuration: Configuration, android: FileProtocol?, ios: FileProtocol?) throws -> JSONProtocol?
    {
        // <writeConfigIfNeeded> - Throwable method implementation

        if let error = writeConfigIfNeededFromForAndroidIosThrowableError
        {
            throw error
        }

        writeConfigIfNeededFromForAndroidIosCallsCount += 1
        writeConfigIfNeededFromForAndroidIosReceivedArguments = (jsonFile: jsonFile, configuration: configuration, android: android, ios: ios)

        // <writeConfigIfNeeded> - Return Value mock implementation

        guard let closureReturn = writeConfigIfNeededFromForAndroidIosClosure else
        {
            guard let returnValue = writeConfigIfNeededFromForAndroidIosReturnValue else
            {
                let message = "No returnValue implemented for writeConfigIfNeededFromForAndroidIosClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement JSONProtocol?

                throw error
            }
            return returnValue
        }

        return try closureReturn(jsonFile, configuration, android, ios)
    }

    // MARK: - <writeIOSAndAndroidConfigFiles> - parameters

    public var writeIOSAndAndroidConfigFilesFromThrowableError: Error?
    public var writeIOSAndAndroidConfigFilesFromCallsCount = 0
    public var writeIOSAndAndroidConfigFilesFromCalled: Bool
    {
        return writeIOSAndAndroidConfigFilesFromCallsCount > 0
    }

    public var writeIOSAndAndroidConfigFilesFromReceivedDisk: ConfigurationDiskProtocol?
    public var writeIOSAndAndroidConfigFilesFromReturnValue: EnvJSONsProtocol?

    // MARK: - <writeIOSAndAndroidConfigFiles> - closure mocks

    public var writeIOSAndAndroidConfigFilesFromClosure: ((ConfigurationDiskProtocol) throws -> EnvJSONsProtocol)?

    // MARK: - <writeIOSAndAndroidConfigFiles> - method mocked

    open func writeIOSAndAndroidConfigFiles(from disk: ConfigurationDiskProtocol) throws -> EnvJSONsProtocol
    {
        // <writeIOSAndAndroidConfigFiles> - Throwable method implementation

        if let error = writeIOSAndAndroidConfigFilesFromThrowableError
        {
            throw error
        }

        writeIOSAndAndroidConfigFilesFromCallsCount += 1
        writeIOSAndAndroidConfigFilesFromReceivedDisk = disk

        // <writeIOSAndAndroidConfigFiles> - Return Value mock implementation

        guard let closureReturn = writeIOSAndAndroidConfigFilesFromClosure else
        {
            guard let returnValue = writeIOSAndAndroidConfigFilesFromReturnValue else
            {
                let message = "No returnValue implemented for writeIOSAndAndroidConfigFilesFromClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement EnvJSONsProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn(disk)
    }

    // MARK: - <setupCodeSamples> - parameters

    public var setupCodeSamplesJsonCallsCount = 0
    public var setupCodeSamplesJsonCalled: Bool
    {
        return setupCodeSamplesJsonCallsCount > 0
    }

    public var setupCodeSamplesJsonReceivedJson: JSONProtocol?
    public var setupCodeSamplesJsonReturnValue: TextFileWriter.Sample?

    // MARK: - <setupCodeSamples> - closure mocks

    public var setupCodeSamplesJsonClosure: ((JSONProtocol) -> TextFileWriter.Sample)?

    // MARK: - <setupCodeSamples> - method mocked

    open func setupCodeSamples(json: JSONProtocol) -> TextFileWriter.Sample
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
