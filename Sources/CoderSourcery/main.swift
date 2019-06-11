import Errors
import Foundation
import HighwayLibrary
import Terminal
import ZFile

doContinue(pretty_function() + " setup")
{
    try terminalInit(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    try highwayInit(gitHooks: GitHooks(prePushExecutable: (name: "PrePushAndPR", arguments: nil)))
}

highway.runSourcery(handleSourceryOutput)

dispatchGroup.notifyMain
{
    highway.runSwiftformat(handleSwiftformat)

    dispatchGroup.notifyMain { highway.exitSuccesOrFail(location: pretty_function()) }
}

dispatchMain()
