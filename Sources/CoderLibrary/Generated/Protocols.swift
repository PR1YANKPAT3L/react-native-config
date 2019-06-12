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
    func writeRNConfigurationModel() throws
    func writeRNConfigurationModelFactory() throws

    // sourcery:end
}

public protocol JSBridgeCodeSampleProtocol: AutoMockable
{
    // sourcery:inline:JSBridgeCodeSample.AutoGenerateProtocol
    var bridgeEnv: [RNModels.Configuration: [String]] { get }

    func writeRNConfigurationBridge(to file: FileProtocol) throws
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
    var bridgeEnv: [RNModels.Configuration: [String]] { get }

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

    func writeIOSAndAndroidConfigFiles(from input: CoderInputProtocol, output: CoderOutputProtocol) throws

    // sourcery:end
}

public protocol CoderOutputAndroidProtocol: AutoMockable
{
    // sourcery:inline:CoderOutput.Android.AutoGenerateProtocol
    var sourcesFolder: FolderProtocol { get }
    var configFiles: [RNModels.Configuration: FileProtocol] { get }
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
    var jsBridge: FileProtocol { get }

    func writeDefaultsToFiles() throws
    // sourcery:end
}
