//
//  ViewController.m
//  DynamicMethodResolution
//
//  Created by 梁展焯 on 2020/5/21.
//  Copyright © 2020 梁展焯. All rights reserved.
//

#import "ViewController.h"
#import "objc/message.h"
#import "objc/runtime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //执行foo函数
    [self performSelector:@selector(foo)];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(foo)){
        class_addMethod([self class], sel, (IMP) dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void dynamicMethodIMP(id self, SEL _cmd)
{
    NSLog(@"Doing dynamic foo");
}

@end
