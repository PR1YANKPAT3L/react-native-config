import Quick
import Nimble
import CoderLibrary
import CoderLibraryMock
import ZFileMock

class PlistWriterTests: QuickSpec {
    
    override func spec() {
        
        describe("PlistWriter") {
            
            var sut: PlistWriter?
            
            var output: CoderOutputProtocolMock!
            var sampler: JSONToCodeSamplerProtocolMock!
            
            beforeEach {
                
                expect {
                    
                    output = try correctCoderOutput(srcRoot: try FolderProtocolMock())
                    sampler = JSONToCodeSamplerProtocolMock()
                    
                    sut = PlistWriter()
                    return sut
                }.toNot(throwError())
                
            }
            
            it("writes to ios files") {
                expect{ try sut?.write(output: output, sampler: sampler) }.toNot(throwError())
            }
            
            it("writes to ios files") {
                
            }
        }
    }
}
