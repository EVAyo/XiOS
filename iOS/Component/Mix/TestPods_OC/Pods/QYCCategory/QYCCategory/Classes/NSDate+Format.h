//
//  AppDelegate.m
//  Category
//
//  Created by 钱立新 on 14/10/28.
//  Copyright © 2014年 钱立新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

/**
 根据 日期格式和时间样式获取时间

 @param dateStyle 日期格式
 @param timeStyle 时间样
 @return 获取时间
 */
- (NSString *)obtainStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

/**
 根据 日期格式获取时间文字

 @param format 日期格式
 @return 获取时间
 */
- (NSString *)obtainStringWithFormat:(NSString *)format;

/**
 根据字符串获取时间

 @param datestr 时间文字
 @param format 时间格式
 @return 时间
 */
+ (NSDate *)dateString:(NSString *)datestr withFormat:(NSString *)format;

/**
 比较当前时间是否小于指定时间格式YYYY-MM-dd HH:mm
 应付审 核机制需求，临时添加处理，营造可以面手机号面审核登陆场景
 
 @param datestr 指定时间，格式：YYYY-MM-dd HH:mm，eg: @"2020-08-28 00:00"
 @return 是否小于
*/
+ (BOOL)currentTimeEarlierSpecifiedTime:(NSString *)datestr;

@end
