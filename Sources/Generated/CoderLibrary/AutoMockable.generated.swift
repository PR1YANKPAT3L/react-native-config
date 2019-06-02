import CoderLibrary
import Foundation
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

    // MARK: - <attemptWriteInfoPlistToAllPlists> - parameters

    public var attemptWriteInfoPlistToAllPlistsInThrowableError: Error?
    public var attemptWriteInfoPlistToAllPlistsInCallsCount = 0
    public var attemptWriteInfoPlistToAllPlistsInCalled: Bool
    {
        return attemptWriteInfoPlistToAllPlistsInCallsCount > 0
    }

    public var attemptWriteInfoPlistToAllPlistsInReceivedFolder: FolderProtocol?

    // MARK: - <attemptWriteInfoPlistToAllPlists> - closure mocks

    public var attemptWriteInfoPlistToAllPlistsInClosure: ((FolderProtocol) throws -> Void)?

    // MARK: - <attemptWriteInfoPlistToAllPlists> - method mocked

    open func attemptWriteInfoPlistToAllPlists(in folder: FolderProtocol) throws
    {
        // <attemptWriteInfoPlistToAllPlists> - Throwable method implementation

        if let error = attemptWriteInfoPlistToAllPlistsInThrowableError
        {
            throw error
        }

        attemptWriteInfoPlistToAllPlistsInCallsCount += 1
        attemptWriteInfoPlistToAllPlistsInReceivedFolder = folder

        // <attemptWriteInfoPlistToAllPlists> - Void return mock implementation

        try attemptWriteInfoPlistToAllPlistsInClosure?(folder)
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
    public var inputJSON: InputProtocol
    {
        get { return underlyingInputJSON }
        set(value) { underlyingInputJSON = value }
    }

    public var underlyingInputJSON: InputProtocol!
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
    public var iOS: OutputProtocol
    {
        get { return underlyingIOS }
        set(value) { underlyingIOS = value }
    }

    public var underlyingIOS: OutputProtocol!
    public var android: OutputProtocol
    {
        get { return underlyingAndroid }
        set(value) { underlyingAndroid = value }
    }

    public var underlyingAndroid: OutputProtocol!
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

    // MARK: - <clearContentAllFiles> - parameters

    public var clearContentAllFilesThrowableError: Error?
    public var clearContentAllFilesCallsCount = 0
    public var clearContentAllFilesCalled: Bool
    {
        return clearContentAllFilesCallsCount > 0
    }

    // MARK: - <clearContentAllFiles> - closure mocks

    public var clearContentAllFilesClosure: (() throws -> Void)?

    // MARK: - <clearContentAllFiles> - method mocked

    open func clearContentAllFiles() throws
    {
        // <clearContentAllFiles> - Throwable method implementation

        if let error = clearContentAllFilesThrowableError
        {
            throw error
        }

        clearContentAllFilesCallsCount += 1

        // <clearContentAllFiles> - Void return mock implementation

        try clearContentAllFilesClosure?()
    }
}

// MARK: - InputJSONProtocolMock

open class InputJSONProtocolMock: InputJSONProtocol
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

// MARK: - InputProtocolMock

open class InputProtocolMock: InputProtocol
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

    public var input: JSONToCodeSampler.InputJSON
    {
        get { return underlyingInput }
        set(value) { underlyingInput = value }
    }

    public var underlyingInput: JSONToCodeSampler.InputJSON!
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

// MARK: - OutputProtocolMock

open class OutputProtocolMock: OutputProtocol
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
