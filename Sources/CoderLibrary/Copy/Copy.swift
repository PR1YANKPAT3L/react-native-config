//
//  Copy.swift
//  Coder
//
//  Created by Stijn Willems on 12/06/2019.
//

import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

public struct Copy: CopyProtocol, AutoGenerateProtocol
{
    private let output: CoderOutputProtocol
    private let terminal: TerminalProtocol
    private let system: SystemProtocol
    private let signPost: SignPostProtocol

    public init(
        output: CoderOutputProtocol,
        terminal: TerminalProtocol = Terminal.shared,
        system: SystemProtocol = System.shared,
        signPost: SignPostProtocol = SignPost.shared
    )
    {
        self.output = output
        self.terminal = terminal
        self.system = system
        self.signPost = signPost
    }

    /**
     Takes the files from the original output and sets them in the folder you provide.
     The destination folder will be deleted before files are copied to it

     This is done because when you checkout the spac kage it is in a read only folder.
     You can ignore the created folder in git as it will be recreated every time you update the configuration.

     - parameters:
         - yourSrcRoot: folder where a folder with name copyToFolderName will be created
         - copyToFolderName: name of  the folder to be created
     - throws: HighwayError
     - returns: Folder that can be used to configure a Coder

     */
    public func attempt(to yourSrcRoot: FolderProtocol, xcodeProjectName: String) throws
    {
        do
        {
            let xcodeproj = try yourSrcRoot.createSubfolderIfNeeded(withName: xcodeProjectName + ".xcodeproj")

            let rnConfiguration = try output.ios.rnConfigurationModelSwiftFile.parentFolder()

            let ios = try yourSrcRoot.createSubfolderIfNeeded(withName: "ios")
            let iosConfiguration = try ios.createSubfolderIfNeeded(withName: "iOSConfiguration")

            let sources = try yourSrcRoot.createSubfolderIfNeeded(withName: "Sources")

            let rnConfigurationName = "RNConfiguration"

            if sources.containsSubfolder(possiblyInvalidName: rnConfigurationName)
            {
                let folder = try sources.subfolder(named: rnConfigurationName)
                try folder.delete()
            }

            _ = try rnConfiguration.copy(to: sources)

            _ = try output.ios.sourcesFolder.copy(to: iosConfiguration)

            if xcodeproj.containsFile(possiblyInvalidName: output.ios.infoPlistRNConfiguration.name)
            {
                try xcodeproj.file(named: output.ios.infoPlistRNConfiguration.name).delete()
            }

            _ = try output.ios.infoPlistRNConfiguration.copy(to: xcodeproj)
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }
}
