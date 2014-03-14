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

- (void)testRoute
{
    [[HHRouter shared] map:@"/user/:userId/" toControllerClass:[UserViewController class]];
    [[HHRouter shared] map:@"/story/:storyId/" toControllerClass:[StoryViewController class]];
    [[HHRouter shared] map:@"/user/:userId/story/" toControllerClass:[StoryListViewController class]];
    
    XCTAssertTrue([[[HHRouter shared] match:@"/user/1/"] isKindOfClass:[UserViewController class]]);
    XCTAssertTrue([[[HHRouter shared] match:@"/story/2/"] isKindOfClass:[StoryViewController class]]);
    XCTAssertTrue([[[HHRouter shared] match:@"/user/1/story/"] isKindOfClass:[StoryListViewController class]]);
    
    XCTAssertTrue([[[HHRouter shared] match:@"hhrouter://user/1/"] isKindOfClass:[UserViewController class]]);
}

@end