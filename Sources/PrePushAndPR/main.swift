import Errors
import Foundation
import HighwayLibrary
import Terminal
import ZFile

doContinue(pretty_function() + " setup")
{
    try terminalInit(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    try highwayInit(gitHooks: GitHooks(prePushExecutable: (name: "PrePushAndPR", arguments: nil)))
    try highway.addGithooksPrePush()
}

highway.runSourcery(handleSourceryOutput)

dispatchGroup.notifyMain
{
    highway.runSwiftformat(handleSwiftformat)
    highway.runTests(handleTestOutput)

    dispatchGroup.notifyMain
    {
        doContinue(pretty_function() + " git clean") { try git.isClean(in: srcRoot) }
        highway.exitSuccesOrFail(location: pretty_function())
    }
}

dispatchMain()
