import Quick
import Nimble
import CoderLibrary
import CoderLibraryMock
import ZFileMock

class TextFileWriterTests: QuickSpec {
    
    override func spec() {
        
        describe("TextFileWriter") {
            
            var sut: TextFileWriter?
            
            var output: CoderOutputProtocolMock!
            var input: CoderInputProtocolMock!
            
            beforeEach {
                
                expect {
                    let correctCoder = try correctCoderInput()
                    input  = correctCoder.0
                    
                    output = try correctCoderOutput(srcRoot: correctCoder.srcRoot)
                    
                    sut = TextFileWriter()
                    
                    return try sut?.writeIOSAndAndroidConfigFiles(from: input, output: output)
                    
                }.toNot(throwError())
            }
            
            context("writes default android code")
            {
                it("debug") {
                    let debugFile: (FileProtocolMock) = (output.android.configFiles[.Debug] as! FileProtocolMock)
                    
                    expect(debugFile.writeStringReceivedString) == """
                    """
                }
                
                it("release") {
                    let releaseFile: (FileProtocolMock) = (output.android.configFiles[.Release] as! FileProtocolMock)
                    
                    expect(releaseFile.writeStringReceivedString) == """
                    """
                }
                
                it("local") {
                    let localFile: (FileProtocolMock) = (output.android.configFiles[.BetaRelease] as! FileProtocolMock)
                    
                    expect(localFile.writeStringReceivedString) == """
                    """
                    
                }
                
                it("betarelease") {
                    let betaRelease: (FileProtocolMock) = (output.android.configFiles[.BetaRelease] as! FileProtocolMock)
                    
                    expect(betaRelease.writeStringReceivedString) == """
                    """
                }
            }
        }
    }
}
