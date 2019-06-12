//
//  main.swift
//  Coder
//
//  Created by Stijn Willems on 12/06/2019.
//

import CoderLibrary
import CopyLibrary
import Errors
import Foundation
import Terminal
import ZFile

/**
 This is an example, add a exectuable in your project to copy code.
 */
var output: CoderOutputProtocol!
var copy: CopyProtocol!

doContinue(pretty_function() + " setup")
{
    try terminalInit(packageName: "Coder", try File(path: #file).parentFolder().parentFolder().parentFolder())
    output = try CoderOutput(packageCoderSources: srcRoot)

    copy = Copy(output: output)

    try copy.copy(to: srcRoot, copyToFolderName: "ExampleCopy")
}

exit(EXIT_SUCCESS)
