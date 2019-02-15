//
//  main.swift
//  PrepareReactNativeconfig
//
//  Created by Stijn on 29/01/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import ZFile
import SignPost

let currentFolder = FileSystem.shared.currentFolder

let signPost = SignPost.shared
signPost.message("🚀 ReactNativeConfig main.swift\nExecuted at path \(currentFolder.path)\n...")

do {
    
    let disk = try Disk(reactNativeFolder: try currentFolder.parentFolder())
    let builds = try writeToPlatformReadableConfiguarationFiles(from: disk)
    
    SignPost.shared.message("""
        🚀 Env read from
            \(disk.inputJSON.debug)
            \(disk.inputJSON.release)
            \(String(describing: disk.inputJSON.local))
         ...
        """
    )
    
    SignPost.shared.message("""
        🚀 Written to config files
        # ios
            \(disk.iOS.debug)
            \(disk.iOS.release)
            \(String(describing: disk.iOS.local))
        # android
            \(disk.android.debug)
            \(disk.android.release)
            \(String(describing: disk.android.local))
        ...
        """
    )
    
    SignPost.shared.verbose("Writing environment variables to swift files and plist")
    
    let coder = Coder(disk: disk, builds: builds)
    
    try coder.generateConfigurationWorker()
    try coder.generateConfigurationForCurrentBuild()
    try coder.genereateInfoPlistForFrameworkForAllBuilds()
    
    SignPost.shared.message("🚀 ReactNativeConfig main.swift ✅")
    
    exit(EXIT_SUCCESS)
} catch {
    SignPost.shared.error("""
    ❌ Prepare React Native Config
    
         \(error)
    
    ❌
        ♥️ Fix it by adding \(Disk.debugJSON) & \(Disk.releaseJSON) or (optionally) \(Disk.localJSON)at <#react native#>/
    """
    )
    exit(EXIT_FAILURE)
}

