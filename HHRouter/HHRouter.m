//
//  HHRouter.m
//  HHRouter
//
//  Created by Light (lightory@gmail.com) on 2014-3-13.
//  Copyright (c) 2014 Huohua. All rights reserved.
//

#import "HHRouter.h"

@interface HHRouter ()
@property (strong, nonatomic) NSMutableDictionary *routes;
@end

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

- (void)map:(NSString *)route toControllerClass:(Class)controllerClass
{
    NSArray *pathComponents = [self pathComponentsFromRoute:route];
    
    NSInteger index = 0;
    NSMutableDictionary *subRoutes = self.routes;
    while (index < pathComponents.count) {
        NSString *pathComponent = pathComponents[index];
        if (![subRoutes objectForKey:pathComponent]) {
            subRoutes[pathComponent] = [[NSMutableDictionary alloc] init];
        }
        subRoutes = subRoutes[pathComponent];
        index++;
    }
    subRoutes[@"_"] = controllerClass;
}

- (UIViewController *)match:(NSString *)route
{
    NSMutableDictionary *subRoutes = self.routes;
    for (NSString *pathComponent in [self pathComponentsFromRoute:[self stringFromFilterAppUrlScheme:route]]) {
        BOOL found = NO;
        NSArray *subRoutesKeys = subRoutes.allKeys;
        for (NSString *key in subRoutesKeys) {
            if ([key isEqualToString:pathComponent]) {
                found = YES;
                subRoutes = subRoutes[key];
                break;
            } else if ([key hasPrefix:@":"]) {
                found = YES;
                subRoutes = subRoutes[key];
                break;
            }
        }
        if (!found) return nil;
    }
    
    Class controllerClass = subRoutes[@"_"];
    UIViewController *viewController = [[controllerClass alloc] init];
    return viewController;
}

#pragma mark - Private
- (NSMutableDictionary *)routes
{
    if (!_routes) {
        _routes = [[NSMutableDictionary alloc] init];
    }
    return _routes;
}

- (NSArray *)pathComponentsFromRoute:(NSString *)route
{
    NSMutableArray *pathComponents = [NSMutableArray array];
    for (NSString *pathComponent in route.pathComponents) {
        if ([pathComponent isEqualToString:@"/"]) continue;
        if ([[pathComponent substringToIndex:1] isEqualToString:@"?"]) continue;
        [pathComponents addObject:pathComponent];
    }
    
    return [pathComponents copy];
}

- (NSString *)stringFromFilterAppUrlScheme:(NSString *)string
{
    for (NSString *appUrlScheme in [self appUrlSchemes]) {
        if ([string hasPrefix:[NSString stringWithFormat:@"%@:", appUrlScheme]]) {
            return [string substringFromIndex:appUrlScheme.length + 1];
        }
    }
    
    return string;
}

- (NSArray *)appUrlSchemes
{
    NSMutableArray *appUrlSchemes = [NSMutableArray array];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    for (NSDictionary *dic in infoDictionary[@"CFBundleURLTypes"]) {
        NSString *appUrlScheme = dic[@"CFBundleURLSchemes"][0];
        [appUrlSchemes addObject:appUrlScheme];
    }
    
    return [appUrlSchemes copy];
}

@end