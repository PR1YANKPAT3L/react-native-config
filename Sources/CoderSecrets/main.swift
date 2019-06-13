import Errors
import Foundation
import HighwayLibrary
import SecretsLibrary
import Terminal
import ZFile

doContinue(pretty_function())
{
    try terminalInit(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    let arguments: [Secrets.Argument] = CommandLine.arguments.compactMap { Secrets.Argument(rawValue: $0) }
    try arguments.forEach
    { argument in
        switch argument
        {
        case let .file(path):
            signPost.message("Adding file ...")
            let file = try srcRoot.file(atPath: path)

            signPost.message(try secrets.add(file).joined(separator: "\n"))
            signPost.message("Adding file ✅")
        }
    }

    signPost.verbose(try secrets.hide(in: srcRoot).joined(separator: "\n"))
}

exit(EXIT_SUCCESS)
