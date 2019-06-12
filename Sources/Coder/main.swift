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

var input: CoderInputProtocol!
var output: CoderOutputProtocol!

var sampler: JSONToCodeSamplerProtocol!
var coder: CoderProtocol!
let xcodeName = "Coder.xcodeproj"

doContinue(pretty_function() + " setup")
{
    try terminalInit(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    try highwayInit(gitHooks: GitHooks(prePushExecutable: (name: "PrePushAndPR", arguments: nil)))

    try highway.addGithooksPrePush()
    try highway.validateSecrets(in: srcRoot)

    input = CoderInput(inputJSONFile: try srcRoot.file(named: "coder.env.json"))

    output = try CoderOutput(packageCoderSources: srcRoot)

    sampler = try JSONToCodeSampler(from: input, to: output)
    coder = try Coder(
        input: input,
        output: output,
        builds: sampler,
        plistWriter: PlistWriter(output: output, sampler: sampler)
    )
}

func continueWithXcodeProjectPresent(_ sync: @escaping Highway.SyncSwiftPackageGenerateXcodeProj)
{
    doContinue(pretty_function())
    {
        let xcode = try srcRoot.subfolder(named: xcodeName)
        //    try coder.attemptWriteInfoPlistToAllPlists(in: xcode)

        // enable and have a look at the file to make it work if you want.

        highway.runSourcery(handleSourceryOutput)

        dispatchGroup.notifyMain
        {
            highway.runSwiftformat(handleSwiftformat)
            highway.runTests(handleTestOutput)

            dispatchGroup.notifyMain { highway.exitSuccesOrFail(location: pretty_function()) }
        }
    }
}

doContinue(pretty_function() + " coder")
{
    let output = try coder.attempt()
    signPost.message("found config \(output)")

    guard srcRoot.containsSubfolder(possiblyInvalidName: xcodeName) else
    {
        highway.generateXcodeProject(override: output.ios.xcconfigFile, continueWithXcodeProjectPresent)
        return
    }
    continueWithXcodeProjectPresent { ["xcode already present"] }
}

dispatchMain()
