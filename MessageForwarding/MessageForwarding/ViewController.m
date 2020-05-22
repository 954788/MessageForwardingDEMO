//
//  ViewController.m
//  runtimeTest
//
//  Created by 梁展焯 on 2020/5/20.
//  Copyright © 2020 梁展焯. All rights reserved.
//

#import "ViewController.h"
#import "objc/message.h"
#import "objc/runtime.h"

@interface CorrectPeople : NSObject

@end

@implementation CorrectPeople

- (void)foo {
    NSLog(@"Doing CorrectPeople foo");
}

@end

@interface WrongPeople: NSObject

@end

@implementation WrongPeople


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(foo)){
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL aSelector = [anInvocation selector];
    CorrectPeople *people = [[CorrectPeople alloc] init];
    if ([people respondsToSelector:aSelector])
        [anInvocation invokeWithTarget:people];
    else
        [super forwardInvocation:anInvocation];
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //执行foo函数
    [self performSelector:@selector(foo)];
}

/// DynamicMethodResolution
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(foo)){
        return NO;
    }
    return [super resolveInstanceMethod:sel];
}

/// ForwardingTargetForSelector
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(foo)) {
        return [WrongPeople new];//让WrongPeople对象接收这个消息
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

@end
