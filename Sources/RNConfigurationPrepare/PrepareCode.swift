//
//  MainWorker.swift
//  PrepareReactNativeconfig
//
//  Created by Stijn on 18/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import ZFile
import SignPost

public struct PrepareCode {
    
    public let coder: Coder
    public let disk: ConfigurationDisk
    public let builds: Builds
    
    private let reactNativeFolder: FolderProtocol
    private let signPost: SignPostProtocol

    public init(reactNativeFolder: FolderProtocol, signPost: SignPostProtocol = SignPost.shared) throws {
        self.reactNativeFolder = reactNativeFolder
        self.signPost = signPost
        
        disk = try ConfigurationDisk(reactNativeFolder: reactNativeFolder)
        builds = try Builds(from: disk)
        coder = Coder(disk: disk, builds: builds, signPost: signPost)

    }
    
    public func attempt() throws {
        
        try disk.code.clearContentAllFiles()
        
        signPost.verbose("""
            🚀 Env read from
            \(disk.inputJSON.debug)
            \(disk.inputJSON.release)
            \(String(describing: disk.inputJSON.local))
            \(String(describing: disk.inputJSON.betaRelease))
            ...
            """
        )
        
        signPost.verbose("""
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
        
        signPost.message("🏗🧙‍♂️ Generating SWIFT code")
        
        
        try coder.writeRNConfigurationModelFactory()
        try coder.writeRNConfigurationModel()
        try coder.writeRNConfigurationPlist()
        
        signPost.message("🏗🧙‍♂️ Generating SWIFT code ✅")

    }
}
