import Errors
import Foundation
import RNConfigurationPrepare
import RNModels
import SignPost
import Terminal
import ZFile

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - CoderProtocolMock

open class CoderProtocolMock: CoderProtocol
{
    public init() {}

    public var disk: ConfigurationDisk
    {
        get { return underlyingDisk }
        set(value) { underlyingDisk = value }
    }

    public var underlyingDisk: ConfigurationDisk!
    public var builds: Builds
    {
        get { return underlyingBuilds }
        set(value) { underlyingBuilds = value }
    }

    public var underlyingBuilds: Builds!
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
    public var inputJSON: ConfigurationDisk.Input
    {
        get { return underlyingInputJSON }
        set(value) { underlyingInputJSON = value }
    }

    public var underlyingInputJSON: ConfigurationDisk.Input!
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
    public var iOS: ConfigurationDisk.Output
    {
        get { return underlyingIOS }
        set(value) { underlyingIOS = value }
    }

    public var underlyingIOS: ConfigurationDisk.Output!
    public var android: ConfigurationDisk.Output
    {
        get { return underlyingAndroid }
        set(value) { underlyingAndroid = value }
    }

    public var underlyingAndroid: ConfigurationDisk.Output!
    public var code: ConfigurationDisk.Output.Code
    {
        get { return underlyingCode }
        set(value) { underlyingCode = value }
    }

    public var underlyingCode: ConfigurationDisk.Output.Code!
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
