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
    static var modelDefault_TOP: String { get }
    static var modelDefault_BOTTOM: String { get }
    static var factoryTop: String { get }
    static var factoryDefault: String { get }

    func attemptCode(to output: CoderOutputProtocol) throws -> CoderOutputProtocol
    func writeModel(to output: CoderOutputProtocol) throws
    func writeFactory(to output: CoderOutputProtocol) throws

    // sourcery:end
}

public protocol JSBridgeCodeSampleProtocol: AutoMockable
{
    // sourcery:inline:JSBridgeCodeSample.AutoGenerateProtocol

    func writeBridge(to file: FileProtocol, sampler: JSONToCodeSamplerProtocol) throws
    // sourcery:end
}

public protocol JSONToCodeSamplerProtocol: AutoMockable
{
    // sourcery:inline:JSONToCodeSampler.AutoGenerateProtocol
    var jsonEnvironments: JSONEnvironmentsProtocol { get }
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

    func write(output: CoderOutputProtocol, sampler: JSONToCodeSamplerProtocol) throws
    // sourcery:end
}

public protocol PlatformSpecificConfigurationWriterProtocol: AutoMockable
{
    // sourcery:inline:PlatformSpecificConfigurationWriter.AutoGenerateProtocol
    static var shared: PlatformSpecificConfigurationWriterProtocol { get }
    var decoder: JSONDecoder { get }

    func writeToAllPlatforms(from json: JSONEnvironmentsProtocol, output: CoderOutputProtocol) throws

    // sourcery:end
}
