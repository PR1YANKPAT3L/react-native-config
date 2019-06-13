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
var copiedPackageCoderSources: CoderOutputProtocol!

doContinue(pretty_function() + " setup")
{
    try terminalInit(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    try highwayInit(gitHooks: GitHooks(prePushExecutable: (name: "PrePushAndPR", arguments: nil)))

    try highway.addGithooksPrePush()
    try highway.validateSecrets(in: srcRoot)

    let input = try srcRoot.file(named: "coder.env.json")

    let copy = CopyIOSProject()
    try copy.attempt(packageSrcRoot: srcRoot, to: srcRoot.subfolder(named: "ios"))

    // faking the copy, back to srcRoot

    copiedPackageCoderSources = try CoderOutput(packageCoderSources: srcRoot, xcodeProjectName: xcodeName)

    let sampler = try JSONToCodeSampler(inputJSONFile: input)

    coder = Coder(sampler: sampler)
}

func continueWithXcodeProjectPresent(_ sync: @escaping Highway.SyncSwiftPackageGenerateXcodeProj)
{
    doContinue(pretty_function())
    {
        let output = try coder.attemptCode(to: copiedPackageCoderSources)

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
        highway.generateXcodeProject(override: copiedPackageCoderSources.ios.xcconfigFile, continueWithXcodeProjectPresent)
        return
    }
    continueWithXcodeProjectPresent { ["xcode already present"] }
}

dispatchMain()
