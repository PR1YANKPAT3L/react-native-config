//
//  RNConfigurationBridgeTests_iOS.m
//  RNConfigurationBridgeTests-iOS
//
//  Created by Stijn Willems on 24/03/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ReactNativeConfig.h"

@interface RNConfigurationBridgeTests_iOS : XCTestCase

@property (nonatomic, strong) ReactNativeConfig * sut;
@end

@implementation RNConfigurationBridgeTests_iOS

- (void)setUp {
    self.sut = [[ReactNativeConfig alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
