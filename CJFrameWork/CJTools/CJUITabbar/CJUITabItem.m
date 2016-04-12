//
//  GWabItem.m
//  GameBox
//
//  Created by mingzi on 13-7-31.
//  Copyright (c) 2013年 liming@vszone.cn. All rights reserved.
//

#import "CJUITabItem.h"

@interface CJUITabItem()
@property(nonatomic, strong)UIImageView *bImageView;
@property(nonatomic, strong)UIImageView *buttonIcon;
@property(nonatomic, strong)UIControl   *itemControl;
@property(nonatomic, strong)UILabel     *titleLabel;
@end

@implementation CJUITabItem

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGRect zframe = CGRectMake((frame.size.width-100/3)/2, (frame.size.height-133/3)/2, 100/3, 133/3);
        UIImageView *bImageView = [[UIImageView alloc] initWithFrame:zframe];
        [bImageView setBackgroundColor:[UIColor clearColor]];
        [bImageView setImage:nil];
        [self addSubview:bImageView];
        [self setBImageView:bImageView];
        bImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
        

//        UILabel *t_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 20)];
//        [t_label setBackgroundColor:[UIColor clearColor]];
//        [t_label setFont:[UIFont boldSystemFontOfSize:10]];
//        [t_label setTextColor:[UIColor whiteColor]];
//        [t_label setTextAlignment:NSTextAlignmentCenter];
//        [t_label setUserInteractionEnabled:NO];
//        [self addSubview:t_label];
//        [self setTitleLabel:t_label];
//        [t_label release];
        

        CGRect tframe = CGRectMake(0, 0, frame.size.width, frame.size.height);
        UIControl *texTouch = [[UIControl alloc] initWithFrame:tframe];
        [self addSubview:texTouch];
        [texTouch setTag:2];
        [self setItemControl:texTouch];
        
        [texTouch addTarget:self
                     action:@selector(clickButton:)
           forControlEvents:UIControlEventTouchUpInside];
        [texTouch addTarget:self
                     action:@selector(clickButton:)
           forControlEvents:UIControlEventTouchUpOutside];
        
        [self setSelected:NO];
    }
    return self;
}
-(void)setFrame:(CGRect)frame{
    self.titleLabel.frame = CGRectMake(18, 0, frame.size.width, frame.size.height);
    self.buttonIcon.frame = CGRectMake(frame.size.width/3 - 24 , 9, 36, 36);
    [super setFrame:frame];
}
- (void)setTitle:(NSString *)title {

    _title = title;
    [self.titleLabel setText:title];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        [self.bImageView setImage:self.bHeightImage];
        [self.buttonIcon setImage:self.heightImage];
//        [self.titleLabel setTextColor:[UIColor colorWithRGBRed:22 green:86 blue:138]];
    }else {
        [self.buttonIcon setImage:self.image];
        [self.bImageView setImage:self.bimage];
//        [self.titleLabel setTextColor:[UIColor whiteColor]];
    }
}

- (void)clickButton:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(CJUITabItem:willSelecteIndex:)]) {
        if ([self.delegate CJUITabItem:self willSelecteIndex:self.tag]) {
            [self setSelected:YES];
        }
    }
}

@end