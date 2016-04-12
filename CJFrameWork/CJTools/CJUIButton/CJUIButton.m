//
//  CJUIButton.m
//  CJFrameWork
//
//  Created by 程健 on 16/3/13.
//  Copyright © 2016年 程健. All rights reserved.
//

#import "CJUIButton.h"

@implementation CJUIButton

- (void)clickEvent:(id)sender {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.alpha = highlighted?0.5:1.0f;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self addTarget:self action:@selector(clickEvent:)
   forControlEvents:UIControlEventTouchUpInside];
}
@end

