//
//  CJUITableView.m
//  CJPodsTest
//
//  Created by 程健 on 16/3/14.
//  Copyright © 2016年 程健. All rights reserved.
//

#import "CJUITableView.h"
#import "CJExtensions.h"

@implementation CJNullTableAlertView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end



@implementation CJUITableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end





#define nullAlertViewTag   888

@interface CJRefreshTableView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)id <UITableViewDelegate> cjTableViewDelegate;
@property(nonatomic,weak)id <UITableViewDataSource>cjTableViewDataSource;
@property(nonatomic,strong)CJNullTableAlertView *nullAlertView;
@end

@implementation CJRefreshTableView
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self config];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self config];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_nullAlertView setFrame:CGRectMake(self.width/2-150/2, self.height/2-97/2-40, 150, 97)];
    //    [_nullAlertView setCenter:self.center];
}


#pragma mark - Custom view configuration
- (void) config
{
    _pullDownRefreshed = YES;
    
    _pageing = 1;
    _pagecount = 20;
    _nullAlertViewHidden = YES;
    
    _nullAlertView = [[[NSBundle mainBundle] loadNibNamed:@"CJNullTableAlertView" owner:nil options:nil] lastObject];
    [_nullAlertView setHidden:_nullAlertViewHidden];
    [self addSubview:_nullAlertView];
    
    [self example05];
    [self example14];
    
    [self setLoadMoreRefreshed:NO];
}

-(void)headerRefreshing
{
    if (self.pullDelegate && [self.pullDelegate respondsToSelector:@selector(refreshtable:beginRefreshingWithType:)]) {
        [self.pullDelegate refreshtable:self beginRefreshingWithType:CJPullDownRefreshing];
    }
}

-(void)footerRefreshing
{
    if (self.pullDelegate && [self.pullDelegate respondsToSelector:@selector(refreshtable:beginRefreshingWithType:)]) {
        [self.pullDelegate refreshtable:self beginRefreshingWithType:CJLoadMoreRefreshing];
    }
}


/**
 * UITableView + 下拉刷新 隐藏状态和时间02
 */
- (void)example05
{
    // 添加动画图片的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    
    // 隐藏时间
    self.header.updatedTimeHidden = YES;
    
    // 隐藏状态
    self.header.stateHidden = YES;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    // 此时self.tableView.header == self.tableView.gifHeader
}


/**
 * UITableView + 上拉刷新 隐藏状态02
 */
- (void)example14
{
    // 添加动画图片的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [self addGifFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    
    // 隐藏状态
    self.footer.stateHidden = YES;
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    self.gifFooter.refreshingImages = refreshingImages;
}



-(void)setAlertText:(NSString *)alertText
{
    _alertText = alertText;
    [_nullAlertView.titleLabel setText:alertText];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if ([super respondsToSelector:aSelector]) {
        return nil;
    }else if ([_cjTableViewDelegate respondsToSelector:aSelector]){
        return _cjTableViewDelegate;
    }else  if([_cjTableViewDataSource respondsToSelector:aSelector]){
        return _cjTableViewDataSource;
    }else{
        return nil;
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }else  if([_cjTableViewDelegate respondsToSelector:aSelector]){
        return YES;
    }else  if([_cjTableViewDataSource respondsToSelector:aSelector]){
        return YES;
    }else{
        return NO;
    }
}

-(void)setDelegate:(id<UITableViewDelegate>)delegate{
    _cjTableViewDelegate = (delegate != self)?delegate:nil;
    [super setDelegate:self];
}

-(void)setDataSource:(id<UITableViewDataSource>)dataSource
{
    _cjTableViewDataSource = (dataSource !=self)?dataSource:nil;
    [super setDataSource:self];
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_cjTableViewDataSource && [_cjTableViewDataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        long count = [_cjTableViewDataSource tableView:tableView numberOfRowsInSection:section];
        [_nullAlertView setHidden:_nullAlertViewHidden];
        if (!_nullAlertViewHidden) {
            [_nullAlertView setHidden:count];
        }
        return count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (_cjTableViewDataSource && [_cjTableViewDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [_cjTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

-(void)setPullDownRefreshed:(BOOL)pullDownRefreshed
{
    _pullDownRefreshed = pullDownRefreshed;
    self.header.hidden = !pullDownRefreshed;
}

-(void)setLoadMoreRefreshed:(BOOL)loadMoreRefreshed
{
    _loadMoreRefreshed = loadMoreRefreshed;
    self.footer.hidden = !loadMoreRefreshed;
}

- (void)startPullDownRefreshing
{
    [self.header beginRefreshing];
}

- (void)endPullDownRefreshing
{
    [self.header endRefreshing];
}

- (void)endLoadMoreRefreshing
{
    [self.footer endRefreshing];
}
@end


