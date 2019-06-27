import Errors
import Foundation
import RNConfiguration
import SignPost
import Terminal
import ZFile

/**
 In the schem `BuildConfiguration` you can select debug or release.

 Output comes from Configs/Coder.xcconfig file. The file contains conditional keys for debug and release.

 More info on [NSHipster - XCconfig](https://nshipster.com/xcconfig/)

     * when `debug` selected the output base url = `https://debug`
     * when `debug` selected the output base url = `https://release`

 - returns: when doContinue encounters no throw the program continues and exits with success. Othwerwise it throws a Highway.Error

 */
attemptForcedTo(codeGeopoint())
{
    try terminalInit(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder().parentFolder())
    let model = try Factory.readCurrentBuildConfiguration()

    signPost.message("base url = \(model.example_url)")
}

exit(EXIT_SUCCESS)
