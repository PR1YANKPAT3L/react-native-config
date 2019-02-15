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
            \(disk.debugJSONfile)
            \(disk.releaseJSONfile)
            \(String(describing: disk.localJSONfile))
         ...
        """
    )
    
    SignPost.shared.message("""
        🚀 Written to config files
        # ios
            \(disk.debugXconfigFile)
            \(disk.releaseXconfigFile)
            \(String(describing: disk.localXconfigFile))
        # android
            \(disk.debugAndroidConfigurationFile)
            \(disk.releaseAndroidConfigurationFile)
            \(String(describing: disk.localAndroidConfigurationFile))
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

