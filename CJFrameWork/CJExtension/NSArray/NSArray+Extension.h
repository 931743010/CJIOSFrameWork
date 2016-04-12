//
//  NSArray+Extension.h
//  Useek
//
//  Created by mingzi on 12-11-16.
//  Copyright (c) 2012年 mingzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)
- (id)objectAtIndex:(NSUInteger)index defaults:(id)defaults;
- (NSArray *)safeSubarrayWithRange:(NSRange)range;

//分组
- (NSArray *)arrayGroupWithItemCount:(NSInteger)count;
@end


@interface NSMutableArray (Extension)
- (void)addObjectForNil:(id)obj;
//分组
- (NSArray *)arrayGroupWithItemCount:(NSInteger)count;
@end