//
//  CJViewController.m
//  CJFrameWork
//
//  Created by 程健 on 16/3/11.
//  Copyright © 2016年 程健. All rights reserved.
//

#import "CJViewController.h"
#import "CJExtensions.h"
#import "CJProgressHUD.h"
#import "CJDefined.h"





@implementation UIViewController (Nav)

/*
 设置导航栏title
 */
- (void)setNaviBarTitle:(NSString *)title
{
    [self.navigationItem setTitle:title];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.text = title;
    self.navigationItem.titleView = titleLabel;
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""  style:UIBarButtonItemStylePlain  target:self  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}



/*
 * 设置导航左边按钮title
 */
-(void)setNavBarLeftItemWithTitle:(NSString *)title
                       clickBlock:(void(^)(void))block
{
    CJUIButton *button = [CJUIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 50, 32)];
    [button setClickBlock:block];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button.titleLabel setShadowOffset:CGSizeMake(0, 0)];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font,NSFontAttributeName,nil];
    CGSize  size =[title boundingRectWithSize:CGSizeMake(100, 32) options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading  attributes:tdic context:nil].size;
    
    
    button.width = size.width + 20;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}


/*
 * 设置导航右边按钮title
 */
-(void)setNavBarRightItemWithTitle:(NSString *)title
                        clickBlock:(void(^)(void))block;
{
    CJUIButton *button = [CJUIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 50, 32)];
    [button setClickBlock:block];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button.titleLabel setShadowOffset:CGSizeMake(0, 0)];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font,NSFontAttributeName,nil];
    CGSize  size =[title boundingRectWithSize:CGSizeMake(100, 32) options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading  attributes:tdic context:nil].size;
    
    button.width = size.width + 20;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}





/*
 * 设置导航左边按钮image
 */
-(void)setNavBarLeftItemWithImage:(NSString *)image
                       clickBlock:(void(^)(void))block
{
    CJUIButton *button = [CJUIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 50, 32)];
    [button setClickBlock:block];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}


/*
 * 设置导航右边按钮image
 */
-(void)setNavBarRightItemWithImage:(NSString *)image
                        clickBlock:(void(^)(void))block
{
    CJUIButton *button = [CJUIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 50, 32)];
    [button setClickBlock:block];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

@end






@interface CJViewController ()

@end

@implementation CJViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CJColorBackGround;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.modalPresentationCapturesStatusBarAppearance = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}



-(void)showLoading
{
    [CJProgressHUD showLoad:self.view];
}

-(void)hideLoading
{
    [CJProgressHUD hideLoad:self.view];
}

-(void)showTitle:(NSString *)text
{
    [CJProgressHUD showTitle:text toView:self.view];
}

-(void)showDetailText:(NSString *)text
{
    [CJProgressHUD showDetailText:text toView:self.view];
}

-(void)showSuccess:(NSString *)text
{
    [CJProgressHUD showSuccess:text toView:self.view];
}

-(void)showError:(NSString *)text
{
    [CJProgressHUD showError:text toView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



