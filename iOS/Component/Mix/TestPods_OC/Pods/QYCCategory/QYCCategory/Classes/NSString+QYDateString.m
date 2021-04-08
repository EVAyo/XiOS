//
//  NSString+QYDateString.m
//  Qiyeyun
//
//  Created by dong on 2017/3/23.
//  Copyright © 2017年 安元. All rights reserved.
//

#import "NSString+QYDateString.h"

@implementation NSString (QYDateString)

+ (NSString *)qy_dateFromWithDateString:(NSString *)dateString {
    if (![dateString isKindOfClass:[NSString class]])
        return @"";
    NSString *dateStr;
    /**创建时间的处理*/
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *createTime = [dateFormatter dateFromString:dateString];

    if ([self isToday:createTime]) {
        dateStr = [self stringWithFormat:@"HH:mm" date:createTime];
    }
    else if ([self isYesterday:createTime]) {
        dateStr = [NSString stringWithFormat:@"昨天 %@", [self stringWithFormat:@"HH:mm" date:createTime]];
    }
    else if ([self year:createTime] == [self year:[NSDate date]]) {
        dateStr = [self stringWithFormat:@"MM-dd HH:mm" date:createTime];
    }
    else {
        dateStr = [self stringWithFormat:@"yyyy-MM-dd HH:mm" date:createTime];
    }
    return dateStr;
}

+ (NSString *)qy_dateFromWithTime:(NSTimeInterval)secs {
    NSDate *createTime = [NSDate dateWithTimeIntervalSince1970:secs];
    NSString *dateStr;
    if ([self isToday:createTime]) {
        dateStr = [self stringWithFormat:@"HH:mm" date:createTime];
    }
    else if ([self isYesterday:createTime]) {
        dateStr = [NSString stringWithFormat:@"昨天 %@", [self stringWithFormat:@"HH:mm" date:createTime]];
    }
    else if ([self year:createTime] == [self year:[NSDate date]]) {
        dateStr = [self stringWithFormat:@"MM-dd HH:mm" date:createTime];
    }
    else {
        dateStr = [self stringWithFormat:@"yyyy-MM-dd HH:mm" date:createTime];
    }
    return dateStr;
}

+ (NSString *)stringWithFormat:(NSString *)format date:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:date];
}
+ (NSInteger)year:(NSDate *)date {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date] year];
}
+ (BOOL)isToday:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit             = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;

    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];

    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:date];

    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}
/**
 *  是否为昨天
 */
+ (BOOL)isYesterday:(NSDate *)date {
    // 2014-10-28
    NSDate *nowDate = [self dateWithYMD:[NSDate date]];

    // 2014-10-27
    NSDate *selfDate = [self dateWithYMD:date];

    // 获得nowDate和selfDate的差距
    NSCalendar *calendar   = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

+ (NSDate *)dateWithYMD:(NSDate *)date {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat       = @"yyyy-MM-dd";
    NSString *selfStr    = [fmt stringFromDate:date];
    return [fmt dateFromString:selfStr];
}

+ (NSString *)qy_dayMonthFromWithTime:(NSTimeInterval)secs {
    NSDate *createTime = [NSDate dateWithTimeIntervalSince1970:secs];
    NSString *dateStr;
    if ([self year:createTime] == [self year:[NSDate date]]) {
        dateStr = [self stringWithFormat:@"MM-dd" date:createTime];
    }
    else {
        dateStr = [self stringWithFormat:@"yyyy-MM-dd" date:createTime];
    }
    return dateStr;
}

//将阿拉伯数字（本周几或者本月几号）转化成时间字符串
+ (NSString *)getStringFormType:(NSString *)type AndValue:(NSString *)value {
    NSDate *today                = [NSDate date];
    NSCalendar *gregorian        = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:today];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormat.locale = [NSLocale currentLocale];

    NSString *result;
    if ([type isEqualToString:@"tsmonth"]) {
        components.day     = value.integerValue;
        NSDate *relustDate = [gregorian dateFromComponents:components];
        result             = [dateFormat stringFromDate:relustDate];
    }
    if ([type isEqualToString:@"tsweek"]) {
        NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:today] weekday]; // 得到今天在这周的位子（如今天周六，得到的是7）周日是1
        if (dayofweek == 1)
            dayofweek = 8;

        NSArray *weekArr = @[ @"1", @"2", @"3", @"4", @"5", @"6", @"7" ];

        NSInteger index    = [weekArr indexOfObject:value];
        components.day     = (components.day - (dayofweek - 2)) + index;
        NSDate *relustDate = [gregorian dateFromComponents:components];
        result             = [dateFormat stringFromDate:relustDate];
    }

    return result;
}

@end
