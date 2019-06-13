//
//  TestHelpers.swift
//  CoderLibraryTests
//
//  Created by Stijn Willems on 12/06/2019.
//

import Foundation
import Errors
import ZFile

import RNModels
import RNConfiguration
import CoderLibrary

import ZFileMock
import SignPostMock
import TerminalMock
import Terminal

import CoderLibraryMock
import RNModelsMock
import RNConfigurationMock

func correctCoderInput() throws -> (FileProtocolMock, srcRoot: FolderProtocolMock, json: FileProtocolMock) {
    let mockFolder = try FolderProtocolMock()
    let mockFile = try FileProtocolMock()
    
    // Mock folder setup
    
    mockFolder.fileNamedReturnValue = mockFile
    mockFolder.subfolderNamedReturnValue = mockFolder
    mockFolder.createFileIfNeededNamedReturnValue = mockFile
    mockFolder.containsSubfolderPossiblyInvalidNameReturnValue = true
    
    // MockFile setup
    
    mockFile.parentFolderReturnValue = mockFolder
    mockFile.readReturnValue = correctInputJSON.data(using: .utf8)!
    mockFile.readAsStringReturnValue = correctInputJSON
    
    return  (
        mockFile,
        srcRoot: mockFolder,
        json: mockFile
    )
}

func correctCoderOutput(srcRoot: FolderProtocolMock) throws -> CoderOutputProtocolMock {
    let output = CoderOutputProtocolMock()
    
    let ios: CoderOutputiOSProtocolMock = CoderOutputiOSProtocolMock()
    let xcconfig = try FileProtocolMock()
    xcconfig.readAsStringReturnValue = ""
    xcconfig.readReturnValue = "".data(using: .utf8)
    xcconfig.copyToClosure = { _ in return xcconfig }
    
    ios.underlyingXcconfigFile = xcconfig
    ios.underlyingSourcesFolder = srcRoot
    let plist = try FileProtocolMock()
    plist.copyToClosure = { _ in return plist }
    plist.readReturnValue = "".data(using: .utf8)!

    ios.underlyingInfoPlistRNConfiguration = plist
    ios.underlyingRnConfigurationModelSwiftFile = try FileProtocolMock()
    ios.underlyingJsBridge = try FileProtocolMock()
    ios.underlyingInfoPlistRNConfiguration = plist
    
    let file = try FileProtocolMock()
    srcRoot.copyToClosure = { _ in return srcRoot }
    
    file.parentFolderReturnValue = srcRoot
    
    ios.rnConfigurationModelSwiftFile = file
    
    ios.underlyingRnConfigurationModelFactorySwiftFile = try FileProtocolMock()
    
    output.underlyingIos = ios
    
    let android: CoderOutputAndroidProtocolMock = CoderOutputAndroidProtocolMock()
    android.sourcesFolder = srcRoot
    android.configFiles = [
        .Debug : try FileProtocolMock(),
        .Release : try FileProtocolMock(),
        .Local : try FileProtocolMock(),
        .BetaRelease : try FileProtocolMock(),
    ]
    
    output.underlyingAndroid = android
    
    return output
}

// MARK: - JSON

let correctInputJSON = """
{
"debug": {
"typed": {
"example_url": {
"value": "https://debug",
"valueType": "Url"
}
},
"booleans": {
"exampleBool": true
}
},
"release": {
"typed": {
"example_url": {
"value": "https://release",
"valueType": "Url"
}
},
"booleans": {
"exampleBool": false
}
},
"betaRelease": {
"typed": {
"example_url": {
"value": "https://betaRelease",
"valueType": "Url"
}
},
"booleans": {
"exampleBool": false
}
},
"local": {
"typed": {
"example_url": {
"value": "https://local",
"valueType": "Url"
}
},
"booleans": {
"exampleBool": true
}
}

}
"""
