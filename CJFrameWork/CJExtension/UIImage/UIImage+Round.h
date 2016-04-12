//
//  UIImage+Round.h
//  YSUseek
//
//  Created by 陆龙 on 15/10/12.
//  Copyright (c) 2015年 liming4343@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Round)
- (UIImage*)roundImage;
- (UIImage*)roundImageWithSize:(CGSize)size;
-(UIImage *)roundedImageWithCornerRadius:(CGFloat)cornerRadius;
-(UIImage *)roundedImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end
