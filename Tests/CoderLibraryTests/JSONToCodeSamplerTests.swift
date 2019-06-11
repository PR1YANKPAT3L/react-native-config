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
import ZFile

import RNModels
import RNConfiguration
import CoderLibrary

import ZFileMock
import SignPostMock
import TerminalMock

import CoderLibraryMock
import RNModelsMock
import RNConfigurationMock


class JSONToCodeSamplerTests: QuickSpec
{
    override func spec()
    {
        describe("JSONToCodeSampler")
        {
            var sut: JSONToCodeSampler?

            var configDisk: ConfigurationDiskProtocolMock!
            
            var textFileWriter: TextFileWriterProtocolMock!
            var inputJSON: EnvJSONsProtocolMock!
            
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
                    mockFolder.containsSubfolderPossiblyInvalidNameReturnValue = true
                    
                    configDisk = ConfigurationDiskProtocolMock()
                    configDisk.underlyingEnvironmentJsonFilesFolder = mockFolder
                    configDisk.underlyingAndroidFolder = mockFolder
                    configDisk.underlyingIosFolder = mockFolder
                    
                    let jsonFiles = JSONFileProtocolMock()
                    jsonFiles.underlyingDebug = mockFile
                    jsonFiles.underlyingRelease = mockFile
                    
                    configDisk.underlyingInputJSON = jsonFiles
                    
                    inputJSON = EnvJSONsProtocolMock()
                    inputJSON.underlyingDebug = JSONProtocolMock()
                    inputJSON.underlyingRelease = JSONProtocolMock()
                    
                    textFileWriter = TextFileWriterProtocolMock()
                    textFileWriter.writeIOSAndAndroidConfigFilesFromReturnValue = inputJSON
                    textFileWriter.setupCodeSamplesJsonReturnValue = TextFileWriter.Sample(arrayLiteral: (case: "mock", configurationModelVar: "mock", configurationModelVarDescription: "mock", xmlEntry: "mock", decoderInit: "mock"))
                    
                    sut = try JSONToCodeSampler(from: configDisk, textFileWriter: textFileWriter)

                    return sut
                }.toNot(throwError())
            }

            it("should have sut")
            {
                expect(sut).toNot(beNil())
            }

            it("setup samples") {
                expect(textFileWriter.setupCodeSamplesJsonCalled) == true
            }
            
            context("writes to text files")
            {
                it("ios and android") {
                    expect(textFileWriter.writeIOSAndAndroidConfigFilesFromCalled) == true
                }
                
                
                
            }
        }
    }
}
