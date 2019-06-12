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
    mockFile.readReturnValue = """
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
                    """.data(using: .utf8)!
    
    let input = CoderInputProtocolMock()
    input.underlyingInputJSONFile = mockFile
    
    return  (
        input,
        srcRoot: mockFolder,
        json: mockFile
    )
}
