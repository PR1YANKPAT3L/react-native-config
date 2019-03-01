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
                
                expect { sut = MainWorker(reactNativeFolder: try reactNativeFolder()) }.toNot(throwError())
               
            }
            
            it("attempt should not throw") {
                expect { try sut?.attempt() }.toNot(throwError())
            }
        }
    }
}
