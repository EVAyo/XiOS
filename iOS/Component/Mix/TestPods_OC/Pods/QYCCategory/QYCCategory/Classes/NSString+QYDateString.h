//
//  NSString+QYDateString.h
//  Qiyeyun
//
//  Created by dong on 2017/3/23.
//  Copyright © 2017年 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 时间转化
@interface NSString (QYDateString)

/**获取时间，
 时间是今天的显示 时-分
 时间是昨天的显示 昨天 时-分
 时间是今年的显示 月-日 时-分
 时间不是今年显示 年-月-日 时-分
 
 dateString 格式为 yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)qy_dateFromWithDateString:(NSString *)dateString;

//时间戳转固定格式(具体格式同上)
+ (NSString *)qy_dateFromWithTime:(NSTimeInterval)secs;

/**获取时间，
 时间是今年的显示 月-日
 时间不是今年显示 年-月-日
 
 secs 时间搓（10位）
 */
+ (NSString *)qy_dayMonthFromWithTime:(NSTimeInterval)secs;

/**
*  将阿拉伯数字（本周几或者本月几号）转化成时间字符串
*
*  @param type  要转化的类型（周tsweek  月tsmonth）
*  @param value 阿拉伯数值
*
*  @return 对应的时间字符串
*/
+ (NSString *)getStringFormType:(NSString *)type AndValue:(NSString *)value;

@end
