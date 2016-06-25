HHRouter
=====
[![Build Status](https://travis-ci.org/Huohua/HHRouter.png)](https://travis-ci.org/Huohua/HHRouter)
[![CocoaPods](https://cocoapod-badges.herokuapp.com/v/HHRouter/badge.png)](http://cocoapods.org/?q=HHRouter)

Yet another URL Router for iOS. Clean, Fast & Flexible. Inspired by [ABRouter](https://github.com/aaronbrethorst/ABRouter) & [Routable iOS](https://github.com/usepropeller/routable-ios).

## Usage

### Warm Up

Map URL patterns to viewController. Better in AppDelegate.

```objective-c
[[HHRouter shared] map:@"/user/:userId/" toControllerClass:[UserViewController class]];
```

### Exciting Time
Get viewController instance from URL. Params will be parsed automatically.

```objective-c
UIViewController *viewController = [[HHRouter shared] matchController:@"/user/1/"];
```

```objective-c
XCTAssertEqualObjects([viewController class], [UserViewController class]);
XCTAssertEqualObjects(viewController.params[@"route"], @"/user/1/");
XCTAssertEqualObjects(viewController.params[@"userId"], @"1");
```

### URL Query Params

URL Query Params is also supported, which will make things VERY flexible.

```objective-c
UIViewController *viewController = [[HHRouter shared] matchController:@"/user/1/?tabIndex=3"];
```

```objective-c
XCTAssertEqualObjects(viewController.params[@"tabIndex"], @"3");
```

### One More Thing

If your app has defined some URL schemes, HHRouter will know.

```objective-c
UIViewController *viewController = [[HHRouter shared] matchController:@"hhrouter://user/1/"];
```

```objective-c
XCTAssertEqualObjects([viewController class], [UserViewController class]);
```

## Installation
### [CocoaPods](http://cocoapods.org/)

```ruby
pod 'HHRouter', '~> 0.1.8'
```

```objective-c
#import <HHRouter/HHRouter.h>
```

If you're not able to use CocoaPods, please install HHRouter as a [git submodule](http://schacon.github.com/git/user-manual.html#submodules) and add the files to your Xcode project.

## We're Hiring!
[http://pudding.cc/opportunity/](http://pudding.cc/opportunity/)

## Contact
- [lightory@gmail.com](mailto:lightory@gmail.com)
- [http://twitter.com/lightory/](http://twitter.com/lightory/)

## Who use HHRouter?
If you're building your applications using HHRouter, please let me know! (add your application name & App Store link here and pull reuqest this README.

- 布丁动画: [https://itunes.apple.com/cn/app/bu-ding-dong-hua-zui-liang/id869243194?l=zh&ls=1&mt=8](https://itunes.apple.com/cn/app/bu-ding-dong-hua-zui-liang/id869243194?l=zh&ls=1&mt=8)


## License
HHRouter is available under the [MIT license](https://github.com/Huohua/HHRouter/blob/master/LICENSE).
