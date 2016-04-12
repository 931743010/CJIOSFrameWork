//
//  NSString_Extensions.h
//  YSUseek
//
//  Created by mingzi on 14-11-3.
//  Copyright (c) 2014年 liming4343@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  NSString (NSString_Extensions)
//返回数字字母验证码
- (NSString *)verificationCode;
//返回数字验证码
+(NSString *)verificationnumberCode;
//计算时间差
- (NSString *)intervalSinceNow: (NSString *) theDate;

#pragma mark 验证输入手机号码是否正确
+ (BOOL)isMobileNumber:(NSString *)mobile;

- (NSString *) URLEncodedString;


- (NSString *)stringByTrimingWhitespace;


- (NSUInteger)numberOfLines;

//- (CGSize)textSizeWithFont:(UIFont *)font size:(CGSize)size;

@end


@interface NSString (LetterStyle)

//首字母小写
- (NSString *) firstLetterLowercase;

//首字母大写
- (NSString *) firstLetterCapital;

@end



@interface NSString (MTExtend)
- (NSString*)numberString;

/**
 判断uitextview输入内容是否是退格
 @returns BOOL
 */
- (BOOL)isSpaceBack;

/**
 删除字符串最后面的［*]内容
 @returns string
 */
- (NSString*)removeEndCharacter;

#pragma mark -
#pragma mark -获取到时间
+(NSString *)getDate:(NSTimeInterval)msgCreatTime;
@end