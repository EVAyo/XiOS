//
//  UILabel+QYCDynamicHeight.m
//  Qiyeyun
//
//  Created by dong on 2017/4/24.
//  Copyright © 2017年 安元. All rights reserved.
//

#import "UILabel+QYCDynamicHeight.h"

@implementation UILabel (QYCDynamicHeight)

+ (CGSize)qyc_dynamicHeightWithString:(NSMutableAttributedString *)string containerViewSize:(CGSize)containerViewSize{

    CGSize size = [UILabel qyc_dynamicHeightWithString:string containerViewSize:containerViewSize numberOfLines:0];
    return size;
}

+ (CGSize)qyc_dynamicHeightWithString:(NSAttributedString *)string containerViewSize:(CGSize)containerViewSize numberOfLines:(NSInteger)lines {
    if (!string || string.length == 0) {
        NSParameterAssert(@"string为空");
        return CGSizeZero;
    }

    CGSize size;
    UILabel *label       = [[UILabel alloc] init];
    label.numberOfLines  = lines;
    label.attributedText = string;
    size                 = [label sizeThatFits:containerViewSize];
    return size;
}



+ (CGSize)qyc_dynamicHeightWithLabelText:(NSString *)text textFont:(CGFloat)font containerViewSize:(CGSize)containerViewSize {
    
    CGSize size = [UILabel qyc_dynamicHeightWithLabelText:text textFont:font containerViewSize:containerViewSize numberOfLines:0];
    return size;
}



+ (CGSize)qyc_dynamicHeightWithLabelText:(NSString *)text textFont:(CGFloat)font containerViewSize:(CGSize)containerViewSize numberOfLines:(NSInteger)lines {
    if (!text || text.length == 0) {
        NSParameterAssert(@"string为空");
        return CGSizeZero;
    }
    CGSize size;
    UILabel *label       = [[UILabel alloc] init];
    label.numberOfLines  = lines;
    label.text           = text;
    label.font           = [UIFont systemFontOfSize:font];
    size                 = [label sizeThatFits:containerViewSize];
    return size;
}


@end
