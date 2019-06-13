import CoderLibrary
import Foundation
import HighwayLibrary
import RNModels
import SignPost
import Terminal
import ZFile

// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

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
    public var jsBridge: FileProtocol
    {
        get { return underlyingJsBridge }
        set(value) { underlyingJsBridge = value }
    }

    public var underlyingJsBridge: FileProtocol!

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

// MARK: - JSBridgeCodeSampleProtocolMock

open class JSBridgeCodeSampleProtocolMock: JSBridgeCodeSampleProtocol
{
    public init() {}

    public var bridgeEnv: [RNModels.Configuration: [String]] = [:]

    // MARK: - <writeRNConfigurationBridge> - parameters

    public var writeRNConfigurationBridgeToThrowableError: Error?
    public var writeRNConfigurationBridgeToCallsCount = 0
    public var writeRNConfigurationBridgeToCalled: Bool
    {
        return writeRNConfigurationBridgeToCallsCount > 0
    }

    public var writeRNConfigurationBridgeToReceivedFile: FileProtocol?

    // MARK: - <writeRNConfigurationBridge> - closure mocks

    public var writeRNConfigurationBridgeToClosure: ((FileProtocol) throws -> Void)?

    // MARK: - <writeRNConfigurationBridge> - method mocked

    open func writeRNConfigurationBridge(to file: FileProtocol) throws
    {
        // <writeRNConfigurationBridge> - Throwable method implementation

        if let error = writeRNConfigurationBridgeToThrowableError
        {
            throw error
        }

        writeRNConfigurationBridgeToCallsCount += 1
        writeRNConfigurationBridgeToReceivedFile = file

        // <writeRNConfigurationBridge> - Void return mock implementation

        try writeRNConfigurationBridgeToClosure?(file)
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
