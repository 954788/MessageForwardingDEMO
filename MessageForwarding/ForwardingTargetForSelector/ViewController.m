//
//  ViewController.m
//  ForwardingTargetForSelector
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

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(foo)){
        Person *person = [Person new];
       
        return person;
    }else{
        return [super forwardingTargetForSelector:aSelector];
    }
}

@end



