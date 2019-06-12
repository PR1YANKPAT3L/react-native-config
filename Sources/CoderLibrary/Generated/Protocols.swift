//
//  Protocols.swift
//  CoderLibrary
//
//  Created by Stijn Willems on 12/06/2019.
//

import Foundation
import RNModels
import SignPost
import SourceryAutoProtocols
import ZFile

public protocol CoderProtocol: AutoMockable
{
    // sourcery:inline:Coder.AutoGenerateProtocol
    var input: CoderInputProtocol { get }
    var output: CoderOutputProtocol { get }
    var codeSampler: JSONToCodeSamplerProtocol { get }
    var signPost: SignPostProtocol { get }
    static var rnConfigurationModelDefault_TOP: String { get }
    static var rnConfigurationModelDefault_BOTTOM: String { get }
    static var factoryTop: String { get }
    static var rnConfigurationModelFactoryProtocolDefault: String { get }

    func attempt() throws -> CoderOutputProtocol
    func writeRNConfigurationBridge() throws
    func writeRNConfigurationModel() throws
    func writeRNConfigurationModelFactory() throws

    // sourcery:end
}

public protocol RNConfigurationBridgeProtocol: AutoMockable
{
    // sourcery:inline:Coder.RNConfigurationBridge.AutoGenerateProtocol
    var envLocal: [String] { get }
    var envDebug: [String] { get }
    var envRelease: [String] { get }
    var envBetaRelease: [String] { get }
    static var top: String { get }
    var env: String { mutating get }
    static var bottom: String { get }

    // sourcery:end
}

public protocol CoderInputProtocol: AutoMockable
{
    // sourcery:inline:CoderInput.AutoGenerateProtocol
    static var projectNameWithPrepareScript: String { get }
    static var jsonFileName: String { get set }
    var inputJSONFile: FileProtocol { get }
    // sourcery:end
}

public protocol CoderOutputProtocol: AutoMockable
{
    // sourcery:inline:CoderOutput.AutoGenerateProtocol
    var android: CoderOutputAndroidProtocol { get }
    var ios: CoderOutputiOSProtocol { get }
    // sourcery:end
}

public protocol JSONToCodeSamplerProtocol: AutoMockable
{
    // sourcery:inline:JSONToCodeSampler.AutoGenerateProtocol
    var casesForEnum: String { get }
    var configurationModelVar: String { get }
    var configurationModelVarDescription: String { get }
    var plistLinesXmlText: String { get }
    var decoderInit: String { get }
    var bridgeEnv: BridgeEnvProtocol { get }

    // sourcery:end
}

public protocol BridgeEnvProtocol: AutoMockable
{
    // sourcery:inline:JSONToCodeSampler.BridgeEnv.AutoGenerateProtocol
    var local: [String] { get }
    var debug: [String] { get }
    var release: [String] { get }
    var betaRelease: [String] { get }
    // sourcery:end
}

public protocol PlistWriterProtocol: AutoMockable
{
    // sourcery:inline:PlistWriter.AutoGenerateProtocol
    static var plistLinesXmlDefault: String { get }
    var output: CoderOutputProtocol { get }
    var sampler: JSONToCodeSamplerProtocol { get }

    func writeRNConfigurationPlist() throws
    // sourcery:end
}

public protocol TextFileWriterProtocol: AutoMockable
{
    // sourcery:inline:TextFileWriter.AutoGenerateProtocol
    static var shared: TextFileWriterProtocol { get }
    var decoder: JSONDecoder { get }

    func writeConfigIfNeeded(from jsonFile: FileProtocol?, for configuration: Configuration, android: FileProtocol?, ios: FileProtocol?) throws
    func writeIOSAndAndroidConfigFiles(from input: CoderInputProtocol, output: CoderOutputProtocol) throws
    func setupCodeSamples(json: JSONEnvironmentProtocol) -> TextFileWriter.Sample

    // sourcery:end
}

public protocol CoderOutputAndroidProtocol: AutoMockable
{
    // sourcery:inline:CoderOutput.Android.AutoGenerateProtocol
    var sourcesFolder: FolderProtocol { get }
    var debug: FileProtocol { get }
    var release: FileProtocol { get }
    var local: FileProtocol? { get }
    var betaRelease: FileProtocol? { get }
    // sourcery:end
}

public protocol CoderOutputiOSProtocol: AutoMockable
{
    // sourcery:inline:CoderOutput.iOS.AutoGenerateProtocol
    var sourcesFolder: FolderProtocol { get }
    var xcconfigFile: FileProtocol { get }
    var rnConfigurationModelFactorySwiftFile: FileProtocol { get }
    var infoPlistRNConfiguration: FileProtocol { get }
    var infoPlistRNConfigurationTests: FileProtocol { get }
    var rnConfigurationModelSwiftFile: FileProtocol { get }
    var rnConfigurationBridgeObjectiveCMFile: FileProtocol { get }

    func writeDefaultsToFiles() throws
    // sourcery:end
}
