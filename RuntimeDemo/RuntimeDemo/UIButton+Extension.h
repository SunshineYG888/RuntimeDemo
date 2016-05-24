//
//  UIButton+Extension.h
//  RuntimeDemo
//
//  Created by yanggang on 16/5/24.
//  Copyright © 2016年 yg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallbackBlock)();

@interface UIButton (Extension)
@property (copy, nonatomic) CallbackBlock callback;
@end
