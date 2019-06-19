import Quick
import Nimble
import CoderLibrary
import CoderLibraryMock
import ZFileMock
import RNModelsMock
import Foundation
import RNModels
import ZFile

class TextFileWriterTests: QuickSpec {
    
    override func spec() {
        
        describe("TextFileWriter") {
            
            var sut: PlatformSpecificConfigurationWriter?
            
            var output: CoderOutputProtocolMock!
            var json: JSONEnvironmentsProtocol!
            var result = [String]()

            var xcconfigFile: FileProtocolMock!
            
            beforeEach {
                
                expect {
                    let correctCoder = try correctCoderInput()
                    
                    output = try correctCoderOutput(srcRoot: correctCoder.srcRoot)
                    
                    sut = PlatformSpecificConfigurationWriter()
                    
                    xcconfigFile = (output.ios.xcconfigFile as! FileProtocolMock)

                    xcconfigFile.appendStringClosure = {
                        result.append($0)
                        
                    }
                    
                    json = try JSONDecoder().decode(JSONEnvironments.self, from: try correctCoder.json.read())
                    return try sut?.writeToAllPlatforms(from: json, output: output)
                    
                }.toNot(throwError())
            }
            afterEach {
                result = []
            }
            
            context("writes ios code")
            {
                let expected = [
                    "example_url [config=Debug] = https:\\/\\/debug",
                    "exampleBool [config=Debug] = true",
                    "example_url [config=Release] = https:\\/\\/release",
                    "exampleBool [config=Release] = false",
                    "example_url [config=Local] = https:\\/\\/local",
                    "exampleBool [config=Local] = true",
                    "example_url [config=BetaRelease] = https:\\/\\/betaRelease",
                    "exampleBool [config=BetaRelease] = false",
                ].sorted()
                
                it("debug") {
                    
                    result
                        .filter { $0.isEmpty}
                        .sorted()
                        .enumerated()
                        .forEach { expect($0.element) == expected[$0.offset] }
                }
                
                
            }
            
            context("writes default android code")
            {
                it("debug") {
                    let debugFile: (FileProtocolMock) = (output.android.configFiles[.Debug] as! FileProtocolMock)
                    
                    expect(debugFile.writeStringReceivedString) == """
                    example_url=https://debug
                    exampleBool=true
                    """
                }
                
                it("release") {
                    let releaseFile: (FileProtocolMock) = (output.android.configFiles[.Release] as! FileProtocolMock)
                    
                    expect(releaseFile.writeStringReceivedString) == """
                    example_url=https://release
                    exampleBool=false
                    """
                }
                
                it("local") {
                    let localFile: (FileProtocolMock) = (output.android.configFiles[.Local] as! FileProtocolMock)
                    
                    expect(localFile.writeStringReceivedString) == """
                    example_url=https://local
                    exampleBool=true
                    """
                    
                }
                
                it("betarelease") {
                    let betaRelease: (FileProtocolMock) = (output.android.configFiles[.BetaRelease] as! FileProtocolMock)
                    
                    expect(betaRelease.writeStringReceivedString) == """
                    example_url=https://betaRelease
                    exampleBool=false
                    """
                }
            }
        }
    }
}
