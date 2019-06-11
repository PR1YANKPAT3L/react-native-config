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

var configurationDisk: ConfigurationDiskProtocol!
var sampler: JSONToCodeSamplerProtocol!
var coder: CoderProtocol!
let xcodeName = "Coder.xcodeproj"

doContinue(pretty_function() + " setup")
{
    try terminalInit(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    try highwayInit(gitHooks: GitHooks(prePushExecutable: (name: "PrePushAndPR", arguments: nil)))

    try highway.addGithooksPrePush()
    try highway.validateSecrets(in: srcRoot)

    configurationDisk = try ConfigurationDisk(rnConfigurationSrcRoot: srcRoot, environmentJsonFilesFolder: srcRoot)
    sampler = try JSONToCodeSampler(from: configurationDisk)
    coder = Coder(disk: configurationDisk, builds: sampler, plistWriter: PlistWriter(code: configurationDisk.code, sampler: sampler))
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
    let config = try coder.attempt()
    signPost.message("found config \(config)")

    guard srcRoot.containsSubfolder(possiblyInvalidName: xcodeName) else
    {
        highway.generateXcodeProject(override: config.xcconfig, continueWithXcodeProjectPresent)
        return
    }
    continueWithXcodeProjectPresent { ["xcode already present"] }
}

dispatchMain()
