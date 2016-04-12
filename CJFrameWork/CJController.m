//
//  YSController.m
//  YSUseek
//
//  Created by mingzi on 14-10-18.
//  Copyright (c) 2014年 liming4343@163.com. All rights reserved.
//

#import "CJController.h"



@implementation CJController
+ (id)sharedInstance {
    static dispatch_once_t controller;
    static id sharedObject = nil;
    dispatch_once(&controller, ^{
        if (sharedObject == nil) {
            sharedObject = [[[self class] alloc] init];
        }
    });
    return sharedObject;
}

@end
