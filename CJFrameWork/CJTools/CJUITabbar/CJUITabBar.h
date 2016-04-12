//
//  GTabToolbar.h
//  GameBox
//
//  Created by mingzi on 13-7-31.
//  Copyright (c) 2013年 liming@vszone.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CJUITabBarDelegate <NSObject>
@optional
- (BOOL)CJUITabBar:(id)toolbar willSelectedButton:(id)button buttonIndex:(NSInteger)index;
@end
@interface CJUITabBar : UIView
@property(nonatomic, weak)id<CJUITabBarDelegate> delegate;
@property(nonatomic, assign)NSInteger   seletedIndex;

//指定tabbar添加徽章
-(void)addBadge:(NSInteger)index strBadgeValue:(NSString *)strBadgeValue;

//指定tabbar删除徽章
-(void)removeBage:(NSInteger)index;
@end
