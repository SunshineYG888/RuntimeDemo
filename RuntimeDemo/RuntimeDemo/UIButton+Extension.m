//
//  UIButton+Extension.m
//  RuntimeDemo
//
//  Created by yanggang on 16/5/24.
//  Copyright © 2016年 yg. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

const void *yg_callbackKey = @"yg_callbackKey";

@implementation UIButton (Extension)

- (void)setCallback:(CallbackBlock)callback {
    // 设置关联属性
    objc_setAssociatedObject(self, yg_callbackKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CallbackBlock)callback {
    // 获取关联属性
    return objc_getAssociatedObject(self, yg_callbackKey);
}

@end
