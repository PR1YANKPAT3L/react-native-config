//
//  TestSetup.swift
//  PrepareReactNativeconfigTests
//
//  Created by Stijn on 26/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import ZFile
import PrepareReactNativeConfig

func reactNativeFolder() throws -> FolderProtocol {
    
    guard let rnoffset = (CommandLine
        .arguments
        .first { $0.hasPrefix(MainWorker.reactNativeFolderPrefixOption) }?
        .replacingOccurrences(of: MainWorker.reactNativeFolderPrefixOption, with: "")) else {
            throw MainWorker.Error()
    }
    
    return try Folder(relativePath: rnoffset)
}
