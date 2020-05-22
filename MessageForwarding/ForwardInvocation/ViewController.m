//
//  ViewController.m
//  ForwardInvocation
//
//  Created by 梁展焯 on 2020/5/21.
//  Copyright © 2020 梁展焯. All rights reserved.
//

#import "ViewController.h"
#import "objc/message.h"
#import "objc/runtime.h"

@interface Person: NSObject

@end

@implementation Person

- (void)foo {
    NSLog(@"Doing Person foo");//Person的foo函数
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

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(foo)){
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    if (anInvocation.selector == @selector(foo)){
        Person *person = [Person new];
        [anInvocation invokeWithTarget:person];
    }else{
        [super forwardInvocation:anInvocation];
    }
}

@end
