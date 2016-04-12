//
//  NSDictionary+Unit.h
//  Footter 3
//
//  Created by mingzi on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)


- (id)boolValueForKey:(NSString *)key;
- (id)valueForKey:(NSString*)key defaults:(id)defaults;

- (id)valueForKeyPath:(NSString*)keyPath defaults:(id)defaults;

/**
	返回数据结构数据
	@param key 键值
	@returns NSArray
 */
- (NSArray *)arrayValueForKey:(NSString *)key;

/**
 返回数据结构数据
 @param keyPath 键值
 @returns NSArray
 */
- (NSArray *)arrayValueForKeyPath:(NSString *)keyPath;

- (NSString *)componentsJoinedByString:(NSString *)string
                                 space:(NSString *)sapce;

- (NSMutableDictionary *)mutableDeepCopy;
//字典转字符串
-(NSString *)returnZHParams;
@end


@interface  NSMutableDictionary(Extension)
/**
	设置NSMutableDictionary数据
	@param value 写入值
	@param key 键值
	@param defaults 当value == defaults 时 不写入
 */
- (void)setValue:(id)value forKey:(NSString *)key defaults:(id)defaults;

/**
	设置NSMutableDictionary数据
	@param value value 写入值
	@param key key 键值
	@param defaults 当value == nil 时 写入defaults
 */
- (void)setValue:(id)value forKey:(NSString *)key forDefaults:(id)defaults;

- (void)setBoolValue:(id)value forKey:(NSString *)key;
@end

 