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
import XCBuild
import Task
import Arguments


do {
    let disk = try Disk()
    let reactNativeFolder = disk.srcRoot

    do {
        let main = MainWorker(reactNativeFolder: reactNativeFolder)
        try main.attempt()

        do {
            SignPost.shared.verbose("🚀 Running tests on configuration preparition")
            let xcbuild = XCBuild(system: try LocalSystem())
            
            // xcodebuild test -workspace ios/ReactNativeConfig.xcworkspace -scheme RNConfiguration-macOS
            let workspace = try reactNativeFolder.subfolder(named: "/ios/ReactNativeConfig.xcworkspace")
            let testOptions = try MinimalTestOptions(scheme: "PrepareReactNativeConfig-script", workspace: workspace)
            let testRunner = try TestRunner(xcbuild: xcbuild, testOptions: testOptions)
            try testRunner.attempt()
            SignPost.shared.verbose("✅ Prepepare tests success")

        } catch {
            SignPost.shared.error("⚠️ First time with new configuration tests can fail, they should not in the future. \n\(error)\n")
        }
        
        SignPost.shared.message("🚀 ReactNativeConfig main.swift ✅")
        
        exit(EXIT_SUCCESS)
    } catch let XCBuild.TestRunError.testsFailed(report: testReport) {
        SignPost.shared.error("""
            ❌ PREPARE **RNConfiguration** tests failed
            \(testReport)
            """
        )
        exit(EXIT_FAILURE)
    } catch {
        SignPost.shared.error("""
            ❌ PREPARE **RNConfiguration**
            
            \(error)
            
            ❌
            ♥️ Fix it by adding environment files
            \(ConfigurationDisk.JSONFileName.allCases.map { "* \($0.rawValue)"}.joined(separator: "\n"))
            """
        )
        exit(EXIT_FAILURE)
    }
    
} catch {
    SignPost.shared.error("""
        ❌ PREPARE **RNConfiguration**
        
        \(error)
        
        ❌
        ♥️ Fix it by adding environment files
        \(ConfigurationDisk.JSONFileName.allCases.map { "* \($0.rawValue)"}.joined(separator: "\n"))
        """
    )
    exit(EXIT_FAILURE)
}
