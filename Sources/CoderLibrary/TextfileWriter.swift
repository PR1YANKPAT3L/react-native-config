//
//  TextfileWriter.swift
//  CoderLibrary
//
//  Created by Stijn Willems on 02/06/2019.
//

import Errors
import Foundation
import RNModels
import SourceryAutoProtocols
import ZFile

public struct TextFileWriter: TextFileWriterProtocol, AutoGenerateProtocol
{
    public static let shared: TextFileWriterProtocol = TextFileWriter()

    public let decoder: JSONDecoder

    // MARK: - Init

    public init(
        decoder: JSONDecoder = JSONDecoder()
    )
    {
        self.decoder = decoder
    }

    // MARK: - Writing to text files for android and ios

    public func writeIOSAndAndroidConfigFiles(from input: CoderInputProtocol, output: CoderOutputProtocol) throws
    {
        let json = try decoder.decode(JSONEnvironment.self, from: try input.inputJSONFile.read())

        try Configuration.allCases.forEach
        {
            try writeiOSConfiguration(json, $0, ios: output.ios.xcconfigFile)
            let config: FileProtocol? = output.android.configFiles[$0]!
            try writeAndroidConfiguration(json, config)
        }
    }

    // MARK: - Private

    private func writeAndroidConfiguration(_ json: JSONEnvironmentProtocol, _ android: FileProtocol?) throws
    {
        let androidEntry = try json.androidEnvEntry()
        try android?.write(string: androidEntry)
    }

    private func writeiOSConfiguration(_ json: JSONEnvironmentProtocol, _ configuration: Configuration, ios: FileProtocol?) throws
    {
        let iOSEntry = try json.xcconfigEntry(for: configuration)

        guard let content = try ios?.readAsString(), !content.contains(iOSEntry) else
        {
            return
        }

        try ios?.append(string: "\n")

        try ios?.append(string: iOSEntry)
    }
}
