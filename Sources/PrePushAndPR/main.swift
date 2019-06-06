import Errors
import Foundation
import HighwayLibrary
import Terminal
import ZFile

doContinue(pretty_function() + " setup")
{
    try setup(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    try setupHighwayRunner(gitHooksPrePushExecutableName: "PrePushAndPR")
    try highwayRunner.addGithooksPrePush()
}

highwayRunner.runSourcery(handleSourceryOutput)

dispatchGroup.notifyMain
{
    highwayRunner.runSwiftformat(handleSwiftformat)
    highwayRunner.runTests(handleTestOutput)

    dispatchGroup.notifyMain
    {
        doContinue(pretty_function() + " git clean") { try git.isClean(in: srcRoot) }
        highwayRunner.exitSuccesOrFail(location: pretty_function())
    }
}

dispatchMain()
