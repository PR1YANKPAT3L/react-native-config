import Quick
import Nimble
import CoderLibrary
import CoderLibraryMock

class PlistWriterTests: QuickSpec {
    
    override func spec() {
        
        describe("PlistWriter") {
            
            var sut: PlistWriter?
            
            var output: CoderOutputProtocolMock!
            var sampler: JSONToCodeSamplerProtocolMock!
            beforeEach {
                output = CoderOutputProtocolMock()
                sampler = JSONToCodeSamplerProtocolMock()
                
                sut = PlistWriter(output: output, sampler: sampler)
            }
            
            it("writes to ios files") {
                
            }
            
            it("writes to ios files") {
                
            }
        }
    }
}
