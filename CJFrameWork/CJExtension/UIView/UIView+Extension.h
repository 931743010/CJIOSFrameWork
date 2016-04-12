//
//  UIView+Extension.h
//  YSUseek
//
//  Created by orange on 15/4/14.
//  Copyright (c) 2015年 liming4343@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
- (UIImage *)rn_screenshot;


//添加徽章
-(void)addBadge:(NSString *)badgeValue;
- (UIView *)showBadgeValue:(NSString *)strBadgeValue;
- (void)removeBadgeValue;
@end
