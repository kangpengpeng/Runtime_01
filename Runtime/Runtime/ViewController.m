//
//  ViewController.m
//  Runtime
//
//  Created by 康鹏鹏 on 2017/5/2.
//  Copyright © 2017年 dhcc. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface ViewController ()
@property (nonatomic, strong) Person *teacher;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     Person *p = [[Person alloc] init];
    // Xcode5 之后，苹果不建议使用底层方法
    //target ——> Build Settings ——> （搜索）msgSend
    objc_msgSend(p, @selector(run));
    objc_msgSend(p, @selector(eatWithFood:), @"馒头");
    
    // 类方法
    Class pClass = [Person class];
    [pClass performSelector:@selector(run)];
    // perform的底层方法
    objc_msgSend(pClass, @selector(run));
     */
    
    /*
    // Ivar: runtime里边，Ivar 代表成员变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Person class], &count);
    Ivar ivar = ivars[0];
    const char *name = ivar_getName(ivar);
     */
    
    [Person method_1:@"111"];
}

- (IBAction)save:(id)sender {
    Person *teacher = [[Person alloc] init];
    teacher.name = @"康鹏";
    teacher.age = 24;
    // 沙盒
    NSString *temp = NSTemporaryDirectory();
    NSString *filePath = [temp stringByAppendingPathComponent:@"teacher.person"];
//    NSLog(@"%@", filePath);
    // 归档
    [NSKeyedArchiver archiveRootObject:teacher toFile:filePath];
}


- (IBAction)read:(id)sender {
    // 路径
    NSString *temp = NSTemporaryDirectory();
    NSString *filePath = [temp stringByAppendingPathComponent:@"teacher.person"];
    // 解档
    Person *t = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    NSLog(@"解档：老师是%@，%lu岁了", t.name, (unsigned long)t.age);
}




@end
