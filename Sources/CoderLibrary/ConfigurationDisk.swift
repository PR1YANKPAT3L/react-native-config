//
//  EnvironmentFiles.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Errors
import Foundation
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
    var inputJSON: InputProtocol { get }
    var androidFolder: FolderProtocol { get }
    var iosFolder: FolderProtocol { get }
    var iOS: OutputProtocol { get }
    var android: OutputProtocol { get }
    var code: GeneratedCodeProtocol { get }

    // sourcery:end
}

// sourcery:AutoMockable
public protocol InputProtocol
{
    // sourcery:inline:ConfigurationDisk.Input.AutoGenerateProtocol
    var debug: FileProtocol { get }
    var release: FileProtocol { get }
    var local: FileProtocol? { get }
    var betaRelease: FileProtocol? { get }
    // sourcery:end
}

// sourcery:AutoMockable
public protocol OutputProtocol
{
    // sourcery:inline:ConfigurationDisk.Output.AutoGenerateProtocol
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

    func clearContentAllFiles() throws
    // sourcery:end
}

// MARK: - Struct

// sourcery:AutoGenerateProtocol
public struct ConfigurationDisk: ConfigurationDiskProtocol
{
    public static let projectNameWithPrepareScript: String = "react-native-config.xcodeproj"

    // MARK: - react-native-config : folders of this module

    public let environmentJsonFilesFolder: FolderProtocol
    public let rnConfigurationSourcesFolder: FolderProtocol
    public let rnConfigurationBridgeSourcesFolder: FolderProtocol

    // MARK: - destination project

    public let inputJSON: InputProtocol

    public let androidFolder: FolderProtocol
    public let iosFolder: FolderProtocol

    public let iOS: OutputProtocol
    public let android: OutputProtocol

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

            inputJSON = Input(
                debug: debugJSON,
                release: releaseJSON,
                local: localJSON,
                betaRelease: betaReleaseJSON
            )

            androidFolder = try rnConfigurationSrcRoot.subfolder(named: "android")
            iosFolder = try rnConfigurationSrcRoot.subfolder(named: "ios")
            self.environmentJsonFilesFolder = rnConfigurationSrcRoot

            var localXconfigFile: FileProtocol?
            var localAndroidConfigurationFile: FileProtocol?
            var betaReleaseXconfigFile: FileProtocol?
            var betaReleaseAndroidConfigurationFile: FileProtocol?

            if localJSON != nil
            {
                localXconfigFile = try iosFolder.createFileIfNeeded(named: "Local.xcconfig")
                localAndroidConfigurationFile = try androidFolder.createFileIfNeeded(named: ".env.local")
            }
            else
            {
                localXconfigFile = nil
                localAndroidConfigurationFile = nil
            }

            if betaReleaseJSON != nil
            {
                betaReleaseXconfigFile = try iosFolder.createFileIfNeeded(named: "BetaRelease.xcconfig")
                betaReleaseAndroidConfigurationFile = try androidFolder.createFileIfNeeded(named: ".env.betaRelease")
            }
            else
            {
                betaReleaseXconfigFile = nil
                betaReleaseAndroidConfigurationFile = nil
            }

            iOS = Output(
                debug: try iosFolder.createFileIfNeeded(named: "Debug.xcconfig"),
                release: try iosFolder.createFileIfNeeded(named: "Release.xcconfig"),
                local: localXconfigFile,
                betaRelease: betaReleaseXconfigFile
            )

            android = Output(
                debug: try androidFolder.createFileIfNeeded(named: ".env.debug"),
                release: try androidFolder.createFileIfNeeded(named: ".env.release"),
                local: localAndroidConfigurationFile,
                betaRelease: betaReleaseAndroidConfigurationFile
            )

            if !rnConfigurationSrcRoot.containsSubfolder(named: ConfigurationDisk.projectNameWithPrepareScript)
            {
                do
                {
                    signPost.message("🏗 generating react-native-config.xcodeproj ...")
                    let process = try self.system.process("swift")
                    process.currentDirectoryPath = rnConfigurationSrcRoot.path
                    process.arguments = ["package", "generate-xcodeproj"]

                    try terminal.runProcess(process)
                    signPost.message("🏗 generating react-native-config.xcodeproj ✅")
                }
                catch
                {
                    throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
                }
            }

            code = Output.GeneratedCode(
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
    public struct Input: InputProtocol
    {
        public let debug: FileProtocol
        public let release: FileProtocol
        public let local: FileProtocol?
        public let betaRelease: FileProtocol?
    }

    // sourcery:AutoGenerateProtocol
    public struct Output: OutputProtocol
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

            public func clearContentAllFiles() throws
            {
                try rnConfigurationModelFactorySwiftFile.write(
                    string: """
                        import Foundation

                        /// ⚠️ File is generated and ignored in git. To change it change /RNConfigurationHighwaySetup/main.swift
                        @objc public class RNConfigurationModelFactory: NSObject {
                        }
                    """
                )
                try infoPlistRNConfiguration.write(string: """
                    <?xml version="1.0" encoding="UTF-8"?>
                    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
                    <plist version="1.0">
                    <dict>
                    <key>CFBundleDevelopmentRegion</key>
                        <string>$(DEVELOPMENT_LANGUAGE)</string>
                    <key>CFBundleExecutable</key>
                        <string>$(EXECUTABLE_NAME)</string>
                    <key>CFBundleIdentifier</key>
                        <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
                    <key>CFBundleInfoDictionaryVersion</key>
                    <string>6.0</string>
                    <key>CFBundleName</key>
                        <string>$(PRODUCT_NAME)</string>
                    <key>CFBundlePackageType</key>
                        <string>FMWK</string>
                    <key>CFBundleShortVersionString</key>
                        <string>1.0</string>
                    <key>CFBundleVersion</key>
                        <string>$(CURRENT_PROJECT_VERSION)</string>
                    </dict>
                    </plist>

                """)
                try rnConfigurationModelSwiftFile.write(string: """
                    //⚠️ File is generated and ignored in git. To change it change /RNConfigurationHighwaySetup/main.swift

                    public struct RNConfigurationModel: Codable {
                    }
                """)
            }
        }
    }
}
