//
//  UIView+Extension.m
//  YSUseek
//
//  Created by orange on 15/4/14.
//  Copyright (c) 2015年 liming4343@163.com. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (UIImage *)rn_screenshot {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}




-(void)addBadge:(NSString *)badgeValue
{
    [self removeBadgeValue];
    if ([badgeValue isEqualToString:@""]||[badgeValue isEqualToString:@"0"]) {
        [self removeBadgeValue];
    }else{
        if ([badgeValue intValue]>99) {
            [self showBadgeValue:@"99+"];
        }else{
            [self showBadgeValue:badgeValue];
        }
    }
}

- (UIView *)showBadgeValue:(NSString *)strBadgeValue
{
    float w = [UIScreen mainScreen].bounds.size.width;
    
    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, w, 50)];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:0];
    item.badgeValue = strBadgeValue;
    NSArray *array = [[NSArray alloc] initWithObjects:item, nil];
    tabBar.items = array;
    
    for (UIView *viewTab in tabBar.subviews) {
        for (UIView *subview in viewTab.subviews) {
            NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
            if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
                [strClassName isEqualToString:@"_UIBadgeView"]) {
                //从原视图上移除
                [subview removeFromSuperview];
                //
                [self addSubview:subview];
                
                if (self.frame.size.width==30) {
                    subview.frame = CGRectMake(0, 0,
                                               subview.frame.size.width, subview.frame.size.height);
                }else{
                    subview.frame = CGRectMake(self.frame.size.width-subview.frame.size.width, 0,
                                               subview.frame.size.width, subview.frame.size.height);
                }
                return subview;
            }
        }
    }
    return nil;
}

- (void)removeBadgeValue
{
    //
    for (UIView *subview in self.subviews) {
        NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
        if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
            [strClassName isEqualToString:@"_UIBadgeView"]) {
            [subview removeFromSuperview];
            break;
        }
    }
}
@end
