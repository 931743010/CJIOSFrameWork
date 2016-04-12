//
//  GWabItem.h
//  GameBox
//
//  Created by mingzi on 13-7-31.
//  Copyright (c) 2013年 liming@vszone.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@class CJUITabItem;
@protocol CJUITabItemDelegate <NSObject>
@optional
- (BOOL)CJUITabItem:(CJUITabItem*)sender willSelecteIndex:(NSInteger)index;
@end

@interface CJUITabItem : UIView
@property(nonatomic, strong)UIImage  *image;
@property(nonatomic, strong)UIImage  *heightImage;
@property(nonatomic, strong)UIImage  *bimage;
@property(nonatomic, strong)UIImage  *bHeightImage;
@property(nonatomic, strong)NSString   *title;
@property(nonatomic, strong)id        userData;
@property(nonatomic, assign)BOOL      selected;




@property(nonatomic, weak)id<CJUITabItemDelegate> delegate;
@end