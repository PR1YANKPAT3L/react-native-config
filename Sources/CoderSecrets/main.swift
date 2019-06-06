import HighwayLibrary
import Foundation
import Terminal
import Errors
import ZFile
import SecretsLibrary


doContinue(pretty_function()) {
    try setup(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    let arguments: [Secrets.Argument] = CommandLine.arguments.compactMap { Secrets.Argument(rawValue: $0) }
    
    try arguments.forEach
    { argument in
        switch argument
        {
        case let .file(path):
            let file = try srcRoot.file(atPath: path)
            
            signPost.message(try secrets.add(file).joined(separator: "\n"))
        }
    }
    
   
   try secrets.hide(in: srcRoot)
}

exit(EXIT_SUCCESS)

