//
//  UserViewController.m
//  HHRouterExample
//
//  Created by Light on 14-3-14.
//  Copyright (c) 2014年 Huohua. All rights reserved.
//

#import "UserViewController.h"
#import "HHRouter.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *userId = self.params[@"userId"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 120, 200, 40)];
    label.text = [NSString stringWithFormat:@"UserID: %@", userId];
    
    UIView *containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    containerView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:label];
    
    [self.view addSubview:containerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
