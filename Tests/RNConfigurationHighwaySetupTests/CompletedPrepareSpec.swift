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

class CoderSpec: QuickSpec {
    
    override func spec() {
        
        describe("Testing presense of configuaration after prepare") {
            
            var sut: PrepareCode?
            
            var signPost: SignPostProtocolMock!
            var srcRoot: FolderProtocolMock!
            
            var jsonFileForAllEnvFiles: FileProtocolMock!
            var iOSFolder: FolderProtocolMock!
            var androidFolder: FolderProtocolMock!
            var rnConfigurationFolder: FolderProtocolMock!
            
            var local_xcconfig: FileProtocolMock!
            var debug_xcconfig: FileProtocolMock!
            var release_xcconfig: FileProtocolMock!
            var betaRelease_xcconfig: FileProtocolMock!
            
            var env_local: FileProtocolMock!
            var env_debug: FileProtocolMock!
            var env_release: FileProtocolMock!
            var env_betaRelease: FileProtocolMock!
            
            var currentBuildConfigurationWorker_swift: FileProtocolMock!
            var rnConfigurationModelSwiftFile: FileProtocolMock!
            var info_plist: FileProtocolMock!
            
            beforeEach {
                signPost = SignPostProtocolMock()
                
                expect {
                    
                    local_xcconfig = try FileProtocolMock()
                    debug_xcconfig = try FileProtocolMock()
                    release_xcconfig = try FileProtocolMock()
                    betaRelease_xcconfig = try FileProtocolMock()
                    
                    env_local = try FileProtocolMock()
                    env_debug = try FileProtocolMock()
                    env_release = try FileProtocolMock()
                    env_betaRelease = try FileProtocolMock()
                    
                    currentBuildConfigurationWorker_swift = try FileProtocolMock()
                    rnConfigurationModelSwiftFile = try FileProtocolMock()
                    info_plist = try FileProtocolMock()
                    
                    srcRoot = try FolderProtocolMock()
                    
                    jsonFileForAllEnvFiles = try FileProtocolMock()
                    jsonFileForAllEnvFiles.readClosure = {
                        return "{}".data(using: .utf8)!
                    }
                    
                    
                    // JSON ENV files MOCKING
                    
                    srcRoot.fileNamedClosure = { (name: String) -> FileProtocol in
                       
                        guard name.hasPrefix("env") else { throw "srcRoot mock fileNamedClosure implementCase for \(name)" }
                        
                        return jsonFileForAllEnvFiles
                    }
                    
                    // ios & android FoLder
                    
                    iOSFolder = try FolderProtocolMock()
                    androidFolder = try FolderProtocolMock()

                    iOSFolder.createFileIfNeededNamedClosure = { name in
                        switch name {
                        case "Local.xcconfig":
                            return local_xcconfig
                        case "Debug.xcconfig":
                            return debug_xcconfig
                        case "BetaRelease.xcconfig":
                            return betaRelease_xcconfig
                        case "Release.xcconfig":
                            return release_xcconfig
                        default:
                            throw "iosFolder not mocked for createFileNamedClosure(\(name))"
                        }
                    }
                    
                    // RNConfiguration
                    
                    rnConfigurationFolder = try FolderProtocolMock()
                    
                    iOSFolder.subfolderNamedClosure = { name in
                        guard name.hasPrefix("Sources/RNConfiguration") else { throw "srcRoot mock subfolderNamedClosure implementCase for \(name)" }
                        return rnConfigurationFolder
                    }
                    
                    rnConfigurationFolder.createFileIfNeededNamedClosure = { name in
                        switch name {
                        case "RNConfigurationModelFactory.swift":
                            return currentBuildConfigurationWorker_swift
                        case "RNConfigurationModel.swift":
                            return rnConfigurationModelSwiftFile
                        case "Info.plist":
                            return info_plist
                        default:
                            throw "rnConfigurationFolder mock implement case for createFileNamedClosure \(name)"
                        }
                    }
                    
                    androidFolder.createFileIfNeededNamedClosure = { name in
                        switch name {
                        case ".env.local":
                            return env_local
                        case ".env.debug":
                            return env_debug
                        case ".env.betaRelease":
                            return env_betaRelease
                        case ".env.release":
                            return env_release
                        default:
                            throw "androidFolder not mocked for createFileNamedClosure(\(name))"
                        }
                    }
                    
                    srcRoot.subfolderNamedClosure = { name in
                        
                        switch name {
                        case "/Carthage/Checkouts/react-native-config/ios":
                            return iOSFolder
                        case "android":
                            return androidFolder
                        default:
                            throw "srcRoot mock subfolderNamedClosure implementCase for \(name)"
                        }
                        
                    }
                    
                    sut = try PrepareCode(reactNativeFolder: srcRoot, signPost: signPost)
                    
                    return sut
                }.toNot(throwError())
                

            }
            
            it("should have sut") {
                expect(sut).toNot(beNil())
            }
            
            context("correct Coder") {
                
                context("env without json data") {
                
                    beforeEach {
                      
                        expect {try sut?.attempt() }.toNot(throwError())
                    }
                    
                    it("added all keys as cases for the enum") {
                        let coder = sut?.coder
                        
                        expect(jsonFileForAllEnvFiles.readCalled) == true
                        expect(coder).toNot(beNil())
                        expect(coder?.builds.casesForEnum) == ""
                        
                    }
                }
                
                context("env contains some keys and values") {
                    
                    var workerSwiftWrittenData: String?
                    var configurationSwiftWrittenData: String?
                    var plistWrittenData: String?
                    
                    var localStringXcconfig: String?
                    var debugStringXcconfig: String?
                    var betaReleaseStringXcconfig: String?
                    var releaseStringXcconfig: String?
    
                    var localStringEnvAndroid: String?
                    var debugStringEnvAndroid: String?
                    var betaReleaseStringEnvAndroid: String?
                    var releaseStringEnvAndroid: String?
                    
                    beforeEach {
                        
                        // Setup files to write to to receive data
                        
                        currentBuildConfigurationWorker_swift.writeStringClosure = { workerSwiftWrittenData = $0 }
                        rnConfigurationModelSwiftFile.writeStringClosure = {
                            configurationSwiftWrittenData = $0
                        }
                        info_plist.writeStringClosure = { plistWrittenData = $0 }
                        
                        // config files
                        
                        local_xcconfig.writeStringClosure       = { localStringXcconfig = $0}
                        debug_xcconfig.writeStringClosure       = { debugStringXcconfig = $0}
                        release_xcconfig.writeStringClosure     = { releaseStringXcconfig = $0}
                        betaRelease_xcconfig.writeStringClosure = { betaReleaseStringXcconfig = $0}
                        
                        env_local.writeStringClosure       = { localStringEnvAndroid = $0}
                        env_debug.writeStringClosure       = { debugStringEnvAndroid = $0}
                        env_release.writeStringClosure     = { releaseStringEnvAndroid = $0}
                        env_betaRelease.writeStringClosure = { betaReleaseStringEnvAndroid = $0}
                    }
                    
                    context("booleans") {
                       
                        var builds: Builds?
                        var coder: Coder?
                        
                        beforeEach {
                            
                            jsonFileForAllEnvFiles.readClosure = {
                                return """
                                {
                                    "booleans": { "1_mocked_bool_key": false, "2_mocked_bool_key": true }
                                }
                            """.data(using: .utf8)!
                            }
                            
                            expect {
                                sut = try PrepareCode(reactNativeFolder: srcRoot, signPost: signPost)
                                try sut?.attempt()
                                return sut
                            }.toNot(throwError())
                            
                            coder = sut?.coder
                            builds = coder?.builds

                        }
                        
                        it("has read from all env json files") {
                            expect(jsonFileForAllEnvFiles.readCalled) == true
                        }
                        
                        it("can code") {
                            expect(coder).toNot(beNil())
                        }
                        
                        context("coder can created buildable files") {
                           
                            it("has cases for the enum for every key in en json") {
                                
                                expect(builds?.casesForEnum).to(equal( """
                                      case 1_mocked_bool_key
                                      case 2_mocked_bool_key
                                """))
                                
                            }
                            
                            it("can put keys in plist") {
                                expect(builds?.plistLinesXmlText).to(equal( """
                                      <key>1_mocked_bool_key</key>\n<string>$(1_mocked_bool_key)</string>
                                      <key>2_mocked_bool_key</key>\n<string>$(2_mocked_bool_key)</string>
                                """))
                            }
                            
                            it("can put variables in a model") {
                                expect(builds?.configurationModelVar).to(equal( """
                                    public let 1_mocked_bool_key: Bool
                                    public let 2_mocked_bool_key: Bool
                                """))
                            }
                            
                            it("can be printed nicely") {
                                expect(builds?.configurationModelVarDescription).to(equal( """
                                            * 1_mocked_bool_key: \\(1_mocked_bool_key)
                                            * 2_mocked_bool_key: \\(2_mocked_bool_key)
                                """))
                            }
                            
                            context("has written swift code") {
                                let expectedConfingContent = "1_mocked_bool_key = false\n2_mocked_bool_key = true"
                                
                                it("worker has case with key for all values") {
                                    let casesForEnum = builds?.casesForEnum ?? "to worker test went wrong"
                                    expect(workerSwiftWrittenData).to(contain(casesForEnum))
                                }
                                
                                it("configuration model has variables") {
                                    let varString = builds?.configurationModelVar ?? "to configuration model var's failed"
                                    expect(configurationSwiftWrittenData).to(contain(varString))
                                }
                                
                                it("RNConfiguration plist has buid keys and values") {
                                    let plistKeys = builds?.plistLinesXmlText ?? "to plist keys failed"
                                    expect(info_plist.writeStringCalled) == true
                                    expect(plistWrittenData).to(contain(plistKeys))
                                }
                                
                                it("ios xcconfigFile has keys and values") {
                                    
                                    expect(debug_xcconfig.writeStringCalled) == true
                                    expect(debugStringXcconfig) == expectedConfingContent
                                    expect(local_xcconfig.writeStringCalled) == true
                                    expect(localStringXcconfig) == expectedConfingContent
                                    expect(release_xcconfig.writeStringCalled) == true
                                    expect(releaseStringXcconfig) == expectedConfingContent
                                    expect(betaRelease_xcconfig.writeStringCalled) == true
                                    expect(betaReleaseStringXcconfig) == expectedConfingContent
                                }
                                
                                it("android env file has keys and values") {
                                    
                                    expect(debugStringEnvAndroid) == expectedConfingContent
                                    expect(env_local.writeStringCalled) == true
                                    expect(localStringEnvAndroid) == expectedConfingContent
                                    expect(env_release.writeStringCalled) == true
                                    expect(releaseStringEnvAndroid) == expectedConfingContent
                                    expect(env_betaRelease.writeStringCalled) == true
                                    expect(betaReleaseStringEnvAndroid) == expectedConfingContent
                                }
                            }
                        }
                       
                    }
                    
                    context("typed value") {
                        // TODO: some day test this and also different json content per configuration
                    }
                    
                }
            }
           
        }
    }
}
