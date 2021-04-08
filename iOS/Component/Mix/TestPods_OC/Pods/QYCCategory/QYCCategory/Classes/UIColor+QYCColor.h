//
//  UIColor+QYCColor.h
//  Qiyeyun
//
//  Created by 钱立新 on 2020/3/19.
//  Copyright © 2020 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 适配暗黑模式   lightColorStr：白天模式颜色  darkColorStr：暗黑模式颜色
Create UIColor with a hex string.

Valid format: #RRGGBB 0xRRGGBB, RRGGBB
The `#` or "0x" sign is not required.
*/
#ifndef KQYCColor
#define KQYCColor(_lightHex_, _darkHex_) [UIColor lightColorStr:(__bridge NSString *)CFSTR(#_lightHex_) darkColorStr:(__bridge NSString *)CFSTR(#_darkHex_)]
#endif
#ifndef KQYCColorStr
#define KQYCColorStr(lightHex, darkHex) [UIColor lightColorStr:lightHex darkColorStr:darkHex]
#endif

#ifndef KQYCColorValue
#define KQYCColorValue(_lightColor_, _darkColor_) [UIColor lightColor:_lightColor_ darkColor:_darkColor_]
#endif

#ifndef KQYCColorAlpha
#define KQYCColorAlpha(_lightHex_, al, _darkHex_, ad) [UIColor lightColorStr:(__bridge NSString *)CFSTR(#_lightHex_) WithLightColorAlpha:al darkColor:(__bridge NSString *)CFSTR(#_darkHex_) WithDarkColorAlpha:ad]
#endif
NS_ASSUME_NONNULL_BEGIN

@interface UIColor (QYCColor)

/**
动态颜色设置

 @param lightColor  普通模式颜色
 @param darkColor  暗黑模式颜色
 @return 修正后的颜色
 
 @discussion iOS13 一下版本，优先取lightColor，没有在获取darkColor，在没有直接返回UIColor.clearColor
 
*/
+ (UIColor *)lightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

/**
 适配暗黑模式颜色   颜色传入的是16进制字符串  支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 
  @param lightColorStr 普通模式颜色
  @param darkColorStr 暗黑模式颜色
  @return 暗黑模式颜色
 
  @discussion iOS13 一下版本，优先取lightColor，没有在获取darkColor，在没有直接返回UIColor.clearColor
*/
+ (UIColor *)lightColorStr:(NSString *)lightColorStr darkColorStr:(NSString *)darkColorStr;

/**
 适配暗黑模式颜色   颜色传入的是16进制字符串 还有颜色的透明度
 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 
 @param lightColor 普通模式颜色
 @param lightAlpha 普通模式颜色透明度
 @param darkColor 暗黑模式颜色透明度
 @param darkAlpha 暗黑模式颜色
 @return 暗黑模式颜色
 
 @discussion iOS13 一下版本，优先取lightColor，没有在获取darkColor，在没有直接返回UIColor.clearColor
*/
+ (UIColor *)lightColorStr:(NSString *)lightColor WithLightColorAlpha:(CGFloat)lightAlpha darkColor:(NSString *)darkColor WithDarkColorAlpha:(CGFloat)darkAlpha;

@end

NS_ASSUME_NONNULL_END
