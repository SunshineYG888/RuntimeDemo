//
//  YGMainTabBar.m
//  RuntimeDemo
//
//  Created by yanggang on 16/5/24.
//  Copyright © 2016年 yg. All rights reserved.
//

#import "YGMainTabBar.h"

@implementation YGMainTabBar

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            // 布局按钮
        }
    }
}

@end
