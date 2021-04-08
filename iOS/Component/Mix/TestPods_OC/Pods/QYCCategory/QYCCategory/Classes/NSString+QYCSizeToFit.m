//
//  NSString+QYCSizeToFit.m
//  Qiyeyun
//
//  Created by dong on 2019/3/26.
//  Copyright © 2019年 安元. All rights reserved.
//

#import "NSString+QYCSizeToFit.h"

@implementation NSString (QYCSizeToFit)
#pragma mark - label
+ (CGSize)qyc_calculateLabelSizeWithText:(NSString *)text {
    return [self qyc_calculateLabelSizeWithText:text font:17.f];
}

+ (CGSize)qyc_calculateLabelSizeWithText:(NSString *)text
                                    font:(CGFloat)font {
    return [self qyc_calculateLabelSizeWithText:text font:font fitSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

+ (CGSize)qyc_calculateLabelSizeWithText:(NSString *)text
                                    font:(CGFloat)font
                                 fitSize:(CGSize)fitSize {
    return [self qyc_calculateLabelSizeWithText:text font:font fitSize:fitSize numberOfLines:1];
}

+ (CGSize)qyc_calculateLabelSizeWithText:(NSString *)text
                                    font:(CGFloat)font
                                 fitSize:(CGSize)fitSize
                           numberOfLines:(NSInteger)numberOfLines {
    UILabel *label      = [[UILabel alloc] init];
    label.font          = [UIFont systemFontOfSize:font];
    label.text          = text;
    label.numberOfLines = numberOfLines;
    return [label sizeThatFits:fitSize];
}

#pragma mark - button

+ (CGSize)qyc_calculateButtonSizeWithText:(NSString *)text font:(CGFloat)font contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    if (text.length > 50) {
    //        text = [text substringToIndex:50];
    //    }
    //    if ([text containsString:@"\n"]) {
    //
    //    }
    //    NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:text];
    //    [mutableStr repla]
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font          = [UIFont systemFontOfSize:font];
    btn.titleLabel.numberOfLines = 1;
    [btn setContentEdgeInsets:contentEdgeInsets];
    [btn setImageEdgeInsets:imageEdgeInsets];
    CGSize size = [btn sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    return size;
}

+ (CGSize)qyc_calculateButtonSizeWithText:(NSString *)text {
    return [self qyc_calculateLabelSizeWithText:text font:17];
}
+ (CGSize)qyc_calculateButtonSizeWithText:(NSString *)text
                                     font:(CGFloat)font {
    return [self qyc_calculateButtonSizeWithText:text font:font contentEdgeInsets:UIEdgeInsetsZero imageEdgeInsets:UIEdgeInsetsZero];
}
+ (CGSize)qyc_calculateButtonSizeWithText:(NSString *)text font:(CGFloat)font imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    return [self qyc_calculateButtonSizeWithText:text font:font contentEdgeInsets:UIEdgeInsetsZero imageEdgeInsets:imageEdgeInsets];
}
+ (CGSize)qyc_calculateButtonSizeWithText:(NSString *)text font:(CGFloat)font contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    return [self qyc_calculateButtonSizeWithText:text font:font contentEdgeInsets:contentEdgeInsets imageEdgeInsets:UIEdgeInsetsZero];
}

@end
