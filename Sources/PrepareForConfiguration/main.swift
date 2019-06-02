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

do
{
    srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()

    try setupHighwayRunner(folder: srcRoot)
    signPost.message("\(pretty_function()) ...")
    let prepareCode = try PrepareCode(
        rnConfigurationSrcRoot: srcRoot,
        environmentJsonFilesFolder: srcRoot,
        signPost: signPost
    )

    do
    {
        let config = try prepareCode.attempt()
        let xcode = try srcRoot.subfolder(named: "react-native-config")
        try prepareCode.attemptWriteInfoPlistToAllPlists(in: xcode)
        
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
                    for error in highwayRunner.errors!
                    {
                        signPost.error("\(error)")
                    }
                    signPost.error("\(pretty_function()) ❌")
                    exit(EXIT_FAILURE)
                }
                signPost.message("\(pretty_function()) ✅")

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
    signPost.error("\(pretty_function()) ❌")
    exit(EXIT_FAILURE)
}
