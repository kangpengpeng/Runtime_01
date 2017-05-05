//
//  Person.m
//  Runtime
//
//  Created by 康鹏鹏 on 2017/5/2.
//  Copyright © 2017年 dhcc. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)run {
    NSLog(@"Person-run方法跑起来");
}

- (void)eatWithFood:(NSString *)food {
    NSLog(@"Person-eat方法：%@", food);
}

+ (void)run {
    NSLog(@"Person-run类方法");
}

// 归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Person class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        // 归档
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
}

// 解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Person class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            // 解档
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}



// 类开始调用时加载
+ (void)load {
    // class_getInstanceMethod:
    // class_getClassMethod:
    Method method1 = class_getClassMethod([Person class], @selector(method_1:));
    Method method2 = class_getClassMethod([Person class], @selector(method_2:));

    // 交换方法
    method_exchangeImplementations(method1, method2);
}

+ (void)method_1:(NSString *)str {
    NSLog(@"Person-method_1类方法");
}

+ (void)method_2:(NSString *)str {
    NSLog(@"Person-method_2类方法");
}

@end
