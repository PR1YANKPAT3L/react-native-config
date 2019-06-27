import Errors
import Foundation
import HighwayLibrary
import Terminal
import ZFile

attemptForcedTo(codeGeopoint() + " setup")
{
    try terminalInit(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    try highwayInit(gitHooks: GitHooks(prePushExecutable: (name: "PrePushAndPR", arguments: nil)))
}

highway.sourcery(async: handleSourceryOutput)

dispatchGroup.notifyMain
{
    highway.swiftformat(async: handleSwiftformat)

    dispatchGroup.notifyMain { highway.attemptForcedExitFrom(codeGeopoint()) }
}

dispatchMain()
