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

public struct PlatformSpecificConfigurationWriter: PlatformSpecificConfigurationWriterProtocol, AutoGenerateProtocol
{
    public static let shared: PlatformSpecificConfigurationWriterProtocol = PlatformSpecificConfigurationWriter()

    public let decoder: JSONDecoder

    // MARK: - Init

    public init(
        decoder: JSONDecoder = JSONDecoder()
    )
    {
        self.decoder = decoder
    }

    // MARK: - Writing to text files for android and ios

    public func writeToAllPlatforms(from json: JSONEnvironmentsProtocol, output: CoderOutputProtocol) throws
    {
        try Configuration.allCases.forEach
        {
            try writeiOSConfiguration(json, $0, ios: output.ios.xcconfigFile)
            try writeAndroidConfiguration(json, $0, output.android.configFiles[$0])
        }
    }

    // MARK: - Private

    private func writeAndroidConfiguration(_ json: JSONEnvironmentsProtocol, _ configuration: Configuration, _ android: FileProtocol?) throws
    {
        guard let androidEntry = try json.config[configuration]?.androidEnvEntry() else { return }

        try android?.write(string: androidEntry)
    }

    private func writeiOSConfiguration(_ json: JSONEnvironmentsProtocol, _ configuration: Configuration, ios: FileProtocol?) throws
    {
        guard let iOSEntry = try json.config[configuration]?.xcconfigEntry(for: configuration) else { return }

        guard
            let content = try ios?.readAsString(),
            !content.contains(iOSEntry)
        else
        {
            return
        }
        try ios?.append(string: "\n\(iOSEntry)")
    }
}
