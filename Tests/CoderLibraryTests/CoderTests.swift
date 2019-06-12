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

class CoderSpec: QuickSpec
{
    override func spec()
    {
        describe("Testing presense of configuaration after prepare")
        {
            var sut: CoderProtocol?

            var signPost: SignPostProtocolMock!

            var input: CoderInputProtocolMock!
            var output: CoderOutputProtocolMock!
            
            var sampler: JSONToCodeSamplerProtocolMock!

            var terminal: TerminalProtocolMock!
            var system: SystemProtocolMock!
            var plistWriter: PlistWriterProtocolMock!
            
            var json: FileProtocolMock!
            
            beforeEach
            {
                signPost = SignPostProtocolMock()
                terminal  = TerminalProtocolMock()
                system = SystemProtocolMock()
                
                expect
                {
                    // Coder input setup
                    
                    let correctCoder = try correctCoderInput()
                    input = correctCoder.0
                    json = correctCoder.json
                    
                    // Coder output setup
                    
                    output = CoderOutputProtocolMock()
                    
                    let ios: CoderOutputiOSProtocolMock = CoderOutputiOSProtocolMock()
                    ios.underlyingXcconfigFile = try FileProtocolMock()
                    ios.underlyingSourcesFolder = correctCoder.srcRoot
                    ios.underlyingInfoPlistRNConfiguration = try FileProtocolMock()
                    ios.underlyingRnConfigurationModelSwiftFile = try FileProtocolMock()
                    ios.underlyingInfoPlistRNConfigurationTests = try FileProtocolMock()
                    ios.underlyingRnConfigurationBridgeObjectiveCMFile = try FileProtocolMock()
                    ios.rnConfigurationModelSwiftFile = try FileProtocolMock()
                    ios.underlyingRnConfigurationModelFactorySwiftFile = try FileProtocolMock()
                    
                    output.underlyingIos = ios
                    
                    let android: CoderOutputAndroidProtocolMock = CoderOutputAndroidProtocolMock()
                    android.sourcesFolder = correctCoder.srcRoot
                    android.debug = try FileProtocolMock()
                    android.release = try FileProtocolMock()
                    android.local = try FileProtocolMock()
                    android.betaRelease = try FileProtocolMock()
                    
                    output.underlyingAndroid = android
                    
                    // setup code sampler
                    
                    sampler = JSONToCodeSamplerProtocolMock()
                    sampler.underlyingBridgeEnv = BridgeEnvProtocolMock()
                    sampler.plistLinesXmlText = """
                    <key>exampleBool</key>
                    <string>false</string>
                    <key>example_url</key>
                    <string>http://www.mockedURL.safe</string>
                    """
                    
                    // setup plist writer
                    
                    plistWriter = PlistWriterProtocolMock()
                    
                    
                    // setup coder
                    
                    sut = Coder(
                        input: input,
                        output: output,
                        builds: sampler,
                        plistWriter: plistWriter,
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
                    expect { try sut?.attempt() }.toNot(throwError())
                }
                
                it("can code")
                {
                    expect(sut).toNot(beNil())
                }
                
                context("writes default ios code")
                {
                    it("to model") {
                        let swiftFile: (FileProtocolMock) = (output.ios.rnConfigurationModelSwiftFile as! FileProtocolMock)
                        
                        expect(swiftFile.writeStringReceivedString).to(contain(Coder.rnConfigurationModelDefault_TOP))
                        expect(swiftFile.writeStringReceivedString).to(contain(Coder.rnConfigurationModelDefault_BOTTOM))
                    }
                    
                    it("to factory") {
                        let factoryFile: (FileProtocolMock) = (output.ios.rnConfigurationModelFactorySwiftFile as! FileProtocolMock)

                        expect(factoryFile.writeStringReceivedString).to(contain(Coder.factoryTop))
                    }
                    
                    it("plist") {
                        expect(plistWriter.writeRNConfigurationPlistCalled) == true
                        
                    }
                    
                    it("objectiveC") {
                        let objectiveC: (FileProtocolMock) = (output.ios.rnConfigurationBridgeObjectiveCMFile as! FileProtocolMock)

                        expect(objectiveC.writeStringReceivedString).to(contain(Coder.RNConfigurationBridge.top))
                    }
                }
                
            }
        }
    }
}
