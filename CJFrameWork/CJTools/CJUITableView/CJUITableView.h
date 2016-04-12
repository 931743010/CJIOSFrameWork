//
//  CJUITableView.h
//  CJPodsTest
//
//  Created by 程健 on 16/3/14.
//  Copyright © 2016年 程健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"


@interface CJNullTableAlertView : UIView
@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)IBOutlet UIImageView *logoImageView;
@end




@interface CJUITableView : UITableView

@end



@class CJRefreshTableView;


typedef enum
{
    CJPullDownRefreshing,
    CJLoadMoreRefreshing,
}CJRefreshingType;


@protocol CJRefreshTableViewDelegate<NSObject>
@optional
- (void)refreshtable:(CJRefreshTableView *)refreshtable beginRefreshingWithType:(CJRefreshingType)refreshType;
@end



@interface CJRefreshTableView : CJUITableView
@property(nonatomic,assign)long pageing;
@property(nonatomic,assign)long pagecount;
@property(nonatomic,weak)id<CJRefreshTableViewDelegate>pullDelegate;
@property(nonatomic, assign) BOOL pullDownRefreshed;
@property(nonatomic, assign) BOOL loadMoreRefreshed;
@property(nonatomic,copy)NSString *alertText;     //defaul 获取数据为空
@property(nonatomic,assign)BOOL nullAlertViewHidden;  //default  YES
- (void)startPullDownRefreshing;
- (void)endPullDownRefreshing;
- (void)endLoadMoreRefreshing;
@end


