//
//  Person.m
//  RuntimeDemo
//
//  Created by yanggang on 16/5/22.
//  Copyright © 2016年 yg. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Car.h"

@interface Person ()
@property (copy, nonatomic) NSString *address;
@end

// 要被动态添加的方法实现
void dynamicMethodIMP(id self, SEL _cmd) {
    NSLog(@"dynamicMethodIMP");
}

@implementation Person

// 补救第一步：动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"resolveInstanceMethod");
    
    // 如果是要被添加方法实现的 selector
    if (sel  == @selector(resolveMethod)) {
        // 给 self 的类的 sel 方法选择器动态添加方法实现 dynamicMethodIMP
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
        // 返回 YES 后， Runtime 重新给对象发送 aMethod 消息，这次就可以找到 dynamicMethodIMP 方法实现并调用它了
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

// 补救第二步：重定向
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector");
    
    // 如果是要被添加方法实现的 selector
    if (aSelector == @selector(redirectMethod)) {
        // 返回另外一个对象，让它去接收该消息
        return [[Car alloc] init];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

// 获取一个方法签名，用于生成 NSInvocation 对象
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"methodSignatureForSelector");

    if ([NSStringFromSelector(aSelector) isEqualToString:@"forwardMethod"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

// 补救第三步：消息转发
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation");
    
    // 如果另一个对象能响应该方法
    if ([[Car new] respondsToSelector:[anInvocation selector]]) {
        // 则让另一个对象来响应该方法
        [anInvocation invokeWithTarget:[Car new]];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"消息无法处理: %@", NSStringFromSelector(aSelector));
}

@end
