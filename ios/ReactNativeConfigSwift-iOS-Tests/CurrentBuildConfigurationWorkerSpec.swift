//
//  ReactNativeConfigSwift_iOS_Tests.swift
//  ReactNativeConfigSwift-iOS-Tests
//
//  Created by Stijn on 26/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import XCTest
import Quick
import Nimble
import ReactNativeConfigSwift

class CurrentBuildConfigurationWorkerSpec: QuickSpec {
    
    override func spec() {
        
        describe("ReactNativeConfigSwift") {
            
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
