//
//  HHRouterTests.m
//  HHRouterExample
//
//  Created by Light (lightory@gmail.com) on 2014-03-13.
//  Copyright (c) 2014 Huohua. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HHRouter.h"
#import "UserViewController.h"
#import "StoryViewController.h"
#import "StoryListViewController.h"

@interface HHRouterTests : XCTestCase

@end

@implementation HHRouterTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testShared
{
    XCTAssertTrue([[HHRouter shared] isKindOfClass:[HHRouter class]]);
    XCTAssertTrue([[HHRouter shared] isEqual:[HHRouter shared]]);
}

- (void)testRouteBlocks
{
    [[HHRouter shared]map:@"/user/add/" toBlock:^id(NSDictionary *parms) {
        XCTAssertEqualObjects(parms[@"a"], @"1");
        XCTAssertEqualObjects(parms[@"b"], @"2");
    }];
    HHRouterBlock block = [[HHRouter shared]matchBlock:@"/user/add/?a=1&b=2"];
    XCTAssertNotNil(block);
    block(nil);
    [[HHRouter shared]callBlock:@"/user/add/?a=1&b=2"];
}

- (void)testRoute
{
    [[HHRouter shared] map:@"/user/:userId/" toControllerClass:[UserViewController class]];
    [[HHRouter shared] map:@"/story/:storyId/" toControllerClass:[StoryViewController class]];
    [[HHRouter shared] map:@"/user/:userId/story/" toControllerClass:[StoryListViewController class]];

    
    XCTAssertEqualObjects([[[HHRouter shared] matchController:@"/story/2/"] class], [StoryViewController class]);
    XCTAssertEqualObjects([[[HHRouter shared] matchController:@"/user/1/story/"] class], [StoryListViewController class]);
    
    XCTAssertEqualObjects([[[HHRouter shared] matchController:@"hhrouter://user/1/"] class], [UserViewController class]);
    
    UserViewController *userViewController = (UserViewController *) [[HHRouter shared] matchController:@"/user/1/?a=b&c=d"];
    XCTAssertEqualObjects(userViewController.params[@"route"], @"/user/1/?a=b&c=d");
    XCTAssertEqualObjects(userViewController.params[@"userId"], @"1");
    XCTAssertEqualObjects(userViewController.params[@"a"], @"b");
    XCTAssertEqualObjects(userViewController.params[@"c"], @"d");
}

@end