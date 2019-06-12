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
import Terminal

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

            var input: CoderInputProtocolMock!
            var output: CoderOutputProtocolMock!
            
            var textFileWriter: TextFileWriterProtocolMock!
            
            beforeEach
            {

                expect
                {
                    // Coder input setup
                    
                    let correctCoder = try correctCoderInput()
                    input = correctCoder.0
                    
                    // Text writer setup
                    
                    textFileWriter = TextFileWriterProtocolMock()
                    textFileWriter.setupCodeSamplesJsonReturnValue = TextFileWriter.Sample(arrayLiteral: (case: "mock", configurationModelVar: "mock", configurationModelVarDescription: "mock", xmlEntry: "mock", decoderInit: "mock"))

                    // Coder output setup
                    
                    output = CoderOutputProtocolMock()
                    
                    // Sampler setup as subject under test
                    
                    sut = try JSONToCodeSampler(from: input, to: output, textFileWriter: textFileWriter)

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
                    expect(textFileWriter.writeIOSAndAndroidConfigFilesFromOutputCalled) == true
                }
                
                
                
            }
        }
    }
}
