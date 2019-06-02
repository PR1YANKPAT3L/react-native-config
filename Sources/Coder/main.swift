//
//  main.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 29/01/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import CoderLibrary
import Errors
import Foundation
import HighwayLibrary
import SignPost
import SourceryWorker
import Terminal
import ZFile

var configurationDisk: ConfigurationDiskProtocol!
var sampler: JSONToCodeSamplerProtocol!
var coder: CoderProtocol!

doContinue(pretty_function() + " setup")
{
    try setup(packageName: "react-native-config", try File(path: #file).parentFolder().parentFolder())
    try setupHighwayRunner(gitHooksPrePushExecutableName: "PrePushAndPR")
    try highwayRunner.addGithooksPrePush()
    configurationDisk = try ConfigurationDisk(rnConfigurationSrcRoot: srcRoot, environmentJsonFilesFolder: srcRoot)
    sampler = try JSONToCodeSampler(from: configurationDisk)
    coder = Coder(disk: configurationDisk, builds: sampler)
}

doContinue(pretty_function() + " coder")
{
    let config = try coder.attempt()
    let xcode = try srcRoot.subfolder(named: "react-native-config.xcodeproj")
    //        try coder.attemptWriteInfoPlistToAllPlists(in: xcode)

    // enable and have a look at the file to make it work if you want.

    highwayRunner.runSourcery(handleSourceryOutput)

    dispatchGroup.notifyMain
    {
        highwayRunner.runSwiftformat(handleSwiftformat)
        highwayRunner.runTests(handleTestOutput)

        dispatchGroup.notifyMain { highwayRunner.exitSuccesOrFail(location: pretty_function()) }
    }
}

dispatchMain()
