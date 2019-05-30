//
//  main.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 29/01/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Errors
import Foundation
import HighwayLibrary
import RNConfigurationPrepare
import SignPost
import SourceryWorker
import Terminal
import ZFile

let signPost = SignPost.shared

let xcbuild = XCBuild()
let highWay: Highway!
let highwayRunner: HighwayRunner!
let dispatchGroup = DispatchGroup()

do
{
    signPost.message("🏗\(pretty_function()) ...")

    var environmentJsonFilesFolder: FolderProtocol = FileSystem.shared.currentFolder

    if try environmentJsonFilesFolder.parentFolder().name == "Products"
    {
        // Case where we are building from xcode
        // .build/RNConfigurationHighwaySetup/Build/Products/Debug/env.debug.json
        let relativePath = "../../../../"
        environmentJsonFilesFolder = try environmentJsonFilesFolder.subfolder(named: relativePath)
        signPost.message("⚠️ building from xcode detected, moving \(relativePath) up")
        signPost.message("ℹ️ .env.<#configuration#>.json are expected to be in \n\(environmentJsonFilesFolder)")
    }

    let rnConfigurationSrcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()
    let dependecyService = DependencyService(in: rnConfigurationSrcRoot)
    let dumpService = DumpService(swiftPackageFolder: rnConfigurationSrcRoot)
    let package = try Highway.package(for: rnConfigurationSrcRoot, dependencyService: dependecyService, dumpService: dumpService)
    let sourceryBuilder = SourceryBuilder(dependencyService: dependecyService)

    highWay = try Highway(package: package, dependencyService: dependecyService, sourceryBuilder: sourceryBuilder)
    highwayRunner = HighwayRunner(highway: highWay, dispatchGroup: dispatchGroup)

    let prepareCode = try PrepareCode(rnConfigurationSrcRoot: rnConfigurationSrcRoot, environmentJsonFilesFolder: environmentJsonFilesFolder, signPost: signPost)

    do
    {
        try prepareCode.attempt()
        // enable and have a look at the file to make it work if you want.
        try highwayRunner.addGithooksPrePush()

        highwayRunner.runSourcery(handleSourceryOutput)

        dispatchGroup.notify(queue: DispatchQueue.main)
        {
            highwayRunner.runSwiftformat(handleSwiftformat)
            highwayRunner.runTests(handleTestOutput)
            dispatchGroup.wait()

            guard highwayRunner.errors?.count ?? 0 <= 0 else
            {
                SignPost.shared.error(
                    """
                    ❌ PREPARE **RNConfiguration**
                    
                    \(highwayRunner.errors!)
                    
                    ❌
                    ♥️ Fix it by adding environment files
                    \(ConfigurationDisk.JSONFileName.allCases.map { "* \($0.rawValue)" }.joined(separator: "\n"))
                    """
                )
                exit(EXIT_FAILURE)
            }
            signPost.message("🏗\(pretty_function()) ✅")

            exit(EXIT_SUCCESS)
        }

        dispatchMain()
    }
}
catch
{
    signPost.error(
        """
        ❌ \(pretty_function())
        
        \(error)
        
        ❌
        ♥️ Fix it by adding environment files
        \(ConfigurationDisk.JSONFileName.allCases.map { "* \($0.rawValue)" }.joined(separator: "\n"))
        """
    )
    exit(EXIT_FAILURE)
}
