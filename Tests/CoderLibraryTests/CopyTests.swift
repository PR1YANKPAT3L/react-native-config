import Quick
import Nimble

import CoderLibrary
import Errors
import ZFile

import TerminalMock
import ZFileMock
import CoderLibraryMock
import Foundation


open class FileSystemIteratorMock: FileSystemIterator<FileProtocolMock> {
    
    public let file: FileProtocolMock
    
    public init(file: FileProtocolMock, parent: FolderProtocolMock) {
        self.file = file
        super.init(folder: parent, recursive: false, includeHidden: false, using: .default)
    }
    
    override open func next() -> FileProtocolMock? {
        return file
    }
    
}
open class FileSystemSequenceMock: FileSystemSequence<FileProtocolMock> {
    
    public let iteratorFile: FileProtocolMock
    public let parent: FolderProtocolMock
    
    public init(iteratorFile: FileProtocolMock, parent: FolderProtocolMock) {
        self.iteratorFile = iteratorFile
        self.parent = parent
        super.init(folder: parent, recursive: false, includeHidden: true, using: FileManager.default)
    }
    
    override open func makeIterator() -> FileSystemIterator<FileProtocolMock> {
        return FileSystemIteratorMock(file: iteratorFile, parent: parent)
    }
}

private class RNFolder: FolderMock {
    
    let file: FileProtocolMock
    let parent: FolderProtocolMock
    
    required init() {
        file = try! FileProtocolMock()
        file.readReturnValue = "".data(using: .utf8)!
        parent = try! FolderProtocolMock()
        file.parentFolderReturnValue = parent
        file.pReturnValue = parent
        try! super.init()
    }
    
    required init(path: String) throws {
        fatalError("init(path:) has not been implemented")
    }
    
    required init?(possibilyInvalidPath: String, using filemanager: FileManager) {
        fatalError("init(possibilyInvalidPath:using:) has not been implemented")
    }
    
    override func makeFileSequence<F>() throws -> FileSystemSequence<F> where F : FileProtocol {
        return FileSystemSequenceMock(iteratorFile: file, parent: parent) as! FileSystemSequence<F>
    }
}
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
                folder.containsFilePossiblyInvalidNameReturnValue = true
                folder.subfolderNamedReturnValue = folder
                folder.createSubfolderNamedReturnValue = folder
                folder.createSubfolderIfNeededNamedReturnValue = folder
                
                output = try! correctCoderOutput(srcRoot: folder)
                let input = try! correctCoderInput()
                folder.fileNamedReturnValue = input.json
                
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
                
                expect{ try sut?.attempt(to: folder, xcodeProjectName: "mock") }.toNot(throwError())
            }
            
          
            it("creates destination folder") {
                expect(folder.createSubfolderIfNeededNamedCalled) == true
            }
            
        }
    }
}
