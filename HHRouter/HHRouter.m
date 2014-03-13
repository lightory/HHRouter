//
//  HHRouter.m
//  HHRouter
//
//  Created by Light (lightory@gmail.com) on 2014-3-13.
//  Copyright (c) 2014 Huohua. All rights reserved.
//

#import "HHRouter.h"

@implementation HHRouter

+ (instancetype)shared
{
    static HHRouter *router;
    @synchronized(self) {
        if (!router) {
            router = [[self alloc] init];
        }
    }
    return router;
}

- (void)map:(NSString *)pattern toViewControllerClass:(Class)viewControllerClass
{
    
}

- (UIViewController *)match:(NSString *)pattern
{
    return nil;
}

@end