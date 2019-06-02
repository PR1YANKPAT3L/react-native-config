//
//  PlatformConfiguarionFileWriter.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Errors
import Foundation
import RNModels
import SourceryAutoProtocols
import ZFile

public protocol JSONToCodeSamplerProtocol: AutoMockable
{
    // sourcery:inline:JSONToCodeSampler.AutoGenerateProtocol
    var input: EnvJSONsProtocol { get }
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

/**
 Will load input and decode input JSON -> Use RNConfigurationModel.create from this JSON.

 It will read the json files and give code sampels to the Coder to write code to files.
 */
public struct JSONToCodeSampler: JSONToCodeSamplerProtocol, AutoGenerateProtocol
{
    public let input: EnvJSONsProtocol

    public let casesForEnum: String

    public let configurationModelVar: String
    public let configurationModelVarDescription: String
    public let plistLinesXmlText: String
    public let decoderInit: String
    public let bridgeEnv: BridgeEnvProtocol

    public struct BridgeEnv: BridgeEnvProtocol, AutoGenerateProtocol
    {
        public let local: [String]
        public let debug: [String]
        public let release: [String]
        public let betaRelease: [String]
    }

    // MARK: Initialize

    public init(
        from disk: ConfigurationDiskProtocol,
        textFileWriter: TextFileWriterProtocol = TextFileWriter.shared
    ) throws
    {
        let input = try textFileWriter.writeIOSAndAndroidConfigFiles(from: disk)

        let allKeys = textFileWriter.setupCodeSamples(json: input.debug)
        self.input = input

        casesForEnum = allKeys
            .map { $0.case }
            .map { "      \($0)" }
            .sorted()
            .joined(separator: "\n")

        configurationModelVar = allKeys
            .map { $0.configurationModelVar }
            .map { "    \($0)" }
            .sorted()
            .joined(separator: "\n")

        configurationModelVarDescription = allKeys
            .map { $0.configurationModelVarDescription }
            .map { "            * \($0)" }
            .sorted()
            .joined(separator: "\n")

        plistLinesXmlText = allKeys
            .map { $0.xmlEntry }
            .map { "      \($0)" }
            .sorted()
            .joined(separator: "\n")

        decoderInit = allKeys
            .map { $0.decoderInit }
            .sorted()
            .map { "         \($0)" }
            .joined(separator: "\n")

        bridgeEnv = BridgeEnv(
            local: (input.local?.typed?.mapValues { $0.value }.map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? []) + (input.local?.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
            debug: (input.debug.typed?.mapValues { $0.value }.map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? []) + (input.debug.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
            release: (input.release.typed?.mapValues { $0.value }.map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? []) + (input.release.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
            betaRelease: (input.betaRelease?.typed?.mapValues { $0.value }.map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? []) + (input.betaRelease?.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? [])
        )
    }
}
