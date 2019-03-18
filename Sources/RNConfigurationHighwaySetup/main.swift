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
import Arguments
import Highway
import Terminal
import RNConfigurationPrepare
import SourceryWorker

let signPost = SignPost.shared

let xcbuild = XCBuild()
let highWay: Highway!
let highwayRunner: HighwayRunner!
let dispatchGroup = DispatchGroup()

func handleSourceryOutput(_ sourceryOutput: @escaping SourceryWorker.SyncOutput) { do { signPost.verbose("\(try sourceryOutput())") } catch { signPost.error("\(error)") } }
func handleTestOutput(_ testOutput: @escaping HighwayRunner.SyncTestOutput) { do { signPost.verbose("\(try testOutput())") } catch { signPost.error("\(error)") } }

do {
    let srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()
    let dependecyService = DependencyService(in: srcRoot)
    let package = try Highway.package(for: srcRoot, dependencyService: dependecyService)
    highWay = try Highway(package:  (package: package, executable: "RNConfigurationHighwaySetup"), dependencyService: dependecyService, swiftPackageWithSourceryFolder: srcRoot)
    highwayRunner = HighwayRunner(highway: highWay, dispatchGroup: dispatchGroup)
    
    let reactNativeFolder = srcRoot
    let prepareCode = try PrepareCode(reactNativeFolder: reactNativeFolder)
    let reactNativeConfigworkspace = try? reactNativeFolder.subfolder(named: "/ios/ReactNativeConfig.xcworkspace")
    
    do {
        SignPost.shared.message("🏗 PREPARE **RNConfiguration** ...")

        try prepareCode.attempt()
        
        highwayRunner.runSourcery(handleSourceryOutput)
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
           
            highwayRunner.runTests(handleTestOutput)
            dispatchGroup.wait()
            
            guard highwayRunner.errors?.count ?? 0 <= 0 else {
                SignPost.shared.error("""
                    ❌ PREPARE **RNConfiguration**
                    
                    \(highwayRunner.errors!)
                    
                    ❌
                    ♥️ Fix it by adding environment files
                    \(ConfigurationDisk.JSONFileName.allCases.map { "* \($0.rawValue)"}.joined(separator: "\n"))
                    """
                )
                exit(EXIT_FAILURE)
            }
            SignPost.shared.message("🏗 PREPARE **RNConfiguration** ✅")
            
            exit(EXIT_SUCCESS)
        }
       
        dispatchMain()
        
        do {
//            try TestableSchemes.allCases.forEach { scheme in
//
//                signPost.message("🧪 TESTING \(scheme.rawValue)")
//
//                // xcodebuild test -workspace ios/ReactNativeConfig.xcworkspace -scheme RNConfiguration-macOS
//                let destination = DestinationFactory().simulator(.iOS, name: "iPhone XR", os: .iOS(version: "12.0"), id: nil)
//                let testRunner = try TestRunner(
//                    xcbuild: xcbuild,
//                    testOptions: try MinimalTestOptions(
//                        scheme: scheme.rawValue,
//                        workspace: workspace,
//                        xcodebuild: xcbuild,
//                        destination: destination
//                    )
//                )
//
//                do {
//                    try testRunner.attempt()
//                    signPost.message("🧪 TESTING \(scheme.rawValue) ✅")
//                } catch {
//                    throw "\(scheme.rawValue)\n❌\(error)\n"
//                }
//
//            }
        } catch {
            signPost.message("\n⚠️\nFor now ignoring test errors\n \(error)\n⚠️")
        }
        
        
    }
    
   
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
