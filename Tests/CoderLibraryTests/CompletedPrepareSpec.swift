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
import RNConfigurationMock
import TerminalMock

import CoderLibrary
import CoderLibraryMock

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
                    
                    let input = InputProtocolMock()
                    input.underlyingDebug = mockFile
                    input.underlyingRelease = mockFile
                    
                    configDisk.underlyingInputJSON = input
                    configDisk.underlyingCode = generatedCode
            
                    let output = OutputProtocolMock()
                    output.debug = mockFile
                    output.release = mockFile
                    
                    configDisk.underlyingIOS = output
                    configDisk.underlyingAndroid = output
                    
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
                context("env contains some keys and values")
                {

                    var modelFile: FileProtocolMock!
                    var factoryFile: FileProtocolMock!
                    var plistCode: FileProtocolMock!
                    var plistTests: FileProtocolMock!
                    
//                    let bridg
                    beforeEach
                    {
                        expect
                        {
                            factoryFile = try FileProtocolMock()
                            modelFile = try FileProtocolMock()
                            plistCode = try FileProtocolMock()
                            plistTests = try FileProtocolMock()
                            
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
                            
                            return try sut?.attempt()
                        }.toNot(throwError())
                    }

                    it("can code")
                    {
                        expect(sut).toNot(beNil())
                    }

                    context("writes ios code")
                    {
                        it("to model") {
                            expect(modelFile.writeStringReceivedString) == ""
                        }
                        
                        it("to factory") {
                             expect(factoryFile.writeStringReceivedString) == ""
                        }
                        
                        it("plist") {
                            expect(plistCode.writeStringReceivedString) == ""
                            expect(plistTests.writeStringReceivedString) == ""
                        }
                    }
                        context("android")
                        {
//                            var androidFolder: FolderProtocol!
//
//                            beforeEach
//                            {
//                                expect { androidFolder = try srcRoot.subfolder(named: "android") }.toNot(throwError())
//                            }
//
//                            it("build has keys and values")
//                            {
//                                if let booleans = sut?.codeSampler.input.debug.booleans?.keys,
//                                    let typedVariabels = sut?.codeSampler.input.debug.typed?.keys
//                                {
//                                    expect
//                                    {
//                                        for _xconfigEntry in booleans
//                                        {
//                                            expect { androidConfigFile }.to(contain(_xconfigEntry))
//                                        }
//
//                                        for _xconfigEntry in typedVariabels
//                                        {
//                                            expect { androidConfigFile }.to(contain(_xconfigEntry))
//                                        }
//
//                                        return rnConfigurationModelFile
//                                    }.toNot(throwError())
//                                }
//                                else
//                                {
//                                    fail("wrong input")
//                                }
//                            }
//
//                            it("created .env files")
//                            {
//                                expect
//                                {
//                                    RNModels.Configuration.allCases.forEach
//                                    { configuration in
//                                        expect(androidFolder.containsFile(named: ".env.\(configuration)")) == true
//                                    }
//                                    return androidFolder
//                                }.toNot(throwError())
//                            }
//
//                            it(".env.<configuration> contain expected keys")
//                            {
//                                expect
//                                {
//                                    try RNModels.Configuration.allCases.forEach
//                                    { configuration in
//                                        let content = try androidFolder.file(named: ".env.\(configuration)").readAsString()
//
//                                        expect(content) == """
//                                        url = https://\(configuration.fileName())
//                                        exampleBool = true
//                                        """
//                                    }
//                                    return androidFolder
//                                }.toNot(throwError())
//                            }
//                        }
                    }
                }
            }
        }
    }
}
