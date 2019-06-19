//
//  CoderOutputProtocol.swift
//  Coder
//
//  Created by Stijn Willems on 11/06/2019.
//

import Errors
import Foundation
import RNModels
import SourceryAutoProtocols
import Terminal
import ZFile

/**
 This is configured to work for this project, not yours. Provice your own by adding a struct that conforms to CoderOutputProtocol
 */
struct CoderOutput: CoderOutputProtocol, AutoGenerateProtocol
{
    let android: CoderOutputAndroidProtocol
    let ios: CoderOutputiOSProtocol

    private let packageCoderSources: FolderProtocol

    init(packageCoderSources: FolderProtocol, xcodeProjectName: String) throws
    {
        self.packageCoderSources = packageCoderSources

        let androidFolder = try packageCoderSources.subfolder(named: "android")
        let iosFolder = try packageCoderSources.subfolder(named: "ios")

        do
        {
            let rnConfigurationSourcesFolder = try packageCoderSources.subfolder(named: "Sources/RNConfiguration")
            let rnConfigurationBridgeSourcesFolder = try iosFolder.subfolder(named: "Sources/RNConfigurationBridge")

            let xcconfigFile = try iosFolder.createFileIfNeeded(named: "\(xcodeProjectName).xcconfig")

            android = CoderOutput.Android(
                sourcesFolder: androidFolder,
                configFiles: [
                    .Debug: try androidFolder.createFileIfNeeded(named: ".env.\(RNModels.Configuration.Debug.fileName())"),
                    .Release: try androidFolder.createFileIfNeeded(named: ".env.\(RNModels.Configuration.Release.fileName())"),
                    .Local: try androidFolder.createFileIfNeeded(named: ".env.\(RNModels.Configuration.Local.fileName())"),
                    .BetaRelease: try androidFolder.createFileIfNeeded(named: ".env.\(RNModels.Configuration.BetaRelease.fileName())"),
                ]
            )

            ios = CoderOutput.iOS(
                sourcesFolder: iosFolder,
                xcconfigFile: xcconfigFile,
                factory: try rnConfigurationSourcesFolder.file(named: "RNConfigurationModelFactory.swift"),
                model: try rnConfigurationSourcesFolder.createFileIfNeeded(named: "RNConfigurationModel.swift"),
                plists:
                [
                    try packageCoderSources.createFileIfNeeded(named: "\(xcodeProjectName).xcodeproj/RNConfiguration_Info.plist"),
                    try packageCoderSources.createFileIfNeeded(named: "\(xcodeProjectName).xcodeproj/RNConfigurationTests_Info.plist"),
                ],
                jsBridgeHeader: try rnConfigurationBridgeSourcesFolder.createFileIfNeeded(named: "ReactNativeConfig.h"),
                jsBridgeImplementation: try rnConfigurationBridgeSourcesFolder.createFileIfNeeded(named: "ReactNativeConfig.m")
            )
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    struct Android: CoderOutputAndroidProtocol, AutoGenerateProtocol
    {
        let sourcesFolder: FolderProtocol

        let configFiles: [RNModels.Configuration: FileProtocol]
    }

    struct iOS: CoderOutputiOSProtocol, AutoGenerateProtocol
    {
        let sourcesFolder: FolderProtocol

        let xcconfigFile: FileProtocol
        /**
         model and farctory are generated swift files from
         */
        let factory: FileProtocol
        let model: FileProtocol

        /**
         Can be duplicated as this is for example for test and for normal code
         */
        let plists: [FileProtocol]
        /**
         Provide .m and .h file
         */
        let jsBridgeHeader: FileProtocol
        let jsBridgeImplementation: FileProtocol
    }
}
