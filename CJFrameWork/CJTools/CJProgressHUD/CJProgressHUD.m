//
//  YSProgressHUD.m
//  YSUseek
//
//  Created by orange on 15/6/6.
//  Copyright (c) 2015年 liming4343@163.com. All rights reserved.
//

#import "CJProgressHUD.h"
//@interface CJProgressView:UIView
//@property(nonatomic,strong)UIImageView *animationImage;
//@end
//@implementation CJProgressView
//
//- (void)dealloc
//{
//    [self stopAnimating];
//}
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setBackgroundColor:[UIColor clearColor]];
//        
//        UIView *back = [[UIView alloc] initWithFrame:self.bounds];
//        [back setBackgroundColor:[UIColor clearColor]];
//        [self addSubview:back];
//        
//        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 100, 100)];
//        [backView setCenter:self.center];
//        [backView setAlpha:0.9];
//        [backView setBackgroundColor:[UIColor colorWithRGBRed:85 green:85 blue:85]];
//        backView.layer.cornerRadius = 8;
//        backView.layer.masksToBounds = YES;
//        [self addSubview:backView];
//        
//        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//        [logo setImage:[XResource imageWithName:@"loading2"]];
//        [logo setCenter:self.center];
//        [self addSubview:logo];
//        
//        _animationImage = [[UIImageView alloc] initWithFrame:logo.frame];
//        _animationImage.center = self.center;
//        [_animationImage setImage:[XResource imageWithName:@"loading1"]];
//        [self addSubview:_animationImage];
//        
//        [self startAnimating];
//    }
//    return self;
//}
//
//
//#pragma -mark 接口方法
//-(void)startAnimating
//{
//    CABasicAnimation* rotationAnimation;
//    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
//    rotationAnimation.duration = 0.6;
//    rotationAnimation.cumulative = YES;
//    rotationAnimation.repeatCount = MAXFLOAT;
//    [_animationImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
//}
//
//-(void)stopAnimating
//{
//    [_animationImage.layer removeAnimationForKey:@"rotationAnimation"];
//}
//@end

@implementation CJProgressHUD

//
//#pragma mark 显示加载框 view 传nil 则加载到window上
//+(void)showLoad:(UIView *)view
//{
//    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
//    [YSProgressHUD hideLoad:view];
//    YSProgressView *v = [[YSProgressView alloc] initWithFrame:view.bounds];
//    [view addSubview:v];
//}
//
//
//#pragma mark 隐藏加载框
//+(void)hideLoad:(UIView *)view
//{
//    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
//    for (UIView *views in [view subviews]) {
//        if ([views isKindOfClass:[YSProgressView class]]) {
//            [views removeFromSuperview];
//        }
//    }
//}



#pragma mark 显示加载框 view 传nil 则加载到window上
+(void)showLoad:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    for (UIView *views in [view subviews]) {
        if ([views isKindOfClass:[MBProgressHUD class]]) {
            return;
        }
    }
    
    //初始化进度框，置于当前的View当中
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //    hud.dimBackground = YES;
    [hud setColor:[UIColor blackColor]];
    hud.minSize = CGSizeMake(120, 120);
    hud.removeFromSuperViewOnHide=YES;
    //设置对话框文字
    hud.labelText = @"正在加载...";
}


#pragma mark 显示加载框
+(void)showLoad:(UIView *)view title:(NSString *)title
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide=YES;
    [hud setColor:[UIColor blackColor]];
    hud.minSize = CGSizeMake(120, 120);
    hud.labelText = title;
}


#pragma mark 隐藏加载框
+(void)hideLoad:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    for (UIView *views in [view subviews]) {
        if ([views isKindOfClass:[MBProgressHUD class]]) {
            [(MBProgressHUD *)views hide:YES];
        }
    }
}







#pragma mark 显示提示文字
+ (void)showTitle:(NSString *)title toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [CJProgressHUD hideLoad:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.labelText = title;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.dimBackground = NO;
    [hud setColor:[UIColor blackColor]];
    hud.animationType = MBProgressHUDAnimationFade;
    [hud hide:YES afterDelay:1.5];
}


#pragma mark 显示提示详情
+ (void)showDetailText:(NSString *)text toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [CJProgressHUD hideLoad:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.detailsLabelText = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.dimBackground = NO;
    [hud setColor:[UIColor blackColor]];
    hud.animationType = MBProgressHUDAnimationFade;
    [hud hide:YES afterDelay:1.5];
}


#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"ImageError.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"Checkmark.png" view:view];
}

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [CJProgressHUD hideLoad:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.7];
}
@end
