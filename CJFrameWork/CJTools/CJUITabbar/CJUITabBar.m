//
//  GTabToolbar.m
//  GameBox
//
//  Created by mingzi on 13-7-31.
//  Copyright (c) 2013年 liming@vszone.cn. All rights reserved.
//

#import "CJUITabBar.h"
#import "CJUITabItem.h"

@interface CJUITabBar()<CJUITabItemDelegate>{
    int number;
}
@property(nonatomic, strong)NSMutableArray *menuItems;
@property(nonatomic, strong)CJUITabItem *meItem;

@end


@implementation  CJUITabBar(notification)
- (void)addNotification {

}

- (void)removeNotificatioin{

}

@end


@implementation CJUITabBar




- (id)initWithFrame:(CGRect)frame  {
    self = [super initWithFrame:frame];
    if (self) {
        
        _menuItems = [[NSMutableArray alloc] initWithCapacity:5];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
        [array addObject:@{@"image":@"tabbar_news_icon_new@3x",@"imageHL":@"tabbar_news_iconHL_new@3x"}];
        [array addObject:@{@"image":@"tabbar_message_icon_new@3x",@"imageHL":@"tabbar_message_iconHL_new@3x"}];
        [array addObject:@{@"image":@"tabbar_app_icon_new@3x",@"imageHL":@"tabbar_app_iconHL_new@3x"}];
        [array addObject:@{@"image":@"tabbar_contact_icon_new@3x",@"imageHL":@"tabbar_contact_iconHL_new@3x"}];
        [array addObject:@{@"image":@"tabbar_me_icon_new@3x",@"imageHL":@"tabbar_me_iconHL_new@3x"}];
        
        for (int i = 0; i<[array count]; i++) {
            CGRect hframe = CGRectMake(i*CGRectGetWidth(self.frame)/array.count, 0, CGRectGetWidth(self.frame)/array.count, frame.size.height);
            CJUITabItem *item = [[CJUITabItem alloc] initWithFrame:hframe];
            [item setBimage:[UIImage imageNamed:[[array objectAtIndex:i] objectForKey:@"image"]]];
            [item setBHeightImage:[UIImage imageNamed:[[array objectAtIndex:i] objectForKey:@"imageHL"]]];
            [item setSelected:NO];
            [item setTag:i];
            [item setDelegate:self];
            [self addSubview:item];
            [self.menuItems addObject:item];


        }
        
        [self setSeletedIndex:2];
    }
    return self;
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    BOOL rotate = [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait | [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown;
    if (rotate) {
        //frame.size.height = [UIScreen mainScreen].bounds.size.height;
        frame.size.width = [UIScreen mainScreen].bounds.size.width;
    }else{
       // frame.size.height = [UIScreen mainScreen].bounds.size.width;
        frame.size.width = [UIScreen mainScreen].bounds.size.height;
    }
    float height = frame.size.height;
    if (self.menuItems && [self.menuItems count]>0) {
        float width = ceilf(frame.size.width / [self.menuItems count]);
        for (int i=0; i < [self.menuItems count]; i++) {
            CJUITabItem * item = [self.menuItems objectAtIndex:i];
            item.frame = CGRectMake(i * width, 0,width, height);
        }
    }
}
- (void)setSeletedIndex:(NSInteger)seletedIndex {
    if (seletedIndex<0) {
        seletedIndex = 0;
    }
    
    if (seletedIndex >= self.menuItems.count) {
        seletedIndex = self.menuItems.count-1;
    }
    
    for (CJUITabItem *item in self.menuItems) {
        [item setSelected:NO];
    }
    CJUITabItem *item = [self.menuItems objectAtIndex:seletedIndex];
    _seletedIndex = seletedIndex;
    [item setSelected:YES];
}

- (BOOL)CJUITabItem:(CJUITabItem *)sender willSelecteIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(CJUITabBar:willSelectedButton:buttonIndex:)]) {
        if ([self.delegate CJUITabBar:self willSelectedButton:sender buttonIndex:index]) {
            for (UIView *item in self.subviews) {
                if ([item isKindOfClass:[CJUITabItem class]] && ![item isEqual:sender]) {
                    [(CJUITabItem*)item setSelected:NO];
                }
            }
            return YES;
        }
    }
    return NO;
}


//指定tabbar添加徽章
-(void)addBadge:(NSInteger)index strBadgeValue:(NSString *)strBadgeValue
{
    [self removeBage:index];
    if (strBadgeValue&&![strBadgeValue isEqualToString:@""]&&![strBadgeValue isEqualToString:@"0"]&&![strBadgeValue isKindOfClass:[NSNull class]]) {
        if (index==0||index==1 || index == 3) {
            if ([strBadgeValue intValue]>99) {
                [self addBadgeValue:[self.menuItems objectAtIndex:index] number:@"99+"];
            }else{
                [self addBadgeValue:[self.menuItems objectAtIndex:index] number:strBadgeValue];
            }
        }else{
            [self addBadgeValue:[self.menuItems objectAtIndex:index] number:strBadgeValue];
        }
    }
}

//指定tabbar删除徽章
-(void)removeBage:(NSInteger)index
{
    if (index==0||index==3 ||index==1 ||index==2) {
       [self removeBadgeView:[self.menuItems objectAtIndex:index]];
    }else{
        UIView *view = [self.menuItems objectAtIndex:index];
        for(UIView* subView in view.subviews) {
            if(subView.tag==888) {
                [subView removeFromSuperview];
            }
        }
    }
}

//添加右上角徽章
- (UIView *)addBadgeValue:(UIView*)view number:(NSString *)strBadgeValue
{
    [self removeBadgeView:view];

    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 50)];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:0];
    item.badgeValue = strBadgeValue;
    NSArray *array = [[NSArray alloc] initWithObjects:item, nil];
    tabBar.items = array;

    
    //找出徽章
    for (UIView *viewTab in tabBar.subviews) {
        for (UIView *subview in viewTab.subviews) {
             NSString *strClassName = NSStringFromClass(subview.class);
            if([strClassName rangeOfString:@"badge" options:NSCaseInsensitiveSearch].length)
            {
                [view addSubview:subview];
                subview.frame = CGRectMake(view.frame.size.width-subview.frame.size.width, 0,
                                           subview.frame.size.width, subview.frame.size.height);
                return subview;
            }
        }
    }
    return nil;
}

//从view中获取徽章
- (UIView*)getBadgeInView:(UIView*)view
{
    for(UIView* subView in view.subviews)
    {
        NSString *strClassName = NSStringFromClass(subView.class);
        //查找徽章
        if([strClassName rangeOfString:@"badge" options:NSCaseInsensitiveSearch].length)
        {
            return subView;
        }
    }
    return nil;
}


//移除徽章
- (void)removeBadgeView:(UIView*)view
{
    for(UIView* subView in view.subviews)
    {
        NSString *strClassName = NSStringFromClass(subView.class);
        //查找徽章
        if([strClassName rangeOfString:@"badge" options:NSCaseInsensitiveSearch].length)
        {
            [subView removeFromSuperview];
        }
    }
}
@end
