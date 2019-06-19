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
import Terminal
import ZFile

let xcodeName = "Coder"
var coder: CoderProtocol!
var xcconfig: FileProtocol!

doContinue(pretty_function() + " setup")
{
    try terminalInit(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    try highwayInit(gitHooks: GitHooks(prePushExecutable: (name: "PrePushAndPR", arguments: nil)))

    xcconfig = try srcRoot.file(named: "coder.env.json")

    try highway.addGithooksPrePush()
    #if DEBUG
    #else
        try highway.validateSecrets(in: srcRoot)
    #endif

    let input = try srcRoot.file(named: "coder.env.json")

    let sampler = try JSONToCodeSampler(inputJSONFile: input)

    coder = Coder(sampler: sampler)
    let output = try coder.attemptCode(to: try CoderOutput(packageCoderSources: srcRoot, xcodeProjectName: packageName))
    signPost.verbose("found config \(output)")
}

highway.runSourcery(handleSourceryOutput)
highway.runSwiftformat(handleSwiftformat)
highway.runTests(handleTestOutput)
#if DEBUG
#else
    highway.generateXcodeProject(override: xcconfig, handleSwiftPackageGenerateXcodeProject)
#endif

dispatchGroup.notifyMain { highway.exitSuccesOrFail(location: pretty_function()) }

dispatchMain()
