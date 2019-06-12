//
//  Protocols.swift
//  CopyConfigurationToYourProjectLibraryMock
//
//  Created by Stijn Willems on 12/06/2019.
//

import Foundation
import SourceryAutoProtocols
import ZFile

public protocol CopyProtocol: AutoMockable
{
    // sourcery:inline:Copy.AutoGenerateProtocol

    func copy(to yourSrcRoot: FolderProtocol, copyToFolderName: String) throws
    // sourcery:end
}
