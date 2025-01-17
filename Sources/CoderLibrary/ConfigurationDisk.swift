//
//  EnvironmentFiles.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Errors
import Foundation
import HighwayLibrary
import SignPost
import Terminal
import ZFile

// MARK: - Protocols

// sourcery:AutoMockable
public protocol ConfigurationDiskProtocol
{
    // sourcery:inline:ConfigurationDisk.AutoGenerateProtocol
    static var projectNameWithPrepareScript: String { get }
    var environmentJsonFilesFolder: FolderProtocol { get }
    var rnConfigurationSourcesFolder: FolderProtocol { get }
    var rnConfigurationBridgeSourcesFolder: FolderProtocol { get }
    var inputJSON: JSONFileProtocol { get }
    var androidFolder: FolderProtocol { get }
    var iosFolder: FolderProtocol { get }
    var xcconfigFile: FileProtocol { get }
    var android: OutputFilesProtocol { get }
    var code: GeneratedCodeProtocol { get }

    // sourcery:end
}

// sourcery:AutoMockable
public protocol JSONFileProtocol
{
    // sourcery:inline:ConfigurationDisk.JSONFile.AutoGenerateProtocol
    var debug: FileProtocol { get }
    var release: FileProtocol { get }
    var local: FileProtocol? { get }
    var betaRelease: FileProtocol? { get }
    // sourcery:end
}

// sourcery:AutoMockable
public protocol OutputFilesProtocol
{
    // sourcery:inline:ConfigurationDisk.OutputFile.AutoGenerateProtocol
    var debug: FileProtocol { get }
    var release: FileProtocol { get }
    var local: FileProtocol? { get }
    var betaRelease: FileProtocol? { get }
    // sourcery:end
}

// sourcery:AutoMockable
public protocol GeneratedCodeProtocol
{
    // sourcery:inline:ConfigurationDisk.Output.GeneratedCode.AutoGenerateProtocol
    var rnConfigurationModelFactorySwiftFile: FileProtocol { get }
    var infoPlistRNConfiguration: FileProtocol { get }
    var infoPlistRNConfigurationTests: FileProtocol { get }
    var rnConfigurationModelSwiftFile: FileProtocol { get }
    var rnConfigurationBridgeObjectiveCMFile: FileProtocol { get }

    func writeDefaultsToFiles() throws
    // sourcery:end
}

// MARK: - Struct

// sourcery:AutoGenerateProtocol
public struct ConfigurationDisk: ConfigurationDiskProtocol
{
    public static let projectNameWithPrepareScript: String = "Coder.xcodeproj"

    // MARK: - Coder : folders of this module

    public let environmentJsonFilesFolder: FolderProtocol
    public let rnConfigurationSourcesFolder: FolderProtocol
    public let rnConfigurationBridgeSourcesFolder: FolderProtocol

    // MARK: - destination project

    public let inputJSON: JSONFileProtocol

    public let androidFolder: FolderProtocol
    public let iosFolder: FolderProtocol

    public let xcconfigFile: FileProtocol
    public let android: OutputFilesProtocol

    public let code: GeneratedCodeProtocol

    // MARK: - Private

    private let signPost: SignPostProtocol
    private let terminal: TerminalProtocol
    private let system: SystemProtocol

    // MARK: - Init

