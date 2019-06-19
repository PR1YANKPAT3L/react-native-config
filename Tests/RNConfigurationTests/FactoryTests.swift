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
            var sut: Factory?

            beforeEach
            {
                sut = Factory()
            }

            it("should instantiate RNConfigurationModelFactory")
            {
                expect { sut?.allCustomKeys().count } >= 1
            }

            context("can read current build configuration ")
            {
                var currentBuildConfiguration: ModelProtocol?

                beforeEach
                {
                    Factory.infoDict = ["exampleBool": "true", "example_url": "http://www.dooz.be"]
                    expect { currentBuildConfiguration = try Factory.readCurrentBuildConfiguration() }.toNot(throwError())
                }

                it("has cases")
                {
                    expect(currentBuildConfiguration).toNot(beNil())
                }
            }
        }
    }
}
