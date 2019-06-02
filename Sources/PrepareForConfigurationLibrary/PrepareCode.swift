//
//  MainWorker.swift
//  PrepareReactNativeconfig
//
//  Created by Stijn on 18/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol PrepareCodeProtocol: AutoMockable
{
    // sourcery:inline:PrepareCode.AutoGenerateProtocol
    var coder: Coder { get }
    var disk: ConfigurationDisk { get }
    var builds: Builds { get }
    var rnConfigurationSrcRoot: FolderProtocol { get }
    var environmentJsonFilesFolder: FolderProtocol { get }

    func attempt() throws -> PrepareCode.Config
    func attemptWriteInfoPlistToAllPlists(in folder: FolderProtocol) throws
    // sourcery:end
}

public struct PrepareCode: PrepareCodeProtocol, AutoGenerateProtocol
{
    public let coder: Coder
    public let disk: ConfigurationDisk
    public let builds: Builds

    public let rnConfigurationSrcRoot: FolderProtocol
    public let environmentJsonFilesFolder: FolderProtocol

    public struct Config
    {
        let plist: FileProtocol
        let xcconfig: FileProtocol
    }

    // MARK: - Private

    private let signPost: SignPostProtocol
    private let terminal: TerminalProtocol
    private let system: SystemProtocol

    public init(
        rnConfigurationSrcRoot: FolderProtocol,
        environmentJsonFilesFolder: FolderProtocol,
        signPost: SignPostProtocol = SignPost.shared,
        decoder: JSONDecoder = JSONDecoder(),
        terminal: TerminalProtocol = Terminal.shared,
        system: SystemProtocol = System.shared
    ) throws
    {
        self.rnConfigurationSrcRoot = rnConfigurationSrcRoot
        self.environmentJsonFilesFolder = environmentJsonFilesFolder

        self.signPost = signPost

        disk = try ConfigurationDisk(rnConfigurationSrcRoot: rnConfigurationSrcRoot, environmentJsonFilesFolder: environmentJsonFilesFolder, signPost: signPost)
        builds = try Builds(from: disk, decoder: decoder)
        coder = Coder(disk: disk, builds: builds, signPost: signPost)
        self.terminal = terminal
        self.system = system
    }

    public func attempt() throws -> PrepareCode.Config
    {
        do
        {
            try disk.code.clearContentAllFiles()

            signPost.verbose(
                """
                🚀 Env read from
                \(disk.inputJSON.debug)
                \(disk.inputJSON.release)
                \(String(describing: disk.inputJSON.local))
                \(String(describing: disk.inputJSON.betaRelease))
                ...
                """
            )

            signPost.verbose(
                """
                🚀 Written to config files
                
                # ios
                
                * \(disk.iOS.debug)
                * \(disk.iOS.release)
                * \(String(describing: disk.iOS.local))
                * \(String(describing: disk.iOS.betaRelease))
                
                # android
                
                * \(disk.android.debug)
                * \(disk.android.release)
                * \(String(describing: disk.android.local))
                * \(String(describing: disk.android.betaRelease))
                
                """
            )

            signPost.message("🏗🧙‍♂️ Generating SWIFT code RNConfigurationModel.swift & RNConfigurationModelFactory.swift ...")
            try coder.writeRNConfigurationModelFactory()
            try coder.writeRNConfigurationModel()
            signPost.message("🏗🧙‍♂️ Generating SWIFT code RNConfigurationModel.swift & RNConfigurationModelFactory.swift ✅")

            signPost.message("🏗🧙‍♂️ Generating Plist with build dependend keys ...")
            try coder.writeRNConfigurationPlist()
            signPost.message("🏗🧙‍♂️ Generating Plist with build dependend keys ✅")

            signPost.message("🏗🧙‍♂️ Generating Objective-C to Javascript bridge code - RNConfigurationBridge ...")
            try coder.writeRNConfigurationBridge()
            signPost.message("🏗🧙‍♂️ Generating Objective-C to Javascript bridge code - RNConfigurationBridge ✅")

            // TODO: this should only be one
            return Config(plist: disk.code.infoPlistRNConfiguration, xcconfig: disk.iOS.debug)
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    public func attemptWriteInfoPlistToAllPlists(in folder: FolderProtocol) throws
    {
        try folder.makeFileSequence().forEach
        { file in
            try coder.writeRNConfigurationPlist(to: file)
        }
    }
}
