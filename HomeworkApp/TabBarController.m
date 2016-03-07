//
//  TabBarController.m
//  HomeworkApp
//
//  Created by 林立 on 16/1/3.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBar:(UITabBar*)atabBar didSelectItem:(UITabBarItem*)item
{
    CATransition* animation = [CATransition animation];
    [animation setDuration:0.5f];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.view layer]addAnimation:animation forKey:@"switchView"];
}

@end
