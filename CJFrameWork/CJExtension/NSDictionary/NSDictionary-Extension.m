//
//  NSDictionary+Unit.m
//  Footter 3
//
//  Created by mingzi on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary-Extension.h"
@implementation NSDictionary (Extension)


#pragma mark 返回带默认值接口
- (id)boolValueForKey:(NSString *)key {
    id rs = [self valueForKey:key];
    return @([rs boolValue]);
}

- (id)valueForKey:(NSString*)key defaults:(id)defaults {
    id rs = [self valueForKey:key];
    if (rs && ![rs isKindOfClass:[NSNull class]]) {
        if ([defaults isKindOfClass:[NSNumber class]]) {
            if ([rs isKindOfClass:[NSNumber class]]) {
                return rs;
            }else if([rs isKindOfClass:[NSString class]]) {
                return @([rs longLongValue]);
            }
            return defaults;
        }else if ([rs isKindOfClass:[NSString class]] && [(NSString*)rs isEqualToString:@"<null>"]) {
            return defaults;
        }
        return rs;
    }
    return defaults;
}

- (id)valueForKeyPath:(NSString*)key defaults:(id)defaults {
    id rs = [self valueForKeyPath:key];
    if (rs && ![rs isKindOfClass:[NSNull class]]) {
        if ([defaults isKindOfClass:[NSNumber class]]) {
            return @([rs longLongValue]);
        }else if ([rs isKindOfClass:[NSString class]] && [(NSString*)rs isEqualToString:@"<null>"]) {
            return defaults;
        }
        return rs;
    }
    return defaults;
}
#pragma mark 返回 item=1,item3=2 or item=i AND item=0;
- (NSString *)componentsJoinedByString:(NSString *)string space:(NSString *)sapce  {
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:1];
    for (NSString *key in self) {
        id value = [self valueForKey:key];
        NSString *str = nil;
        if ([value isKindOfClass:[NSString class]]) {
            str = [NSString stringWithFormat:@"%@%@\"%@\"",key,string,value];
        }else {
            str = [NSString stringWithFormat:@"%@%@\%@",key,string,value];
        }
        
        [items addObject:str];
    }
    return [items componentsJoinedByString:sapce];;
}

-(NSMutableDictionary *)mutableDeepCopy
{
    NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithCapacity:self.count];
    NSArray *keys = [self allKeys];
    for (id key in keys)
    {
        id oneValue = [self valueForKey:key];
        
        id oneCopy = nil;
        
        if ([oneValue respondsToSelector:@selector(mutableDeepCopy)])
            oneCopy = [oneValue mutableDeepCopy];
        
        else if ([oneValue respondsToSelector:@selector(mutableCopy)])
            oneCopy = [oneValue mutableCopy];
        
        if (oneCopy == nil)
            oneCopy = [oneValue copy];  
        
        [ret setValue:oneCopy forKey:key];
    }
    return ret;
}

- (NSArray *)arrayValueForKey:(NSString *)key {
    id value = [self valueForKey:key];
    if (value) {
        if (![value isKindOfClass:[NSArray class]]) {
            return [NSArray arrayWithObject:value];
        }
        return value;
    }
    return nil;
}

- (NSArray *)arrayValueForKeyPath:(NSString *)keyPath {
    id value = [self valueForKeyPath:keyPath];
    if (value) {
        if (![value isKindOfClass:[NSArray class]]) {
            
            if ([value isKindOfClass:[NSNull class]]) {
                return nil;
            }
            
            if ([value isEqualToString:@""]) {
                return nil;
            }
            
            return [NSArray arrayWithObject:value];
        }
        return value;
    }
    return nil;
}

-(NSString *)returnZHParams
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}

@end


@implementation  NSMutableDictionary(Extension)

- (void)setBoolValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        [self setValue:@([value boolValue]) forKey:key];
    }else {
        [self setValue:@(0) forKey:key];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key defaults:(id)defaults {
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        return;
    }else  {
        if ([defaults isKindOfClass:[NSString class]] &&
            [value isKindOfClass:[NSString class]] && 
            [(NSString *)value isEqualToString:defaults]) {
            return;
        }
        
        if ([defaults isKindOfClass:[NSNumber class]] && 
            [value isKindOfClass:[NSNumber class]] &&
            [(NSNumber *)defaults compare:value] == NSOrderedSame ) {
            return;
        }
    
        [self setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key forDefaults:(id)defaults {
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        if (defaults && ![defaults isKindOfClass:[NSNull class]]) {
            value = defaults;
        }
    }
    [self setValue:value forKey:key];
}
@end