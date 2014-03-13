//
//  HHRouterTests.m
//  HHRouterExample
//
//  Created by Light (lightory@gmail.com) on 2014-03-13.
//  Copyright (c) 2014 Huohua. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HHRouter.h"

@interface HHRouterTests : XCTestCase

@end

@implementation HHRouterTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testShared
{
    XCTAssertTrue([[HHRouter shared] isKindOfClass:[HHRouter class]], @"[HHRouter shared] doesn't return a HHRouter instance.");
    XCTAssertTrue([[HHRouter shared] isEqual:[HHRouter shared]], @"[HHRouter shared] doesn't return a shared instance.");
}

@end