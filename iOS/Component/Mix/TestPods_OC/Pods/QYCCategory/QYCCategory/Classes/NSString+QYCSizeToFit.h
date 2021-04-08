//
//  NSString+QYCSizeToFit.h
//  Qiyeyun
//
//  Created by dong on 2019/3/26.
//  Copyright © 2019年 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QYCSizeToFit)

/**
 calculateLabelSize

 @param text
 @param font
 @param fitSize
 @param numberOfLines
 @return
 */
+ (CGSize)qyc_calculateLabelSizeWithText:(NSString *)text
                                    font:(CGFloat)font
                                 fitSize:(CGSize)fitSize
                           numberOfLines:(NSInteger)numberOfLines;

+ (CGSize)qyc_calculateLabelSizeWithText:(NSString *)text;

+ (CGSize)qyc_calculateLabelSizeWithText:(NSString *)text font:(CGFloat)font;

+ (CGSize)qyc_calculateLabelSizeWithText:(NSString *)text font:(CGFloat)font fitSize:(CGSize)fitSize;

/**
 calculateButtonSize

 @param text
 @param font
 @param contentEdgeInsets
 @param imageEdgeInsets
 @return
 */
+ (CGSize)qyc_calculateButtonSizeWithText:(NSString *)text
                                     font:(CGFloat)font
                        contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                          imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;

+ (CGSize)qyc_calculateButtonSizeWithText:(NSString *)text;

+ (CGSize)qyc_calculateButtonSizeWithText:(NSString *)text font:(CGFloat)font;

+ (CGSize)qyc_calculateButtonSizeWithText:(NSString *)text font:(CGFloat)font contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets;

+ (CGSize)qyc_calculateButtonSizeWithText:(NSString *)text font:(CGFloat)font imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;

@end
