//
//  UILabel+QYCDynamicHeight.h
//  Qiyeyun
//
//  Created by dong on 2017/4/24.
//  Copyright © 2017年 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (QYCDynamicHeight)

/**
 动态获取label的尺寸

 @param NSMutableAttributedString  文本（内容不能为空，否则报错）
 @param containerViewSize label高度
 @return 动态的高度
 */
+ (CGSize)qyc_dynamicHeightWithString:(NSMutableAttributedString *)string containerViewSize:(CGSize)containerViewSize;

/**
 动态获取label的尺寸

 @param NSAttributedString  文本（内容不能为空，否则报错）
 @param containerViewSize label大小
 @param lines 几行
 @return 动态的大小
 */
+ (CGSize)qyc_dynamicHeightWithString:(NSAttributedString *)string containerViewSize:(CGSize)containerViewSize numberOfLines:(NSInteger)lines;



/**
动态获取label的尺寸

@param text  文本
@param font  字体大小
@param containerViewSize label大小
@return 动态的大小
*/
+ (CGSize)qyc_dynamicHeightWithLabelText:(NSString *)text textFont:(CGFloat)font containerViewSize:(CGSize)containerViewSize;


/**
动态获取label的尺寸

@param text  文本
@param font  字体大小
@param containerViewSize label大小
@param lines 几行
@return 动态的大小
*/
+ (CGSize)qyc_dynamicHeightWithLabelText:(NSString *)text textFont:(CGFloat)font containerViewSize:(CGSize)containerViewSize numberOfLines:(NSInteger)lines;


@end
