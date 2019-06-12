import Quick
import Nimble
import CopyLibrary
import CopyLibraryMock
import TerminalMock
import ZFileMock
import CoderLibraryMock
import Errors

class CopySpec: QuickSpec {
    
    override func spec() {
        
        describe("Copy") {
            
            var sut: Copy?
            
            var output: CoderOutputProtocolMock!
            var terminal: TerminalProtocolMock!
            var system: SystemProtocolMock!
            
            var folder: FolderProtocolMock!
            
            beforeEach {
                folder = try! FolderProtocolMock()
                folder.name = pretty_function()

                folder.containsSubfolderPossiblyInvalidNameReturnValue = true
                folder.subfolderNamedReturnValue = folder
                folder.createSubfolderNamedReturnValue = folder
                
                output = try! correctCoderOutput(srcRoot: folder)
                terminal = TerminalProtocolMock()
                system = SystemProtocolMock()
                
                let ios = output.ios as! CoderOutputiOSProtocolMock
                let iosFolder = try! FolderProtocolMock()
                iosFolder.copyToClosure = { _ in return iosFolder }
                
                ios.underlyingSourcesFolder = iosFolder

                let android = output.android as! CoderOutputAndroidProtocolMock
                let androidFolder = try! FolderProtocolMock()
                androidFolder.copyToClosure = { _ in androidFolder }
                
                android.underlyingSourcesFolder = androidFolder

                sut = Copy(
                    output: output,
                    terminal: terminal,
                    system: system
                )
                
                expect{ try sut?.copy(to: folder, copyToFolderName: "mocked") }.toNot(throwError())
            }
            
            it("deletes folder first") {
                expect(folder.deleteCalled) == true
            }
            
            it("creates destination folder") {
                expect(folder.createSubfolderNamedCalled) == true
            }
            
            it("copy all source files in <Project>Configuration folder name") {
                
                let rnConfigurationFolder = try! output.ios.rnConfigurationModelSwiftFile.parentFolder() as! FolderProtocolMock
                
                expect(rnConfigurationFolder.copyToCalled) == true
            }
            
            it("copy plist") {
                
                let rnConfigurationFolder = try! output.ios.rnConfigurationModelSwiftFile.parentFolder() as! FolderProtocolMock
                
                expect(rnConfigurationFolder.copyToCalled) == true
            }
            
            it("copy xcconfig") {
                
                let xcconfig = output.ios.xcconfigFile as! FileProtocolMock
                
                expect(xcconfig.copyToCalled) == true
            }
            
            
            it("copy ios folder") {
                
                let iosFolder = output.ios.sourcesFolder as! FolderProtocolMock
                
                expect(iosFolder.copyToCalled) == true
            }
            
            it("copy android files") {
                
                let androidFolder = output.android.sourcesFolder as! FolderProtocolMock
                
                expect(androidFolder.copyToCalled) == true
            }
            
            it ("copy plist") {
                let plistFolder = output.ios.infoPlistRNConfiguration as! FileProtocolMock
                
                expect(plistFolder.copyToCalled) == true
            }
        }
    }
}
