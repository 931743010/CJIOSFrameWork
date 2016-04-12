//
//  NSString_Extensions.m
//  YSUseek
//
//  Created by mingzi on 14-11-3.
//  Copyright (c) 2014年 liming4343@163.com. All rights reserved.
//

#import "NSString_Extensions.h"

@implementation NSString (NSString_Extensions)

- (NSString *) URLEncodedString {
    NSMutableString * output = [NSMutableString string];
    const char * source = [self UTF8String];
    int sourceLen = strlen(source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = (const unsigned char)source[i];
        if (false && thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.'|| thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}


- (NSString *)verificationCode
{
    NSArray *changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:5];
    
    NSMutableString *changeString = [[NSMutableString alloc] initWithCapacity:6];
    for(NSInteger i = 0; i < 6; i++)
    {
        NSInteger index = arc4random() % ([changeArray count] - 1);
        getStr = [changeArray objectAtIndex:index];
        
        changeString = (NSMutableString *)[changeString stringByAppendingString:getStr];
    }
    return changeString;
}

+(NSString *)verificationnumberCode
{
    NSArray *changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:5];
    
    NSMutableString *changeString = [[NSMutableString alloc] initWithCapacity:6];
    for(NSInteger i = 0; i < 6; i++)
    {
        NSInteger index = arc4random() % ([changeArray count] - 1);
        getStr = [changeArray objectAtIndex:index];
        
        changeString = (NSMutableString *)[changeString stringByAppendingString:getStr];
    }
    return changeString;
}

- (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSArray *timeArray=[theDate componentsSeparatedByString:@"."];
    theDate=[timeArray objectAtIndex:0];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=late-now;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"剩余%@分", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"剩余%@小时", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"剩余%@天", timeString];
        
    }
    return timeString;
}


#pragma mark 验证输入手机号码是否正确
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (NSString *)stringByTrimingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSUInteger)numberOfLines {
    return [[self componentsSeparatedByString:@"\n"] count] + 1;
}


//- (CGSize)textSizeWithFont:(UIFont *)font size:(CGSize)size
//{
//    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
//    CGSize  actualsize =[self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine |
//                         NSStringDrawingUsesLineFragmentOrigin |
//                         NSStringDrawingUsesFontLeading  attributes:tdic context:nil].size;
//    return actualsize;
//}

@end




@implementation NSString (LetterStyle)

- (NSString *) firstLetterLowercase
{
    NSString * result = [[self substringToIndex: 1] lowercaseString];
    if ( [self length] == 1 )
        return ( result );
    
    return ( [result stringByAppendingString: [self substringFromIndex: 1]] );
}


- (NSString *) firstLetterCapital
{
    NSString * result = [[self substringToIndex: 1] capitalizedString];
    if ( [self length] == 1 )
        return ( result );
    
    return ( [result stringByAppendingString: [self substringFromIndex: 1]] );
}

@end



@implementation NSString (MTExtend)
- (NSString*)numberString
{
    NSString *string = [self stringByReplacingOccurrencesOfString:@" "
                                                       withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"("
                                               withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")"
                                               withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"-"
                                               withString:@""];
    return string;
}

- (NSString*)removeEndCharacter {
    if ([self hasSuffix:@"]"]) {
        NSRange range = [self rangeOfString:@"[" options:NSBackwardsSearch];
        NSString *str = [self substringWithRange:NSMakeRange(0,range.location)];
        return str;
    }else {
        if (self.length ==0) {
            return self;
        }
        NSString *str = [self substringWithRange:NSMakeRange(0,self.length-1)];
        return str;
    }
}

- (BOOL)isSpaceBack {
    const char * _char = [self cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    if (isBackSpace == -8) {
        return YES;
    }
    return NO;
}

- (NSString*) decodeFromPercentEscapeString:(NSString *) string {
    return (__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                         (__bridge CFStringRef) string,
                                                                                         CFSTR(""),
                                                                                         kCFStringEncodingUTF8);
}

#pragma mark -
#pragma mark -获取到时间
+(NSString *)getDate:(NSTimeInterval)msgCreatTime
{
    
    NSString *strDataTime =nil;
    
    NSTimeInterval tmpTime;
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval secondsPerDay = msgCreatTime;
    
    NSDate *yesterday1 = [NSDate dateWithTimeIntervalSince1970:secondsPerDay];
    NSDate *yesterday2 = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSMutableString *timeString1 = [NSMutableString stringWithFormat:@"%@",[formatter stringFromDate:yesterday1]];
    NSMutableString *timeString2 = [NSMutableString stringWithFormat:@"%@",[formatter stringFromDate:yesterday2]];
    
    NSString *strData1 = timeString1;
    NSString *strData2 = timeString2;
    int data1 = [strData1 intValue];
    int data2 = [strData2 intValue];
    
    tmpTime = time - secondsPerDay;
    
    if ( tmpTime < 60) {
        strDataTime =@"刚刚";
    }
    else if(tmpTime < 60 * 30){
        strDataTime = [NSString stringWithFormat:@"%d分钟前",((int)tmpTime)/60];
    }
    else if(tmpTime < 24 * 60 * 60 && ((data2 - data1) == 0))
    {
        NSDate *yesterday = [NSDate dateWithTimeIntervalSince1970:secondsPerDay];
        NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        NSMutableString *timeString = [NSMutableString stringWithFormat:@"%@",[formatter stringFromDate:yesterday]];
        strDataTime = timeString;
    }
    else if(tmpTime < 48 * 60 * 60 && ((data2 - data1) == 1))
    {
        NSDate *yesterday = [NSDate dateWithTimeIntervalSince1970:secondsPerDay];
        NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        NSMutableString *timeString = [NSMutableString stringWithFormat:@"昨天%@",[formatter stringFromDate:yesterday]];
        strDataTime = timeString;
    }
    else if(tmpTime < 72* 60 *60 && ((data2 - data1) == 2))
    {
        NSDate *yesterday = [NSDate dateWithTimeIntervalSince1970:secondsPerDay];
        NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        NSMutableString *timeString = [NSMutableString stringWithFormat:@"前天%@",[formatter stringFromDate:yesterday]];
        strDataTime=timeString;
    }
    else
    {
        NSDate *yesterday = [NSDate dateWithTimeIntervalSince1970:secondsPerDay];
        NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSMutableString *timeString = [NSMutableString stringWithFormat:@"%@",[formatter stringFromDate:yesterday]];
        strDataTime = timeString;
    }
    return strDataTime;
}
@end

