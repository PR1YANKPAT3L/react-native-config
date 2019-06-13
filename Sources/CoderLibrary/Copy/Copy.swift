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
        signPost.message(pretty_function() + " ...")
        do
        {
            let xcodeproj = try yourSrcRoot.createSubfolderIfNeeded(withName: xcodeProjectName + ".xcodeproj")

            let rnConfiguration = try output.ios.rnConfigurationModelSwiftFile.parentFolder()

            let ios = try yourSrcRoot.createSubfolderIfNeeded(withName: "ios")

            let sources = try yourSrcRoot.createSubfolderIfNeeded(withName: "Sources")

            // COPY RNCOFIGURATION

            let rnConfigurationName = "RNConfiguration"

            if sources.containsSubfolder(possiblyInvalidName: rnConfigurationName)
            {
                let destination = try sources.subfolder(named: rnConfigurationName)
                try rnConfiguration.makeFileSequence().forEach
                { file in
                    if destination.containsFile(possiblyInvalidName: file.name)
                    {
                        try destination.file(named: file.name).write(data: try file.read())
                    }
                    else
                    {
                        try file.copy(to: destination)
                    }
                }
            }
            else
            {
                _ = try rnConfiguration.copy(to: sources)
            }

            // COPY IOS PROJECT

            if !ios.containsSubfolder(possiblyInvalidName: "GeneratedEnvironmentiOS")
            {
                let iosConfiguration = try ios.createSubfolderIfNeeded(withName: "GeneratedEnvironmentiOS")
                _ = try output.ios.sourcesFolder.copy(to: iosConfiguration)
            }

            if xcodeproj.containsFile(possiblyInvalidName: output.ios.infoPlistRNConfiguration.name)
            {
                try xcodeproj.file(named: output.ios.infoPlistRNConfiguration.name).write(data: try output.ios.infoPlistRNConfiguration.read())
            }
            else
            {
                _ = try output.ios.infoPlistRNConfiguration.copy(to: xcodeproj)
            }

            signPost.message(pretty_function() + " ✅")
        }
        catch
        {
            signPost.message(pretty_function() + " ❌")
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }
}
