//
//  RNConfiguration_iOS_Tests.swift
//  RNConfiguration-iOS-Tests
//
//  Created by Stijn on 26/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import XCTest
import Quick
import Nimble
import RNConfiguration

class CurrentBuildConfigurationWorkerSpec: QuickSpec {
    
    override func spec() {
        
        describe("RNConfiguration") {
            
            var sut: CurrentBuildConfigurationWorker?
            
            beforeEach {
                sut = CurrentBuildConfigurationWorker()
            }
            
            it("should instantiate CurrentBuildConfigurationWorker") {
                expect { sut?.allCustomKeys().count } >= 1
            }
            
            context ("can read current build configuration ") {
                
                var currentBuildConfiguration: CurrentBuildConfiguration?
                
                beforeEach {
                    expect { currentBuildConfiguration = try CurrentBuildConfigurationWorker.readCurrentBuildConfiguration() }.toNot(throwError())
                }
                
                it("has cases") {
                    expect (currentBuildConfiguration).toNot(beNil())
                }
            }
        }
    }
}
