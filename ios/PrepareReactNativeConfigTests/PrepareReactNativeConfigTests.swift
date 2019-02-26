//
//  PrepareReactNativeconfigTests.swift
//  PrepareReactNativeconfigTests
//
//  Created by Stijn on 29/01/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Quick
import Nimble
import ZFile

import PrepareReactNativeConfig

class MainWorkerSpec: QuickSpec {
    
    override func spec() {
        
        describe("MainWorker") {
            
            var sut: MainWorker?
            
            beforeEach {
                expect {
                    guard let rnoffset = (CommandLine
                        .arguments
                        .first { $0.hasPrefix(MainWorker.reactNativeFolderPrefixOption) }?
                        .replacingOccurrences(of: MainWorker.reactNativeFolderPrefixOption, with: "")) else {
                            throw MainWorker.Error()
                    }
                    
                    let reactNativeFolder = try Folder(relativePath: rnoffset)
                    
                    sut = MainWorker(reactNativeFolder: reactNativeFolder)
                    
                    return sut
                }.toNot(throwError())
               
            }
            
            it("attempt should not throw") {
                expect { try sut?.attempt() }.toNot(throwError())
            }
        }
    }
}
