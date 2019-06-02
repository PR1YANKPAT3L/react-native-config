import HighwayLibrary
import Terminal
import Foundation
import Errors
import ZFile

doContinue(pretty_function() + " setup") {
    try setup(packageName: "react-native-config", try File(path: #file).parentFolder().parentFolder().parentFolder())
    try setupHighwayRunner(gitHooksPrePushExecutableName: "PrePushAndPR")
    try highwayRunner.addGithooksPrePush()
}

highwayRunner.runSourcery(handleSourceryOutput)

dispatchGroup.notifyMain {
    highwayRunner.runSwiftformat(handleSwiftformat)
    highwayRunner.runTests(handleTestOutput)
    
    dispatchGroup.notifyMain {
        doContinue(pretty_function() + " git clean") { try git.isClean() }
        highwayRunner.exitSuccesOrFail(location: pretty_function())
    }
}

dispatchMain()
