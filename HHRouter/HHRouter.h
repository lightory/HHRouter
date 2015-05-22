//  The MIT License (MIT)
//
//  Copyright (c) 2014 LIGHT lightory@gmail.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the “Software”), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>

///---------------
/// @name HHRouter
///---------------

typedef NS_ENUM (NSInteger, HHRouteType) {
    HHRouteTypeNone = 0,
    HHRouteTypeViewController = 1,
    HHRouteTypeBlock = 2
};

typedef id (^HHRouterBlock)(NSDictionary *params);

@interface HHRouter : NSObject

+ (instancetype)shared;

- (void)map:(NSString *)route toControllerClass:(Class)controllerClass;
- (UIViewController *)match:(NSString *)route __attribute__((deprecated));
- (UIViewController *)matchController:(NSString *)route;

- (void)map:(NSString *)route toBlock:(HHRouterBlock)block;
- (HHRouterBlock)matchBlock:(NSString *)route;
- (id)callBlock:(NSString *)route;

- (HHRouteType)canRoute:(NSString *)route;

@end

///--------------------------------
/// @name UIViewController Category
///--------------------------------

@interface UIViewController (HHRouter)

@property (nonatomic, strong) NSDictionary *params;

@end
