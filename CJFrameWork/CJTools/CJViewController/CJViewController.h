//
//  CJViewController.h
//  CJFrameWork
//
//  Created by 程健 on 16/3/11.
//  Copyright © 2016年 程健. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface UIViewController (Nav)

/*
 设置导航栏title
 */
- (void)setNaviBarTitle:(NSString *)title;


/*
 * 设置导航左边按钮title
 */
-(void)setNavBarLeftItemWithTitle:(NSString *)title
                       clickBlock:(void(^)(void))block;


/*
 * 设置导航右边按钮title
 */
-(void)setNavBarRightItemWithTitle:(NSString *)title
                        clickBlock:(void(^)(void))block;



/*
 * 设置导航左边按钮image
 */
-(void)setNavBarLeftItemWithImage:(NSString *)image
                       clickBlock:(void(^)(void))block;


/*
 * 设置导航右边按钮image
 */
-(void)setNavBarRightItemWithImage:(NSString *)image
                        clickBlock:(void(^)(void))block;

@end



@interface CJViewController : UIViewController


-(void)showLoading;
-(void)hideLoading;
-(void)showTitle:(NSString *)text;
-(void)showDetailText:(NSString *)text;
-(void)showSuccess:(NSString *)text;
-(void)showError:(NSString *)text;
@end










