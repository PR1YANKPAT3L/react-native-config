import Errors
import Foundation
import HighwayLibrary
import Terminal
import ZFile

doContinue(pretty_function() + " setup")
{
    try setup(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    try setupHighwayRunner(gitHooksPrePushExecutableName: "PrePushAndPR")
}

highwayRunner.runSourcery(handleSourceryOutput)

dispatchGroup.notifyMain
{
    highwayRunner.runSwiftformat(handleSwiftformat)

    dispatchGroup.notifyMain { highwayRunner.exitSuccesOrFail(location: pretty_function()) }
}

dispatchMain()
