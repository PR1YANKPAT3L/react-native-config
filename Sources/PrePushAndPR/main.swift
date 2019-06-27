import Errors
import Foundation
import HighwayLibrary
import Terminal
import ZFile

attemptForcedTo(codeGeopoint() + " setup")
{
    try terminalInit(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    try highwayInit(gitHooks: GitHooks(prePushExecutable: (name: "PrePushAndPR", arguments: nil)))
    try highway.addGithooksPrePush()
}

highway.sourcery()

dispatchGroup.notifyMain
{
    highway.swiftformat()
    highway.tests()

    dispatchGroup.notifyMain
    {
        highway.attemptForcedExitFrom(codeGeopoint())
    }
}

dispatchMain()
