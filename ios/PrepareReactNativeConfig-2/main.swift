//
//  main.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 29/01/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import ZFile
import SignPost


do {
    let currentFolder = FileSystem.shared.currentFolder
    SignPost.shared.message("🚀 PREPARE from Current Folder:\n \(currentFolder)\n")

    let reactNativeFolder = try FileSystem.shared.currentFolder.parentFolder().parentFolder().parentFolder().parentFolder().parentFolder()
    SignPost.shared.message("🚀 ReactNativeConfig RN root:\n \(reactNativeFolder)\n")

    let main = MainWorker(reactNativeFolder: reactNativeFolder)

    try main.attempt()
    
    SignPost.shared.message("🚀 ReactNativeConfig main.swift ✅")
    
    exit(EXIT_SUCCESS)
} catch {
    SignPost.shared.error("""
        ❌ Prepare React Native Config
        
        \(error)
        
        ❌
        ♥️ Fix it by adding \(Disk.FileName.JSON.debug) & \(Disk.FileName.JSON.release) or (optionally) \(Disk.FileName.JSON.local)at <#react native#>/
        """
    )
    exit(EXIT_FAILURE)
}
