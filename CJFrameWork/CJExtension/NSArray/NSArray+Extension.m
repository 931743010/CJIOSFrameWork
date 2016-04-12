//
//  NSArray+Extension.m
//  Useek
//
//  Created by mingzi on 12-11-16.
//  Copyright (c) 2012年 mingzi. All rights reserved.
//

#import "NSArray+Extension.h"

#define ARRAY_ROW(i,c) ((i+1)/c + (((i+1)%c)>0?1:0)) - 1

@implementation NSArray (Extension)
- (id)objectAtIndex:(NSUInteger)index defaults:(id)defaults {
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return defaults;
}

- (NSArray *)safeSubarrayWithRange:(NSRange)range {
    if (self.count < (range.location + range.length)) {
        if (range.location > (self.count-1)) {
            return nil;
        }else {
            NSInteger length = self.count - range.location;
            return [self subarrayWithRange:NSMakeRange(range.location, length)];
        }
    }
    return [self subarrayWithRange:range];
}

- (NSArray *)arrayGroupWithItemCount:(NSInteger)count {
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
    if (count < self.count) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSInteger row = ARRAY_ROW(idx, count);
            NSMutableArray *item = [items objectAtIndex:row defaults:nil];
            if (item == nil) {
                item = [NSMutableArray arrayWithCapacity:0];
                [items addObject:item];
            }
            [item addObject:obj];
        }];
    }else {
        NSMutableArray *item = [NSMutableArray arrayWithArray:self];
        [items addObject:item];
    }
    return items;
}
@end

@implementation NSMutableArray(Extension)
- (void)addObjectForNil:(id)obj {
    if (obj) {
        [self addObject:obj];
    }
}

- (NSArray *)arrayGroupWithItemCount:(NSInteger)count {
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
    if (count < self.count) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSInteger row = ARRAY_ROW(idx, count);
            NSMutableArray *item = [items objectAtIndex:row defaults:nil];
            if (item == nil) {
                item = [NSMutableArray arrayWithCapacity:0];
                [items addObject:item];
            }
            [item addObject:obj];
        }];
    }else {
        NSMutableArray *item = [NSMutableArray arrayWithArray:self];
        [items addObject:item];
    }
    return items;
}
@end
