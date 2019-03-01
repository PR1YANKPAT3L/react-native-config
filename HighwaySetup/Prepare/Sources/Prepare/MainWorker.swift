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

public protocol MainWorkerProtocol {
    
    func attempt() throws
    
}

public struct MainWorker: MainWorkerProtocol {
    
    private let reactNativeFolder: FolderProtocol
    private let signPost: SignPostProtocol

    public init(reactNativeFolder: FolderProtocol, signPost: SignPostProtocol = SignPost.shared) {
        self.reactNativeFolder = reactNativeFolder
        self.signPost = signPost
    }
    
    public func attempt() throws {
        
        let disk = try ConfigurationDisk(reactNativeFolder: reactNativeFolder)
        try disk.code.clearContentAllFiles()
        
        let builds = try Builds(from: disk)
        
        SignPost.shared.verbose("""
            🚀 Env read from
            \(disk.inputJSON.debug)
            \(disk.inputJSON.release)
            \(String(describing: disk.inputJSON.local))
            \(String(describing: disk.inputJSON.betaRelease))
            ...
            """
        )
        
        SignPost.shared.verbose("""
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
        
        SignPost.shared.message("🚀 Generating SWIFT code")
        
        let coder = Coder(disk: disk, builds: builds, signPost: signPost)
        
        try coder.generateConfigurationWorker()
        try coder.generateConfigurationForCurrentBuild()
        try coder.genereateInfoPlistForFrameworkForAllBuildsWithPlaceholders()
        
        SignPost.shared.message("🚀 Generating SWIFT code ✅")

    }
}
