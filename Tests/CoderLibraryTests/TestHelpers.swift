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

func correctCoderInput() throws -> (CoderInputProtocolMock, srcRoot: FolderProtocolMock, json: FileProtocolMock) {
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
    
    let input = CoderInputProtocolMock()
    input.underlyingInputJSONFile = mockFile
    
    return  (
        input,
        srcRoot: mockFolder,
        json: mockFile
    )
}

func correctCoderOutput(srcRoot: FolderProtocolMock) throws -> CoderOutputProtocolMock {
    let output = CoderOutputProtocolMock()
    
    let ios: CoderOutputiOSProtocolMock = CoderOutputiOSProtocolMock()
    let xcconfig = try FileProtocolMock()
    xcconfig.readAsStringReturnValue = ""
    
    ios.underlyingXcconfigFile = xcconfig
    ios.underlyingSourcesFolder = srcRoot
    ios.underlyingInfoPlistRNConfiguration = try FileProtocolMock()
    ios.underlyingRnConfigurationModelSwiftFile = try FileProtocolMock()
    ios.underlyingInfoPlistRNConfigurationTests = try FileProtocolMock()
    ios.underlyingJsBridge = try FileProtocolMock()
    ios.rnConfigurationModelSwiftFile = try FileProtocolMock()
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
