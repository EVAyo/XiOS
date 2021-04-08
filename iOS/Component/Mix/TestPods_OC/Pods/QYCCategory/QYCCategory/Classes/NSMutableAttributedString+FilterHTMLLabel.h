//
//  NSMutableAttributedString+FilterHTMLLabel.h
//  Qiyeyun
//
//  Created by dong on 2016/12/29.
//  Copyright © 2016年 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (FilterHTMLLabel)
/**除去HTML标签*/
+ (NSMutableAttributedString *)qy_filterHTMLWithString:(NSMutableAttributedString *)string HTMLLabel:(NSString *)htmlLabel;
/**除去HTML标签,标签对中设置属性*/
+ (NSMutableAttributedString *)qy_filterHTMLWithString:(NSMutableAttributedString *)string HTMLLabel:(NSString *)htmlLabel addAtt:(NSDictionary<NSString *, id> *)addAtt;
@end
