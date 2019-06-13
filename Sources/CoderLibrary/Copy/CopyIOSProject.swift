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

open class CopyIOSProject: CopyIOSProjectProtocol, AutoGenerateProtocol
{
    public static var iosSubFolder: String = "GeneratedEnvironmentIOS"

    private let signPost: SignPostProtocol

    public init(
        signPost: SignPostProtocol = SignPost.shared
    )
    {
        self.signPost = signPost
    }

    /**
     If subfolder with name CopyIOSProject.iosSubFolder does not exist it will copy. Otherwise it will not.
     */
    public func attempt(packageSrcRoot: FolderProtocol, to yourSrcRoot: FolderProtocol) throws
    {
        signPost.message(pretty_function() + " ...")
        do
        {
            let iosDestination = try yourSrcRoot.createSubfolderIfNeeded(named: "ios")

            // COPY IOS PROJECT

            if !iosDestination.containsSubfolder(possiblyInvalidName: CopyIOSProject.iosSubFolder)
            {
                let destination = try iosDestination.createSubfolderIfNeeded(named: CopyIOSProject.iosSubFolder)
                _ = try packageSrcRoot.subfolder(named: "ios").copy(to: destination)
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
