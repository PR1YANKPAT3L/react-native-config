//
//  RNConfigurationPrepareTests.swift
//  RNConfigurationPrepareTests
//
//  Created by Stijn on 01/03/2019.
//  Copyright © 2019 bolides. All rights reserved.
//
import Foundation
import Nimble
import Quick

import CoderLibrary
import CoderLibraryMock
import ZFileMock

class JSONToCodeSamplerTests: QuickSpec
{
    override func spec()
    {
        describe("JSONToCodeSampler")
        {
            var sut: JSONToCodeSampler?

            var input: FileProtocolMock!
            var output: CoderOutputProtocolMock!
            
            beforeEach
            {

                expect
                {
                    // Coder input setup
                    
                    let correctCoder = try correctCoderInput()
                    input = correctCoder.0
                    
                    // Coder output setup
                    
                    output = CoderOutputProtocolMock()
                    
                    // Sampler setup as subject under test
                    
                    sut = try JSONToCodeSampler(inputJSONFile: input)

                    return sut
                }.toNot(throwError())
            }

            it("should have sut")
            {
                expect(sut).toNot(beNil())
            }
            
            context("has code samples")
            {
                
                it("plistLinesXmlText") {
                    expect(sut?.plistLinesXmlText).to(contain(["example_url", "exampleBool"]))
                }
                
                context("swift") {
                    it("casesForEnum") {
                        expect(sut?.casesForEnum).to(contain(["example_url", "exampleBool"]))
                    }
                    
                    it("configurationModelVar") {
                        expect(sut?.configurationModelVar).to(contain(["example_url", "exampleBool"]))
                    }
                    
                    it("configurationModelVarDescription") {
                        expect(sut?.configurationModelVarDescription).to(contain(["example_url", "exampleBool"]))
                    }
                    
                    it("decoderInit") {
                        expect(sut?.decoderInit).to(contain(["example_url", "exampleBool"]))
                    }
                    
                }
                
                context("objc bridge samples ready") {
                    
                    it("Debug") {
                        expect(sut?.bridgeEnv[.Debug]?.joined()).to(contain(["YES", "https://debug"]))
                    }
                    
                    it("Release") {
                        expect(sut?.bridgeEnv[.Release]?.joined()).to(contain(["NO", "https://release"]))
                    }
                    
                    it("Local") {
                        expect(sut?.bridgeEnv[.Local]?.joined()).to(contain(["YES", "https://local"]))
                    }
                    
                    it("BetaRelease") {
                        expect(sut?.bridgeEnv[.BetaRelease]?.joined()).to(contain(["NO", "https://betaRelease"]))
                    }
                }
                
            }
        }
    }
}
