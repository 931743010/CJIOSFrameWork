//
//  CJNavgationController.m
//  CJFrameWork
//
//  Created by 程健 on 16/3/11.
//  Copyright © 2016年 程健. All rights reserved.
//

#import "CJNavgationController.h"
#import <objc/runtime.h>


@implementation UINavigationBar (BackgroundColor)static char overlayKey;

- (UIView *)overlay
{    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{    if (!self.overlay) {
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];        // insert an overlay into the view hierarchy
    self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
    [self insertSubview:self.overlay atIndex:0];
}    self.overlay.backgroundColor = backgroundColor;
}@end




@interface CJNavgationController ()

@end

@implementation CJNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)])
    {
        [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    }
    //    self.view.backgroundColor = YSCOLORBACKVIEW;
    //    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    //    [headerView setBackgroundColor:[UIColor clearColor]];
    //    [self.view addSubview:headerView];
    //    [self setHeaderView:headerView];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.interactivePopGestureRecognizer.delaysTouchesBegan=NO;
//    [self.navigationBar lt_setBackgroundColor:YSCOLORYELLOW];
    //导航条深色
    //    [[UINavigationBar appearance] setBarTintColor:YSCOLORYELLOW];
    
}



//
//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [super pushViewController:viewController animated:animated];
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.delegate = nil;
//    }
//}
//
//+ (UINavigatioinController *)rootViewController:(UIViewController *)viewController {
//    return [[UINavigatioinController alloc] initWithRootViewController:viewController];
//}
//
//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleDefault;
//}

@end
