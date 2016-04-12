//
//  CJUIWebImageView.h
//  CJPodsTest
//
//  Created by 程健 on 16/3/14.
//  Copyright © 2016年 程健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJUIView.h"
#import "YYKit.h"

@interface CJUIWebImageView : CJUIView
@property (nonatomic, strong) YYAnimatedImageView *webImageView;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) NSString *imageURL;
@end
