//
//  UIImage+Round.m
//  YSUseek
//
//  Created by 陆龙 on 15/10/12.
//  Copyright (c) 2015年 liming4343@163.com. All rights reserved.
//

#import "UIImage+Round.h"

@implementation UIImage (Round)

- (UIImage*)roundImage
{
    //
    CGSize size = CGSizeMake(self.size.width, self.size.height);
    //创建图片上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //绘制边框的圆
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextFillPath(context);
    //设置头像frame
    CGFloat iconX = 0;
    CGFloat iconY = 0;
    CGFloat iconW = size.width;
    CGFloat iconH = size.height;
    //绘制圆形头像范围
    CGContextAddEllipseInRect(context, CGRectMake(iconX, iconY, iconW, iconH));
    //剪切可视范围
    CGContextClip(context);
    //绘制头像
    [self drawInRect:CGRectMake(iconX, iconY, iconW, iconH)];
    //取出整个图片上下文的图片
    UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
    return iconImage;
}



- (UIImage*)roundImageWithSize:(CGSize)size
{
        UIView *snapshotView = nil;
        UIImageView *imageView = nil;
        if ( !snapshotView )
        {
            snapshotView = [UIView new];
            snapshotView.frame = CGRectMake(0, 0, size.width, size.height);
            imageView = [UIImageView new];
            [snapshotView addSubview:imageView];
            imageView.clipsToBounds = YES;
            imageView.frame = snapshotView.bounds;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            //        CGFloat arrowWidth = 14;
            CGMutablePathRef path = CGPathCreateMutable();
            //把圆的绘图信息添加到路径
            CGPathAddEllipseInRect(path, NULL, snapshotView.frame);
            CGPathCloseSubpath(path);
            CAShapeLayer *shapelayer = [CAShapeLayer layer];
            shapelayer.frame = imageView.bounds;
            shapelayer.path = path;
            imageView.layer.mask = shapelayer;
            snapshotView.layer.shadowPath = path;
            //        snapshotView.layer.shadowRadius = 1.0f;
            //        snapshotView.layer.shadowColor = [UIColor grayColor].CGColor;
            //        snapshotView.layer.shadowOpacity = 1.0f;
            //        snapshotView.layer.shadowOffset = CGSizeMake(0, 0);
            CGPathRelease(path);
        }
        imageView.image = self;
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        [snapshotView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *copied = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return copied;
}



-(UIImage *)roundedImageWithCornerRadius:(CGFloat)cornerRadius
{
    CGRect rect = CGRectMake(0, 0, cornerRadius*2,cornerRadius*2);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);

    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:cornerRadius] addClip];
    
    // Draw your image
    [self drawInRect:rect];
    // Get the image, here setting the UIImageView image
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    return roundedImage;
}

-(UIImage *)roundedImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 2.开启上下文
    CGFloat imageW = self.size.width + 22 * borderWidth;
    CGFloat imageH = self.size.height + 22 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [self drawInRect:CGRectMake(borderWidth, borderWidth, self.size.width, self.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
