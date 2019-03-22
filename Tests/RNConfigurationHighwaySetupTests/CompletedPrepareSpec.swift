//
//  RNConfigurationPrepareTests.swift
//  RNConfigurationPrepareTests
//
//  Created by Stijn on 01/03/2019.
//  Copyright © 2019 bolides. All rights reserved.
//

import Quick
import Nimble
import Arguments
import SignPostMock
import ZFile
import ZFileMock
import Errors

import RNConfigurationPrepare

/// Test run a real filesystem
class CoderSpec: QuickSpec {
    
    override func spec() {
        
        describe("Testing presense of configuaration after prepare") {
            
            var sut: PrepareCode?
            
            var signPost: SignPostProtocolMock!
            
            var srcRoot: FolderProtocol!
            var environmentJsonFilesFolder: FolderProtocol!
            
            beforeEach {
                signPost = SignPostProtocolMock()
                
                expect {
                    // /react-native-config/Tests/RNConfigurationHighwaySetupTests/env.debug.json
                    srcRoot = try File(path: #file).parentFolder().subfolder(named: "/../../../")
                    environmentJsonFilesFolder = srcRoot
                    
                    sut = try PrepareCode(
                        rnConfigurationSrcRoot: srcRoot,
                        environmentJsonFilesFolder: environmentJsonFilesFolder,
                        signPost: signPost
                    )
                    
                    return sut
                }.toNot(throwError())
                

            }
            
            it("has a folder for env. files") {
                expect(srcRoot).toNot(beNil())
            }
            
            it("should have sut") {
                expect(sut).toNot(beNil())
            }
            
            context("correct Coder") {
                
                context("env contains some keys and values") {
                    
                    var builds: Builds?
                    var coder: Coder?
                    
                    beforeEach {
                        
                        expect {
                            
                            sut = try PrepareCode(
                                rnConfigurationSrcRoot: srcRoot,
                                environmentJsonFilesFolder: environmentJsonFilesFolder,
                                signPost: signPost)
                            try sut?.attempt()
                        
                            return sut
                        }.toNot(throwError())
                        
                        coder = sut?.coder
                        builds = coder?.builds
                        
                    }
                    
                    
                    it("can code") {
                        expect(coder).toNot(beNil())
                    }
                    
                    context("coder can created files that contain") {
                        
                        
                        
                        context("has written swift code to model") {
                            
                            var rnConfigurationModelFile: String?
                            var rnConfigurationFactoryFile: String?
                            var plistFile: String?
                            var xcconfigFile: String?
                            var androidConfigFile: String?
                            
                            beforeEach {
                                expect {
                                    guard let srcRoot = srcRoot else {
                                        throw HighwayError.highwayError(atLocation: pretty_function(), error: "missing folder argument")
                                    }
                                    
                                    let rnConfigurationFolder = try srcRoot.subfolder(named: "Sources/RNConfiguration")
                                    
                                    rnConfigurationModelFile = try rnConfigurationFolder.file(named: "RNConfigurationModel.swift").readAsString()
                                    rnConfigurationFactoryFile = try rnConfigurationFolder.file(named: "RNConfigurationModelFactory.swift").readAsString()
                                    plistFile = try srcRoot.subfolder(named: "Sources/RNConfiguration").file(named: "Info.plist").readAsString()
                                    
                                    let iosFolder = try srcRoot.subfolder(named: "ios")
                                    let androidFolder = try srcRoot.subfolder(named: "android")
                                    
                                    xcconfigFile = try iosFolder.file(named: "Debug.xcconfig").readAsString()
                                    androidConfigFile = try androidFolder.file(named: ".env.debug").readAsString()
                                    
                                    return true
                                }.toNot(throwError())
                            }
                            
                            it ("debug xcconfigfile") {
                                expect(xcconfigFile).toNot(beNil())
                            }
                            
                            it("all cases in factory") {
                                let casesForEnum = builds?.casesForEnum.components(separatedBy: "\n") ?? ["to worker test went wrong"]
                                
                                expect {
                                    
                                    for _case in casesForEnum {
                                        expect {rnConfigurationFactoryFile }.to(contain(_case))
                                    }
                                    return rnConfigurationModelFile
                                    }.toNot(throwError())
                                
                            }
                            
                            it("all variables") {
                                let varString = builds?.configurationModelVar.components(separatedBy: "\n") ?? ["to configuration model var's failed"]
                                
                                expect {
                                    
                                    for _var in varString {
                                        expect {rnConfigurationModelFile }.to(contain(_var))
                                    }
                                    return rnConfigurationModelFile
                                    }.toNot(throwError())
                                
                            }
                            
                            it("RNConfiguration plist has build keys and values") {
                                let plistKeys = builds?.plistLinesXmlText.components(separatedBy: "\n") ?? ["to plist keys failed"]
                                
                                expect {
                                    
                                    for _plistEntry in plistKeys {
                                        expect { plistFile }.to(contain(_plistEntry))
                                    }
                                    
                                    return rnConfigurationModelFile
                                }.toNot(throwError())
                            }
                            
                            it("ios xcconfigFile has keys and values") {
                                
                                if let booleans = builds?.input.debug.booleans?.keys,
                                   let typedVariabels = builds?.input.debug.typed?.keys {
                                    
                                    expect {
                                        
                                        for _xconfigEntry in booleans {
                                            expect { xcconfigFile }.to(contain(_xconfigEntry))
                                        }
                                        
                                        for _xconfigEntry in typedVariabels {
                                            expect { xcconfigFile }.to(contain(_xconfigEntry))
                                        }
                                        
                                        return rnConfigurationModelFile
                                    }.toNot(throwError())
                                } else {
                                    fail("wrong input")
                                }
                                
                               
                            }
                            
                            it("android env file has keys and values") {
                                
                                if let booleans = builds?.input.debug.booleans?.keys,
                                    let typedVariabels = builds?.input.debug.typed?.keys {
                                    
                                    expect {
                                        
                                        for _xconfigEntry in booleans {
                                            expect { androidConfigFile }.to(contain(_xconfigEntry))
                                        }
                                        
                                        for _xconfigEntry in typedVariabels {
                                            expect { androidConfigFile }.to(contain(_xconfigEntry))
                                        }
                                        
                                        return rnConfigurationModelFile
                                        }.toNot(throwError())
                                } else {
                                    fail("wrong input")
                                }
                                
                            }
                        }
                    }
                    
                  
                    
                }
            }
           
        }
    }
}
