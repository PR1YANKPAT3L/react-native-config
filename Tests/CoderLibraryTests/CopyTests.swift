import Quick
import Nimble

import CoderLibrary
import Errors
import ZFile

import TerminalMock
import ZFileMock
import CoderLibraryMock
import Foundation



class CopySpec: QuickSpec {
    
    override func spec() {
        
        describe("Copy") {
            
            var sut: CopyIOSProject?
            
            var yourSrcRoot: FolderProtocolMock!
            var packageFolder: FolderProtocolMock!
            
            beforeEach {
                yourSrcRoot = try! FolderProtocolMock()
                yourSrcRoot.name = "yours"
                yourSrcRoot.subfolderNamedReturnValue = yourSrcRoot
                yourSrcRoot.containsSubfolderPossiblyInvalidNameReturnValue = false
                yourSrcRoot.createSubfolderIfNeededNamedReturnValue = yourSrcRoot
                
                packageFolder = try! FolderProtocolMock()
                packageFolder.name = "package"
                packageFolder.subfolderNamedReturnValue = packageFolder
                packageFolder.copyToClosure = { _ in return packageFolder }

                sut = CopyIOSProject()
                
                expect{ try sut?.attempt(packageSrcRoot: packageFolder, to: yourSrcRoot) }.toNot(throwError())
            }
            
          
            it("creates destination folder") {
                expect(yourSrcRoot.createSubfolderIfNeededNamedCalled) == true
            }
            
        }
    }
}
