//
//  RNConfiguration_iOS_Tests.swift
//  RNConfiguration-iOS-Tests
//
//  Created by Stijn on 26/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Nimble
import Quick
import RNConfiguration
import RNConfigurationMock

class CurrentBuildConfigurationWorkerSpec: QuickSpec
{
    override func spec()
    {
        describe("RNConfiguration")
        {
            var sut: RNConfigurationModelFactory?

            beforeEach
            {
                sut = RNConfigurationModelFactory()
            }

            it("should instantiate RNConfigurationModelFactory")
            {
                expect { sut?.allCustomKeys().count } >= 1
            }

            context("can read current build configuration ")
            {
                var currentBuildConfiguration: RNConfigurationModel?

                beforeEach
                {
                    RNConfigurationModelFactory.infoDict = ["exampleBool": "true", "url": "http://www.dooz.be"]
                    expect { currentBuildConfiguration = try RNConfigurationModelFactory.readCurrentBuildConfiguration() }.toNot(throwError())
                }

                it("has cases")
                {
                    expect(currentBuildConfiguration).toNot(beNil())
                }
            }
        }
    }
}
