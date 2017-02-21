//
//  FrontPageViewController.m
//  HHRouterExample
//
//  Created by skyline on 15/9/25.
//  Copyright © 2015年 Huohua. All rights reserved.
//

#import "FrontPageViewController.h"
#import "HHRouter.h"

@interface FrontPageViewController ()

@end

@implementation FrontPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(80, 100, 40, 20)];
    self.label.text = @"URL";

    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(120, 95, 150, 30)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame = CGRectMake(280, 95, 40, 30);
    [self.button setTitle:@"Route" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(doRoute) forControlEvents:UIControlEventTouchDown];
    
    UIView *containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    containerView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:self.label];
    [containerView addSubview:self.textField];
    [containerView addSubview:self.button];
    
    [self.view addSubview:containerView];
}

- (void)doRoute {
    NSString *url = self.textField.text;
    UIViewController *vc = [[HHRouter shared] matchController:url];
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
