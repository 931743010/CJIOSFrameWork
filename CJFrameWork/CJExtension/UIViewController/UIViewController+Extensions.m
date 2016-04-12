//
//  UIViewController+Extensions.m
//  YSUseek
//
//  Created by 程健 on 15/11/6.
//  Copyright © 2015年 liming4343@163.com. All rights reserved.
//

#import "UIViewController+Extensions.h"
#import "CJUIButton.h"
#import "UIView-Extensions.h"


@implementation UIViewController (Extensions)
+(UIViewController *)getCurrentRootViewController {
    
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
    
}

@end




