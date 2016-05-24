//
//  YGMainViewController.m
//  RuntimeDemo
//
//  Created by yanggang on 16/5/24.
//  Copyright © 2016年 yg. All rights reserved.
//

#import "YGMainViewController.h"
#import "YGMainTabBar.h"

@interface YGMainViewController ()

@end

@implementation YGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建并使用自定义的 tabBar
    YGMainTabBar *mainTarBar = [YGMainTabBar new];
    [self setValue:mainTarBar forKey:@"tabBar"];
}

@end
