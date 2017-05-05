//
//  Person.h
//  Runtime
//
//  Created by 康鹏鹏 on 2017/5/2.
//  Copyright © 2017年 dhcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

@interface Person : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSUInteger age;

- (void)run;

- (void)eatWithFood:(NSString *)food;

+ (void)run;


+ (void)method_1:(NSString *)str;

+ (void)method_2:(NSString *)str;

@end
