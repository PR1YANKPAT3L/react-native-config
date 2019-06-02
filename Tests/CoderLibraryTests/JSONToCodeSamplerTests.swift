//
//  RNConfigurationPrepareTests.swift
//  RNConfigurationPrepareTests
//
//  Created by Stijn on 01/03/2019.
//  Copyright © 2019 bolides. All rights reserved.
//
import Foundation
import Errors
import Nimble
import Quick
import RNModels
import SignPostMock
import ZFile
import ZFileMock
import RNConfiguration
import RNConfigurationMock
import TerminalMock

import CoderLibrary
import CoderLibraryMock
import RNModelsMock

class JSONToCodeSamplerTests: QuickSpec
{
    override func spec()
    {
        describe("JSONToCodeSampler")
        {
            var sut: JSONToCodeSampler?

            var configDisk: ConfigurationDiskProtocolMock!
            
            var textFileWriter: TextFileWriterProtocolMock!
            var inputJSON: InputJSONProtocolMock!
            
            beforeEach
            {

                expect
                {
                    let mockFolder = try FolderProtocolMock()
                    let mockFile = try FileProtocolMock()
                    
                    // Mock folder setup
                    
                    mockFolder.fileNamedReturnValue = mockFile
                    mockFolder.subfolderNamedReturnValue = mockFolder
                    mockFolder.createFileIfNeededNamedReturnValue = mockFile
                    mockFolder.containsSubfolderNamedReturnValue = true
                    
                    configDisk = ConfigurationDiskProtocolMock()
                    configDisk.underlyingEnvironmentJsonFilesFolder = mockFolder
                    configDisk.underlyingAndroidFolder = mockFolder
                    configDisk.underlyingIosFolder = mockFolder
                    
                    let jsonFiles = JSONFileProtocolMock()
                    jsonFiles.underlyingDebug = mockFile
                    jsonFiles.underlyingRelease = mockFile
                    
                    configDisk.underlyingInputJSON = jsonFiles
                    
                    inputJSON = EnvJSONProtocolMock()
                    inputJSON.underlyingDebug = mockFile
                    inputJSON.underlyingRelease = mockFile
                    
                    textFileWriter = TextFileWriterProtocolMock()
                    textFileWriter.writeIOSAndAndroidConfigFilesFromReturnValue = inputJSON
                    
                    sut = try JSONToCodeSampler(from: configDisk, textFileWriter: textFileWriter)

                    return sut
                }.toNot(throwError())
            }

            it("should have sut")
            {
                expect(sut).toNot(beNil())
            }

            context("writes to text files")
            {
                it("ios and android") {
                    expect(textFileWriter.writeConfigIfNeededFromAndroidIosCalled) == true
                }
                
            }
        }
    }
}
