//
//  CJWebViewController.m
//  CJFrameWork
//
//  Created by 程健 on 16/3/13.
//  Copyright © 2016年 程健. All rights reserved.
//

#import "CJWebViewController.h"
@interface CJWebViewController ()
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UIActivityIndicatorView *activity;
@end

@implementation CJWebViewController


-(void)showLoading
{
    [self.activity startAnimating];
}

-(void)hideLoading
{
    [self.activity stopAnimating];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    
//    self.view.backgroundColor = [UIColor colorWithRGBRed:249 green:249 blue:249];
    
    _webView = [ [ UIWebView alloc ] initWithFrame: CGRectMake(0,64, self.view.frame.size.width,self.view.frame.size.height-64)];
    _webView.scalesPageToFit = YES;
    _webView.autoresizesSubviews = YES;
    _webView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    //set the web view delegates for the web view to be itself
    [_webView setDelegate:(id<UIWebViewDelegate>)self];
    [ self.view addSubview: _webView ];
    
    
    self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];//指定进度轮的大小
    [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.activity hidesWhenStopped];
    [self.activity setCenter:self.view.center];//指定进度轮中心点
    
    [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];//设置进度轮显示类型
    self.activity.color=[UIColor blackColor];
    [self.view addSubview:self.activity];
    
    
    __weak typeof(self)ws = self;
    [self setNavBarRightItemWithTitle:@"刷新" clickBlock:^{
                    [ws reloadWebData];
        
    }];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlPath]];
    //load the URL into the web view.
    [_webView loadRequest:requestObj];
    
    [self reloadWebData];
}


-(void)reloadWebData
{
    [self showLoading];
    [self setNaviBarTitle:@"加载中..."];
    [self.webView reload];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideLoading];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setNaviBarTitle:title];
}
@end

