//
//  CoderSpec.swift
//  PrepareReactNativeconfigTests
//
//  Created by Stijn on 26/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation

import Quick
import Nimble
import PrepareReactNativeConfig

class CoderSpec: QuickSpec {
    
    override func spec() {
        
        describe("Coder") {
            
            var sut: Coder?
            
            beforeEach {
                expect {
                    let disk = try Disk(reactNativeFolder: try reactNativeFolder())
                    let builds = try Builds(from: disk)
                    
                    sut = Coder(disk: disk, builds: builds)
                    
                    return sut
                }.toNot(throwError())
                
            }
            
            it("create correct empty files") {
                expect { try sut?.generateConfigurationWorker() }.toNot(throwError())
            }
        }
    }
}
