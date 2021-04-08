//
//  AppDelegate.m
//  Category
//
//  Created by 钱立新 on 14/10/28.
//  Copyright © 2014年 钱立新. All rights reserved.
//

#import "NSDate+Format.h"

@implementation NSDate (Format)
/**
 *  是否为今天
 */
- (BOOL)isToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit             = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;

    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];

    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];

    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday {
    // 2014-10-28
    NSDate *nowDate = [[NSDate date] dateWithYMD];

    // 2014-10-27
    NSDate *selfDate = [self dateWithYMD];

    // 获得nowDate和selfDate的差距
    NSCalendar *calendar   = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (NSDate *)dateWithYMD {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat       = @"yyyy-MM-dd";
    NSString *selfStr    = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit             = NSCalendarUnitYear;

    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];

    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];

    return nowCmps.year == selfCmps.year;
}

- (NSDateComponents *)deltaWithNow {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit             = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

- (NSString *)obtainStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle        = dateStyle;
    formatter.timeStyle        = timeStyle;
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}
- (NSString *)obtainStringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat       = format;
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateString:(NSString *)datestr withFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:datestr];
    return date;
}

+ (BOOL)currentTimeEarlierSpecifiedTime:(NSString *)datestr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    //string转date
    NSDate *laterdate = [self dateString:datestr withFormat:@"YYYY-MM-dd HH:mm"];
    
    //判断某个时间是否大于当前时间
    if([laterdate laterDate:[NSDate date]] == laterdate) {
        return YES;
    }
    return NO;
}

@end
