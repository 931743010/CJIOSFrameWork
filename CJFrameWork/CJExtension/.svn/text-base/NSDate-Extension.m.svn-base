//
//  DateUtil.m
//  Useek
//
//  Created by Eric Li on 11-3-1.
//  Copyright 2011 Active. All rights reserved.
//

#import "NSDate-Extension.h"

@implementation NSDate (FoxExtension)
+ (NSInteger) daysBetweenDateFrom:(NSDate *)fromDate to:(NSDate*)toDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	NSDateComponents *fyearComp  = [calendar components:NSYearCalendarUnit fromDate:fromDate];
	NSDateComponents *fMonthComp = [calendar components:NSMonthCalendarUnit fromDate:fromDate];
	NSDateComponents *fDayComp   = [calendar components:NSDayCalendarUnit fromDate:fromDate];
	
	NSDateComponents *tyearComp  = [calendar components:NSYearCalendarUnit fromDate:toDate];
	NSDateComponents *tMonthComp = [calendar components:NSMonthCalendarUnit fromDate:toDate];
	NSDateComponents *tDayComp   = [calendar components:NSDayCalendarUnit fromDate:toDate];

	NSInteger fyear  = [fyearComp year];
	NSInteger fmonth = [fMonthComp month];
	NSInteger fday   = [fDayComp day];
	
	NSInteger tyear  = [tyearComp year];
	NSInteger tmonth = [tMonthComp month];
	NSInteger tday   = [tDayComp day];
	
	NSInteger year;
	NSInteger month;
	NSInteger day;
	
	NSInteger i, c1=0, c2=0, t1, t2;
	int m[13]={31,28,31,30,31,30,31,31,30,31,30,31};

	for(i=fyear; i<=tyear; i++)
		if ((i%4==0 && i%100!=0)|| i%400==0) c2++;//记录d2闰年个数	
	year = fyear - tyear;
	
	for(i=0,t1=0; i<fmonth-1; i++)
		t1 += m[i];
	
	for(i=0,t2=0; i<tmonth-1; i++)
		t2 += m[i];
	
	month = 0;
	day = t1 - t2 + c1 - c2 + fday - tday;
	
	if (((fyear%4==0 && fyear%100!=0 ) || fyear%400==0) && (fyear==tyear) && (fmonth>=3) && (tmonth<3))
        day = day + 1;  //修正天数
    
	NSInteger sub = year*365 + month*30 + day;
	if (sub<0) sub=sub*(-1);
	
	return sub;
}


+ (NSString *) daysBetweenDateFrom:(NSString *)dateStr {
    NSDate *fromeDate = [NSDate dateInitWithString:dateStr];
    NSDate *currentDate = [NSDate date];

    NSTimeInterval late=[fromeDate timeIntervalSince1970]*1;
    NSTimeInterval now=[currentDate timeIntervalSince1970]*1;
    
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    if (cha<=60.0) {
        return @"1 m";
    }
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60.0];
        timeString = [timeString substringToIndex:(timeString.length-7)];
        timeString = [NSString stringWithFormat:@"%@ m", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:(timeString.length-7)];
        timeString = [NSString stringWithFormat:@"%@ h", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:(timeString.length-7)];
        timeString = [NSString stringWithFormat:@"%@ d", timeString];
        
    }
    
    return timeString;
}

+ (NSDate *)dateInitNow { 
    NSDate *currentDate = [NSDate date];	
	NSInteger timeZone = [[NSTimeZone localTimeZone] secondsFromGMTForDate:currentDate];	
	NSInteger dValue = timeZone - 28800;
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:dValue];
	return date;
}

+ (NSDate*)dateInitWithString:(NSString *)string {  
    NSString *str;
	NSUInteger len = [string length];
	if (len == 13) {
		NSRange ran = NSMakeRange(0, len-3);
		str = [string substringWithRange:ran];
	}else {
		str = string;
	}	
	NSDate *currentDate = [NSDate date];	
	NSInteger timeZone = [[NSTimeZone localTimeZone] secondsFromGMTForDate:currentDate];	
	NSInteger dValue = timeZone - 28800;
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:[str longLongValue]+dValue];
	return date;
}


