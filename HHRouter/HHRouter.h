//
//  HHRouter.h
//  HHRouter
//
//  Created by Light (lightory@gmail.com) on 2014-3-13.
//  Copyright (c) 2014 Huohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHRouter : NSObject
+ (instancetype)shared;
- (void)map:(NSString *)pattern toViewControllerClass:(Class)viewControllerClass;
- (UIViewController *)match:(NSString *)pattern;
@end