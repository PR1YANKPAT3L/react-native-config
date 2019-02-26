//
//  main.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 29/01/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import ZFile
import SignPost

let reactNativeFolderPrefixOption = "-reactNativeFolder:"

struct Error: Swift.Error {
    let message = "PrepareReactNativeConfig requires option -reactNativeFolder: which is releative path to folder you are running the script in."
}

do {
    guard let rnoffset = (CommandLine
        .arguments
        .first { $0.hasPrefix(reactNativeFolderPrefixOption) }?
    .replacingOccurrences(of: reactNativeFolderPrefixOption, with: "")) else {
        throw Error()
    }
    
    let reactNativeFolder = try Folder(relativePath: rnoffset)
    SignPost.shared.message("🚀 ReactNativeConfig RN root:\n \(reactNativeFolder)\n")

    do {
        let main = MainWorker(reactNativeFolder: reactNativeFolder)
        
        try main.attempt()
        
        SignPost.shared.message("🚀 ReactNativeConfig main.swift ✅")
        
        exit(EXIT_SUCCESS)
    } catch {
        SignPost.shared.error("""
            ❌ Prepare React Native Config
            
            \(error)
            
            ❌
            ♥️ Fix it by adding environment files
            \(Disk.JSONFileName.allCases.map { "* \($0.rawValue)"}.joined(separator: "\n"))
            at \(reactNativeFolderPrefixOption): \(reactNativeFolder)
            and fill them with valid json
            {
            "typed": {"key":{"typedValue": "value", "type": "String"}}
            "booleans": { "key": true }
            }
            
            All keys are optional, but it has to be JSON. So adding
            
            ``` JSON
            {"booleans": {"hasConfiguration": true }}
            ```
            
            is the minimum.
            """
        )
        exit(EXIT_FAILURE)
    }
    
} catch {
    SignPost.shared.error("""
        ❌ Prepare React Native Config
        
        \(error)
        
        ❌
        ♥️ Fix it by adding environment files
        \(Disk.JSONFileName.allCases.map { "* \($0.rawValue)"}.joined(separator: "\n"))
        at \(reactNativeFolderPrefixOption)
        """
    )
    exit(EXIT_FAILURE)
}
