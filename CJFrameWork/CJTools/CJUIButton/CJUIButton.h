//
//  CJUIButton.h
//  CJFrameWork
//
//  Created by 程健 on 16/3/13.
//  Copyright © 2016年 程健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJUIButton : UIButton
@property(nonatomic, strong)void (^clickBlock)(void);
@end