-(NSString *) formatDate:(NSString*)format 
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:format];
	NSString *temp = [dateFormatter stringFromDate:self];
	return temp;
}

#pragma mark -
#pragma mark 获取当前时间的毫秒数
- (NSString *)currentMilliSecond
{
	NSInteger timeZone = [[NSTimeZone localTimeZone] secondsFromGMTForDate:self];
	NSInteger dValue = timeZone - 28800;
	NSTimeInterval curSec = [self timeIntervalSince1970];
	NSTimeInterval chinaTime = curSec - dValue;  
	NSString *resultDateStr = [[NSString stringWithFormat:@"%.3f", chinaTime] 
                                        stringByReplacingOccurrencesOfString:@"." withString:@""];	
	return resultDateStr;
}

+ (NSString *) currentMilliSecond {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];    
    return [date currentMilliSecond];
}

+ (NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds{
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000;
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

- (NSString*)localDateStringForISODateTimeString:(NSString*)ISOString
{
    // Configure the ISO formatter
    NSDateFormatter* isoDateFormatter = [[NSDateFormatter alloc] init];
    [isoDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    [isoDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    // Configure user local formatter (configure this for how you want
    // your user to see the date string)
    NSDateFormatter* userFormatter = [[NSDateFormatter alloc] init];
    [userFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // Convert the string -- this date can now also just be used
    // as the correct date object for other calculations and/or
    // comparisons
    NSDate* date = [isoDateFormatter dateFromString:ISOString];
    
    // Return the string in the user's locale and time zone
    return [userFormatter stringFromDate:date];
}

+ (NSDate *)getGMTTimeFromMilliSeconds:(long long) miliSeconds {
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000;
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date1];
    return [date1  dateByAddingTimeInterval:interval];
}

+ (long long)getDateTimeTOMilliSeconds:(NSDate *)datetime{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    long long totalMilliseconds = interval*1000 ;
    return totalMilliseconds;
}

+ (NSInteger )secBetweenDateFrom:(NSDate *)fromDate to:(NSDate*)toDate {
    return [fromDate timeIntervalSinceDate:toDate];
}

+ (NSString *)currentUTCSecond
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
    return [NSString stringWithFormat:@"%llu",dTime];
}

+ (NSInteger )diffSecond:(long long)fsecond to:(long long)tsecond {
    NSDate *date1 = [NSDate getDateTimeFromMilliSeconds:fsecond];
    NSDate *date2 = [NSDate getDateTimeFromMilliSeconds:tsecond];
    return [date1 timeIntervalSinceDate:date2];
}
@end

@implementation NSDate (ext)
+ (NSDate *)UTCWithDate:(NSDate *)date {
    NSTimeZone* utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
    NSDate*destinationDate = [[NSDate alloc] initWithTimeInterval:gmtOffset
                                                         sinceDate:date];
    return destinationDate;
}

+ (NSDate *)GMTWithDate:(NSDate *)date {
    NSTimeZone* currentTimeZone = [NSTimeZone localTimeZone];
    NSTimeInterval gmtInterval = [currentTimeZone secondsFromGMTForDate:date];
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date];
    return destinationDate;
}

+ (long long)milliSecondsWithDate:(NSDate *)date {
    NSTimeInterval interval = [date timeIntervalSince1970];
    long long totalMilliseconds = interval*1000;
    return totalMilliseconds;
}

+ (NSDate *)dateForMilliSeconds:(long long)miliSeconds {
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000;
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

+ (NSString *)localUTCSeconds {
    NSDate *utcDate = [NSDate UTCWithDate:[NSDate date]];
    long long millseconde = [NSDate milliSecondsWithDate:utcDate];
    return [NSString stringWithFormat:@"%lld", millseconde];
}
@end


@implementation NSDate (xdate)
+ (NSString *)timestamp {
    NSDate *datenow = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    return [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
}

+ (NSDate *)dateWithTimestamp:(NSString *)timestamp {
    return [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue]];
}
@end

