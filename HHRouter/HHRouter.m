// The MIT License (MIT)
//
// Copyright (c) 2014 LIGHT lightory@gmail.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"route"] = [self stringFromFilterAppUrlScheme:route];
    
    NSMutableDictionary *subRoutes = self.routes;
    NSArray *pathComponents = [self pathComponentsFromRoute:[self stringFromFilterAppUrlScheme:route]];
    for (NSString *pathComponent in pathComponents) {
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
                params[[key substringFromIndex:1]] = pathComponent;
                break;
            }
        }
        if (!found) return nil;
    }
    
    // Extract Params From Query.
    NSArray *pathInfo = [route componentsSeparatedByString:@"?"];
    if (pathInfo.count > 1) {
        NSString *paramsString = [pathInfo objectAtIndex:1];
        NSArray *paramStringArr = [paramsString componentsSeparatedByString:@"&"];
        for (NSString *paramString in paramStringArr) {
            NSArray *paramArr = [paramString componentsSeparatedByString:@"="];
            if (paramArr.count > 1) {
                NSString *key = [paramArr objectAtIndex:0];
                NSString *value = [paramArr objectAtIndex:1];
                params[key] = value;
            }
        }
    }
    
    Class controllerClass = subRoutes[@"_"];
    UIViewController *viewController = [[controllerClass alloc] init];
    if ([viewController respondsToSelector:@selector(setParams:)]) {
        [viewController performSelector:@selector(setParams:) withObject:[params copy]];
    }
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