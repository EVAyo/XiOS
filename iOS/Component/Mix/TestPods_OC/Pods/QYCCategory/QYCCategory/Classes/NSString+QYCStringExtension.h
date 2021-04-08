//
//  NSString+QYCStringExtension.h
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/9/7.
//  Copyright © 2020 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 字符串处理分类
@interface NSString (QYCStringExtension)

/**
 过滤掉文本中空白行
 */
+ (NSString *)filterVoidLine:(NSString *)string;
/**
 过滤掉文本中所有换行
 */
+ (NSString *)filterAllVoidLine:(NSString *)string;

///  用另外的字符过滤掉文本中所有换行
/// @param string <#string description#>
/// @param replace <#replace description#>
+ (NSString *)filterAllVoidLine:(NSString *)string withReplace:(NSString *)replace;

@end

NS_ASSUME_NONNULL_END