    public init(
        rnConfigurationSrcRoot: FolderProtocol,
        environmentJsonFilesFolder: FolderProtocol,
        fileSystem: FileSystemProtocol = FileSystem.shared,
        signPost: SignPostProtocol = SignPost.shared,
        terminal: TerminalProtocol = Terminal.shared,
        system: SystemProtocol = System.shared
    ) throws
    {
        self.terminal = terminal
        self.system = system

        do
        {
            self.signPost = signPost

            var debugJSON: FileProtocol!
            var releaseJSON: FileProtocol!
            var localJSON: FileProtocol?
            var betaReleaseJSON: FileProtocol?

            debugJSON = try environmentJsonFilesFolder.file(named: ConfigurationDisk.JSONFileName.debug.rawValue)
            releaseJSON = try environmentJsonFilesFolder.file(named: ConfigurationDisk.JSONFileName.release.rawValue)
            do { localJSON = try environmentJsonFilesFolder.file(named: ConfigurationDisk.JSONFileName.local.rawValue) } catch { signPost.message("💁🏻‍♂️ If you would like you can add \(ConfigurationDisk.JSONFileName.local.rawValue) to have a local config. Ignoring for now") }
            do { betaReleaseJSON = try environmentJsonFilesFolder.file(named: ConfigurationDisk.JSONFileName.betaRelease.rawValue) } catch { signPost.message("💁🏻‍♂️ If you would like you can add \(ConfigurationDisk.JSONFileName.betaRelease.rawValue) to have a BetaRelease config. Ignoring for now") }

            rnConfigurationSourcesFolder = try rnConfigurationSrcRoot.subfolder(named: "Sources/RNConfiguration")
            rnConfigurationBridgeSourcesFolder = try rnConfigurationSrcRoot.subfolder(named: "ios/Sources/RNConfigurationBridge")

            inputJSON = JSONFile(
                debug: debugJSON,
                release: releaseJSON,
                local: localJSON,
                betaRelease: betaReleaseJSON
            )

            androidFolder = try rnConfigurationSrcRoot.subfolder(named: "android")
            iosFolder = try rnConfigurationSrcRoot.subfolder(named: "ios")
            self.environmentJsonFilesFolder = rnConfigurationSrcRoot

            var localAndroidConfigurationFile: FileProtocol?
            var betaReleaseAndroidConfigurationFile: FileProtocol?

            if localJSON != nil
            {
                localAndroidConfigurationFile = try androidFolder.createFileIfNeeded(named: ".env.local")
            }
            else
            {
                localAndroidConfigurationFile = nil
            }

            if betaReleaseJSON != nil
            {
                betaReleaseAndroidConfigurationFile = try androidFolder.createFileIfNeeded(named: ".env.betaRelease")
            }
            else
            {
                betaReleaseAndroidConfigurationFile = nil
            }

            xcconfigFile = try iosFolder.createFileIfNeeded(named: "Coder.xcconfig")

            android = OutputFiles(
                debug: try androidFolder.createFileIfNeeded(named: ".env.debug"),
                release: try androidFolder.createFileIfNeeded(named: ".env.release"),
                local: localAndroidConfigurationFile,
                betaRelease: betaReleaseAndroidConfigurationFile
            )

            if !rnConfigurationSrcRoot.containsSubfolder(possiblyInvalidName: ConfigurationDisk.projectNameWithPrepareScript)
            {
                highway.generateXcodeProject(override: xcconfigFile, handleSwiftPackageGenerateXcodeProject)
                dispatchGroup.wait()
            }

            code = OutputFiles.GeneratedCode(
                rnConfigurationModelFactorySwiftFile: try rnConfigurationSourcesFolder.file(named: "RNConfigurationModelFactory.swift"),
                infoPlistRNConfiguration: try rnConfigurationSrcRoot.file(named: "\(ConfigurationDisk.projectNameWithPrepareScript)/RNConfiguration_Info.plist"),
                infoPlistRNConfigurationTests: try rnConfigurationSrcRoot.file(named: "\(ConfigurationDisk.projectNameWithPrepareScript)/RNConfigurationTests_Info.plist"),
                rnConfigurationModelSwiftFile: try rnConfigurationSourcesFolder.file(named: "RNConfigurationModel.swift"),
                rnConfigurationBridgeObjectiveCMFile: try rnConfigurationBridgeSourcesFolder.file(named: "ReactNativeConfig.m")
            )
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }
}

// MARK: - Inclosed  Enum & structs

extension ConfigurationDisk
{
    public enum JSONFileName: String, CaseIterable
    {
        case debug = "env.debug.json"
        case release = "env.release.json"
        case local = "env.local.json"
        case betaRelease = "env.betaRelease.json"
    }

    // sourcery:AutoGenerateProtocol
    public struct JSONFile: JSONFileProtocol
    {
        public let debug: FileProtocol
        public let release: FileProtocol
        public let local: FileProtocol?
        public let betaRelease: FileProtocol?
    }

    // sourcery:AutoGenerateProtocol
    public struct OutputFiles: OutputFilesProtocol
    {
        public let debug: FileProtocol
        public let release: FileProtocol
        public let local: FileProtocol?
        public let betaRelease: FileProtocol?

        // sourcery:AutoGenerateProtocol
        public struct GeneratedCode: GeneratedCodeProtocol
        {
            public let rnConfigurationModelFactorySwiftFile: FileProtocol
            public let infoPlistRNConfiguration: FileProtocol
            public let infoPlistRNConfigurationTests: FileProtocol
            public let rnConfigurationModelSwiftFile: FileProtocol
            public let rnConfigurationBridgeObjectiveCMFile: FileProtocol

            public func writeDefaultsToFiles() throws
            {
                try rnConfigurationModelFactorySwiftFile.write(string: Coder.rnConfigurationModelFactoryProtocolDefault)
                try infoPlistRNConfiguration.write(string: PlistWriter.plistLinesXmlDefault)
                try rnConfigurationModelSwiftFile.write(string: Coder.rnConfigurationModelDefault_TOP + "\n\(Coder.rnConfigurationModelDefault_BOTTOM)")
            }
        }
    }
}
