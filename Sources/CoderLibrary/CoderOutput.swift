//
//  CoderOutputProtocol.swift
//  Coder
//
//  Created by Stijn Willems on 11/06/2019.
//

import Errors
import Foundation
import HighwayLibrary
import RNModels
import SourceryAutoProtocols
import Terminal
import ZFile

public struct CoderOutput: CoderOutputProtocol, AutoGenerateProtocol
{
    public let android: CoderOutputAndroidProtocol
    public let ios: CoderOutputiOSProtocol

    private let packageCoderSources: FolderProtocol

    public init(packageCoderSources: FolderProtocol) throws
    {
        self.packageCoderSources = packageCoderSources

        let androidFolder = try packageCoderSources.subfolder(named: "android")
        let iosFolder = try packageCoderSources.subfolder(named: "ios")

        do
        {
            let rnConfigurationSourcesFolder = try packageCoderSources.subfolder(named: "Sources/RNConfiguration")
            let rnConfigurationBridgeSourcesFolder = try iosFolder.subfolder(named: "Sources/RNConfigurationBridge")

            let xcconfigFile = try iosFolder.createFileIfNeeded(named: "Coder.xcconfig")

            android = CoderOutput.Android(
                sourcesFolder: androidFolder,
                configFiles: [
                    .Debug: try androidFolder.createFileIfNeeded(named: ".env.debug"),
                    .Release: try androidFolder.createFileIfNeeded(named: ".env.release"),
                    .Local: try androidFolder.createFileIfNeeded(named: ".env.local"),
                    .BetaRelease: try androidFolder.createFileIfNeeded(named: ".env.betaReleae"),
                ]
            )

            if !packageCoderSources.containsSubfolder(possiblyInvalidName: CoderInput.projectNameWithPrepareScript)
            {
                highway.generateXcodeProject(override: xcconfigFile, handleSwiftPackageGenerateXcodeProject)
                dispatchGroup.wait()
            }

            ios = CoderOutput.iOS(
                sourcesFolder: iosFolder,
                xcconfigFile: xcconfigFile,
                rnConfigurationModelFactorySwiftFile: try rnConfigurationSourcesFolder.file(named: "RNConfigurationModelFactory.swift"),
                infoPlistRNConfiguration: try packageCoderSources.file(named: "\(CoderInput.projectNameWithPrepareScript)/RNConfiguration_Info.plist"),
                infoPlistRNConfigurationTests: try packageCoderSources.file(named: "\(CoderInput.projectNameWithPrepareScript)/RNConfigurationTests_Info.plist"),
                rnConfigurationModelSwiftFile: try rnConfigurationSourcesFolder.file(named: "RNConfigurationModel.swift"),
                jsBridge: try rnConfigurationBridgeSourcesFolder.file(named: "ReactNativeConfig.m")
            )
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    public struct Android: CoderOutputAndroidProtocol, AutoGenerateProtocol
    {
        public let sourcesFolder: FolderProtocol

        public let configFiles: [RNModels.Configuration: FileProtocol]
    }

    public struct iOS: CoderOutputiOSProtocol, AutoGenerateProtocol
    {
        public let sourcesFolder: FolderProtocol

        public let xcconfigFile: FileProtocol
        public let rnConfigurationModelFactorySwiftFile: FileProtocol
        public let infoPlistRNConfiguration: FileProtocol
        public let infoPlistRNConfigurationTests: FileProtocol
        public let rnConfigurationModelSwiftFile: FileProtocol
        public let jsBridge: FileProtocol

        public func writeDefaultsToFiles() throws
        {
            try rnConfigurationModelFactorySwiftFile.write(string: Coder.rnConfigurationModelFactoryProtocolDefault)
            try infoPlistRNConfiguration.write(string: PlistWriter.plistLinesXmlDefault)
            try rnConfigurationModelSwiftFile.write(string: Coder.rnConfigurationModelDefault_TOP + "\n\(Coder.rnConfigurationModelDefault_BOTTOM)")
        }
    }
}
