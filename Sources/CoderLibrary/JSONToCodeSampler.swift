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

/**
 Will load input and decode input JSON -> Use RNConfigurationModel.create from this JSON.

 It will read the json files and give code sampels to the Coder to write code to files.
 */
public struct JSONToCodeSampler: JSONToCodeSamplerProtocol, AutoGenerateProtocol
{
    public let casesForEnum: String
    public let configurationModelVar: String
    public let configurationModelVarDescription: String
    public let plistLinesXmlText: String
    public let decoderInit: String
    public let bridgeEnv: BridgeEnvProtocol

    private struct BridgeEnv: BridgeEnvProtocol, AutoGenerateProtocol
    {
        public let local: [String]
        public let debug: [String]
        public let release: [String]
        public let betaRelease: [String]
    }

    // MARK: Initialize

    public init(
        from input: CoderInputProtocol,
        to output: CoderOutputProtocol,
        textFileWriter: TextFileWriterProtocol = TextFileWriter.shared,
        decoder: JSONDecoder = JSONDecoder()
    ) throws
    {
        try textFileWriter.writeIOSAndAndroidConfigFiles(from: input, output: output)

        let json = try decoder.decode(JSONEnvironments.self, from: try input.inputJSONFile.read())
        let allKeys = textFileWriter.setupCodeSamples(json: json.debug)

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
            local: (json.local.typed?.mapValues { $0.value }.map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? []) + (json.local.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
            debug: (json.debug.typed?.mapValues { $0.value }.map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? []) + (json.debug.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
            release: (json.release.typed?.mapValues { $0.value }.map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? []) + (json.release.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? []),
            betaRelease: (json.betaRelease.typed?.mapValues { $0.value }.map { "    @\"\($0.key)\" : @\"\($0.value)\"" } ?? []) + (json.betaRelease.booleans?.map { "    @\"\($0.key)\" : \($0.value.toObjectiveC())" } ?? [])
        )
    }
}
