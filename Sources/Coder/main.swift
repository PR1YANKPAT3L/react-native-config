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
    coder = Coder(
        input: input,
        output: output,
        codeSampler: sampler,
        plistWriter: PlistWriter(output: output, sampler: sampler),
        bridge: JSBridgeCodeSample(bridgeEnv: sampler.bridgeEnv)
    )
}

func continueWithXcodeProjectPresent(_ sync: @escaping Highway.SyncSwiftPackageGenerateXcodeProj)
{
    doContinue(pretty_function())
    {
        let output = try coder.attempt()
        signPost.verbose("found config \(output)")

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
    guard srcRoot.containsSubfolder(possiblyInvalidName: xcodeName) else
    {
        highway.generateXcodeProject(override: output.ios.xcconfigFile, continueWithXcodeProjectPresent)
        return
    }
    continueWithXcodeProjectPresent { ["xcode already present"] }
}

dispatchMain()
