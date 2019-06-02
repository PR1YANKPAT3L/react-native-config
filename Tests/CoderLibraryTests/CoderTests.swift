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

            var configDisk: ConfigurationDiskProtocolMock!
            var sampler: JSONToCodeSamplerProtocolMock!

            var terminal: TerminalProtocolMock!
            var system: SystemProtocolMock!
            var generatedCode = GeneratedCodeProtocolMock()
            
            var outputIOS: OutputFilesProtocolMock!
            var outputAndroid: OutputFilesProtocolMock!
            
            beforeEach
            {
                signPost = SignPostProtocolMock()

                expect
                {
                    let mockFolder = try FolderProtocolMock()
                    let mockFile = try FileProtocolMock()

                    generatedCode = GeneratedCodeProtocolMock()
                    
                    // Mock folder setup
                    
                    mockFolder.fileNamedReturnValue = mockFile
                    mockFolder.subfolderNamedReturnValue = mockFolder
                    mockFolder.createFileIfNeededNamedReturnValue = mockFile
                    mockFolder.containsSubfolderNamedReturnValue = true
                    
                    terminal = TerminalProtocolMock()
                    system = SystemProtocolMock()
                    
                    configDisk = ConfigurationDiskProtocolMock()
                    configDisk.underlyingEnvironmentJsonFilesFolder = mockFolder
                    configDisk.underlyingAndroidFolder = mockFolder
                    configDisk.underlyingIosFolder = mockFolder
                    
                    let input = JSONFileProtocolMock()
                    input.underlyingDebug = mockFile
                    input.underlyingRelease = mockFile
                    
                    configDisk.underlyingInputJSON = input
                    configDisk.underlyingCode = generatedCode
            
                    outputIOS = OutputFilesProtocolMock()
                    outputIOS.debug = try FileProtocolMock()
                    outputIOS.release = try FileProtocolMock()
                    
                    outputAndroid = OutputFilesProtocolMock()
                    outputAndroid.debug = try FileProtocolMock()
                    outputAndroid.release = try FileProtocolMock()
                    
                    configDisk.underlyingIOS = outputIOS
                    configDisk.underlyingAndroid = outputAndroid
                    
                    sampler = JSONToCodeSamplerProtocolMock()
                    
                    
                    sut = Coder(
                        disk: configDisk,
                        builds: sampler,
                        signPost: signPost,
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

            context("correct Coder")
            {
                var modelFile: FileProtocolMock!
                var factoryFile: FileProtocolMock!
                var plistCode: FileProtocolMock!
                var plistTests: FileProtocolMock!
                var objectiveC: FileProtocolMock!
                
                var bridge: BridgeEnvProtocolMock!
                
                beforeEach
                    {
                        expect
                            {
                                factoryFile = try FileProtocolMock()
                                modelFile = try FileProtocolMock()
                                plistCode = try FileProtocolMock()
                                plistTests = try FileProtocolMock()
                                bridge = BridgeEnvProtocolMock()
                                objectiveC = try FileProtocolMock()
                                
                                sut = Coder(
                                    disk: configDisk,
                                    builds: sampler,
                                    signPost: signPost,
                                    terminal: terminal,
                                    system: system
                                )
                                generatedCode.underlyingRnConfigurationModelSwiftFile = modelFile
                                generatedCode.underlyingRnConfigurationModelFactorySwiftFile = factoryFile
                                generatedCode.infoPlistRNConfiguration = plistCode
                                generatedCode.infoPlistRNConfigurationTests = plistTests
                                generatedCode.underlyingRnConfigurationBridgeObjectiveCMFile = objectiveC
                                
                                sampler.underlyingBridgeEnv = bridge
                                sampler.plistLinesXmlText = """
                                <key>exampleBool</key>
                                <string>false</string>
                                <key>example_url</key>
                                <string>http://www.mockedURL.safe</string>
                                """
                                
                                return try sut?.attempt()
                            }.toNot(throwError())
                }
                
                context("env contains some keys and values")
                {

                    it("can code")
                    {
                        expect(sut).toNot(beNil())
                    }

                    context("writes default ios code")
                    {
                        it("to model") {
                            expect(modelFile.writeStringReceivedString).to(contain(Coder.rnConfigurationModelDefault_TOP))
                            expect(modelFile.writeStringReceivedString).to(contain(Coder.rnConfigurationModelDefault_BOTTOM))
                        }
                        
                        it("to factory") {
                             expect(factoryFile.writeStringReceivedString).to(contain(Coder.factoryTop))
                        }
                        
                        it("plist") {
                            expect {
                                let result: RNConfigurationModel = try PropertyListDecoder().decode(RNConfigurationModel.self, from: plistCode.writeStringReceivedString!.data(using: .utf8)!)
                                
                                expect(result.example_url.url.absoluteString) == "http://www.mockedURL.safe"
                                expect(result.exampleBool) == false
                                
                                return true
                            }.toNot(throwError())
                          
                        }
                        
                        it("objectiveC") {
                             expect(objectiveC.writeStringReceivedString).to(contain(Coder.RNConfigurationBridge.top))
                        }
                    }
                    
                }
            }
        }
    }
}
