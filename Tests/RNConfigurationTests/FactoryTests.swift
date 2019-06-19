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
                Factory.infoDict = ["exampleBool": "true", "example_url": "http://www.dooz.be"]
                sut = Factory()
            }

            it("should have keys from info plist")
            {
                expect { sut?.allCustomKeys().count } >= 1
            }

            it("has exampleURL")
            {
                expect { try Factory.readCurrentBuildConfiguration().example_url }.toNot(beNil())
            }
        }
    }
}
