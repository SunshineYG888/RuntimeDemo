//
//  Person.h
//  RuntimeDemo
//
//  Created by yanggang on 16/5/22.
//  Copyright © 2016年 yg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;

- (void)resolveMethod;
- (void)redirectMethod;
- (void)forwardMethod;

@end
