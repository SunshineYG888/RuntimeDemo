//
//  ViewController.m
//  RuntimeDemo
//
//  Created by yanggang on 16/5/22.
//  Copyright © 2016年 yg. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "UIButton+Extension.h"
#import <objc/runtime.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置按钮的 callback “属性”的内容
    self.button.callback = ^{
        NSLog(@"button callback");
    };
}

- (IBAction)callResolveMethodBtnClick:(id)sender {
    Person *p = [[Person alloc] init];
    [p resolveMethod];
    NSLog(@"is p response to selector %@? %@", @"resolveMethod", [p respondsToSelector:@selector(resolveMethod)] ? @"YES" : @"NO");
}

- (IBAction)callRedirectMethodBtnClick:(id)sender {
    Person *p = [[Person alloc] init];
    [p redirectMethod];
    NSLog(@"is p response to selector %@? %@", @"redirectMethod", [p respondsToSelector:@selector(redirectMethod)] ? @"YES" : @"NO");
}

- (IBAction)callRorwardMethodBtnClick:(id)sender {
    Person *p = [[Person alloc] init];
    [p forwardMethod];
    NSLog(@"is p response to selector %@? %@", @"forwardMethod", [p respondsToSelector:@selector(forwardMethod)] ? @"YES" : @"NO");
}

- (IBAction)propertiesFromPersonBtnClick:(id)sender {
    unsigned int count = 0;
    // 获取当前类的属性列表（即数组）
    objc_property_t *propertyList = class_copyPropertyList([Person class], &count);
    
    NSMutableArray *ocProperties = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        // 取出每一个属性
        objc_property_t property = propertyList[i];
        // 取出属性名
        const char *cPropertyName = property_getName(property);
        // C --> OC
        NSString *ocPropertyName = [[NSString alloc] initWithCString:cPropertyName
                                                            encoding:NSUTF8StringEncoding];
        
        [ocProperties addObject:ocPropertyName];
    }
    NSLog(@"Person's properties: %@", ocProperties);
    // 释放
    free(propertyList);
}

- (IBAction)associatedPropertyBtnClick:(id)sender {
    // 获取并执行按钮的 callback “属性”
    self.button.callback();
}


@end
