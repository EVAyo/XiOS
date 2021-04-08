//
//  NSString+Regular.h
//  Category
//
//  Created by 钱立新 on 14/10/28.
//  Copyright © 2014年 钱立新. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 正则验证
@interface NSString (Regular)

/**
 邮箱符合性验证
 */
- (BOOL)isValidateEmail;

/**
 邮箱是否全是数字
 */
- (BOOL)isNumber;

/**
 是否包含数字
 */
- (BOOL)containNumber;

/**
 验证英文字母
 */
- (BOOL)isEnglishWords;

/**
 是否包含字母
 */
- (BOOL)containEnglishWords;

/**
 是否包含特殊字符（除数字、字母以外的字符）
 */
- (BOOL)containSpecialChar;

/**
 验证密码：8—16位，只能包含字符、数字和 下划线
 */
- (BOOL)isValidatePassword;

/**
 验证是否为汉字
 */
- (BOOL)isChineseWords;

/**
 验证是否为网络链接
 */
- (BOOL)isInternetUrl;

/**
 是否包含网络连接
 */
- (BOOL)containsInternetUrl:(NSString *)str;

/**
 验证是否为电话号码。正确格式为：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX
 */
- (BOOL)isPhoneNumber;

/**
 判断是否为11位的数字
 */
- (BOOL)isElevenDigitNum;

/**
 验证15或18位身份证
 */
- (BOOL)isIdentifyCardNumber;

/**
 验证手机号（不包含170段）
 */
- (BOOL)isValidateMobile;

/**
 验证手机号（包含170段）
 */
- (BOOL)isMobileNumberClassification;

/**
 清除字符串中特定形式（正则匹配）字符串

 @param regular 正则表达式
 @param text 原字符串
 @return 处理后的字符串
 */
+ (NSMutableString *)removeSpecificStringWithRegular:(NSString *)regular from:(NSMutableString *)text;

/**
 获取给定字符串中的url
 @param string 给定的字符串
 @return 获取到的链接字符串
 @discussion 如果字符串中含有链接但不是http开头的话，在返回的结果中默认添加了http://
 */
+ (NSArray *)urlFromString:(NSString *)string;

@end
