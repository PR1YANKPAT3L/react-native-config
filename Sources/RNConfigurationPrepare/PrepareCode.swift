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
    
    public let rnConfigurationSrcRoot: FolderProtocol
    public let environmentJsonFilesFolder: FolderProtocol
    
    // MARK: - Private
    
    private let signPost: SignPostProtocol

    public init(rnConfigurationSrcRoot: FolderProtocol, environmentJsonFilesFolder: FolderProtocol, signPost: SignPostProtocol = SignPost.shared, decoder: JSONDecoder = JSONDecoder()) throws {
        self.rnConfigurationSrcRoot = rnConfigurationSrcRoot
        self.environmentJsonFilesFolder = environmentJsonFilesFolder
        
        self.signPost = signPost
        
        disk = try ConfigurationDisk(rnConfigurationSrcRoot: rnConfigurationSrcRoot, environmentJsonFilesFolder: environmentJsonFilesFolder, signPost: signPost)
        builds = try Builds(from: disk, decoder: decoder)
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
        
        signPost.message("🏗🧙‍♂️ Generating Objective-C to Javascript bridge code - RNConfigurationBridge ...")
        try coder.writeRNConfigurationBridge()
        signPost.message("🏗🧙‍♂️ Generating Objective-C to Javascript bridge code - RNConfigurationBridge ✅")

    }
}
