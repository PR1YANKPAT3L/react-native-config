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
import PrepareForConfigurationLibrary
import SignPost
import SourceryWorker
import Terminal
import ZFile

let xcbuild = XCBuild()

do
{
    srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()

    try setupHighwayRunner(folder: srcRoot)

    let prepareCode = try PrepareCode(
        rnConfigurationSrcRoot: srcRoot,
        environmentJsonFilesFolder: srcRoot,
        signPost: signPost
    )

    do
    {
        try prepareCode.attempt()
        // enable and have a look at the file to make it work if you want.
        try highwayRunner.addGithooksPrePush()

        highwayRunner.runSourcery(handleSourceryOutput)

        dispatchGroup.notifyMain
        {
            highwayRunner.runSwiftformat(handleSwiftformat)
            highwayRunner.runTests(handleTestOutput)

            dispatchGroup.notifyMain
            {
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
