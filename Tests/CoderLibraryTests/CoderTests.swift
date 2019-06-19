//
//  RNConfigurationPrepareTests.swift
//  RNConfigurationPrepareTests
//
//  Created by Stijn on 01/03/2019.
//  Copyright © 2019 bolides. All rights reserved.
//

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
import Terminal

import CoderLibrary
import CoderLibraryMock
import Foundation
import RNModels
import RNModelsMock

class CoderSpec: QuickSpec
{
    override func spec()
    {
        describe("Testing presense of configuaration after prepare")
        {
            var sut: CoderProtocol?

            var signPost: SignPostProtocolMock!

            var output: CoderOutputProtocolMock!
            var json: JSONEnvironmentsProtocolMock!
            
            var sampler: JSONToCodeSamplerProtocolMock!

            var terminal: TerminalProtocolMock!
            var system: SystemProtocolMock!
            var plistWriter: PlistWriterProtocolMock!
            var textFileWriter: TextFileWriterProtocolMock!
            var bridge: JSBridgeCodeSampleProtocolMock!
            
            beforeEach
            {
                signPost = SignPostProtocolMock()
                terminal  = TerminalProtocolMock()
                system = SystemProtocolMock()
                
                expect
                {
                    // Coder input setup
                    
                    let correctCoder = try correctCoderInput()
                    json = JSONEnvironmentsProtocolMock()
                    
                    // Coder output setup
                    
                    output = try correctCoderOutput(srcRoot: correctCoder.srcRoot)
                    
                    // setup code sampler
                    
                    sampler = JSONToCodeSamplerProtocolMock()
                    sampler.plistLinesXmlText = """
                    <key>exampleBool</key>
                    <string>false</string>
                    <key>example_url</key>
                    <string>http://www.mockedURL.safe</string>
                    """
                    sampler.underlyingJsonEnvironments = json
                    
                    // setup plist writer
                    
                    plistWriter = PlistWriterProtocolMock()
                    
                    // Setup text file writer
                    
                    textFileWriter = TextFileWriterProtocolMock()
                    textFileWriter.writeIOSAndAndroidConfigFilesFromOutputClosure = { _, _ in }
                    
                    // Setup code for bridge
                    
                    bridge = JSBridgeCodeSampleProtocolMock()
                    bridge.writeRNConfigurationBridgeToSamplerClosure = { _, _ in }
                    
                    // setup coder
                    
                    sut = Coder(
                        sampler: sampler,
                        plistWriter: plistWriter,
                        bridge: bridge,
                        textFileWriter: textFileWriter,
                        signPost: signPost,
                        decoder: JSONDecoder(),
                        terminal: terminal,
                        system: system
                    )

                    return sut
                }.toNot(throwError())
            }

            it("should have sut")
            {
                expect(sut).toNot(beNil())
            }
            
            context("env contains some keys and values")
            {
                beforeEach {
                    expect { try sut?.attemptCode(to: output) }.toNot(throwError())
                }
                
                it("writes to ios and android config files")
                {
                    expect(textFileWriter.writeIOSAndAndroidConfigFilesFromOutputCalled) == true
                }
                
                context("writes default ios code")
                {
                    it("to model") {
                        let swiftFile: (FileProtocolMock) = (output.ios.model as! FileProtocolMock)
                        
                        expect(swiftFile.writeStringReceivedString).to(contain(Coder.modelDefault_TOP))
                        expect(swiftFile.writeStringReceivedString).to(contain(Coder.modelDefault_TOP))
                    }
                    
                    it("to factory") {
                        let factoryFile: (FileProtocolMock) = (output.ios.factory as! FileProtocolMock)

                        expect(factoryFile.writeStringReceivedString).to(contain(Coder.factoryTop))
                    }
                    
                    it("plist") {
                        expect(plistWriter.writeRNConfigurationPlistOutputSamplerCalled) == true
                        
                    }
                    
                    it("objectiveC") {

                        expect(bridge.writeRNConfigurationBridgeToSamplerCalled) == true
                    }
                }
                
            }
        }
    }
}
