//
//  NSMutableAttributedString+FilterHTMLLabel.m
//  Qiyeyun
//
//  Created by dong on 2016/12/29.
//  Copyright © 2016年 安元. All rights reserved.
// 过滤文本中的HTML标签对

#import "NSMutableAttributedString+FilterHTMLLabel.h"
#import "UIColor+QYCColor.h"

@implementation NSMutableAttributedString (FilterHTMLLabel)

+ (NSMutableAttributedString *)qy_filterHTMLWithString:(NSMutableAttributedString *)string HTMLLabel:(NSString *)htmlLabel {
    NSArray *atResults = [[self regexHTML:htmlLabel] matchesInString:string.string options:kNilOptions range:NSMakeRange(0, string.length)];

    NSUInteger clipLength = 0;

    for (NSTextCheckingResult *at in atResults) {
        if (at.range.location == NSNotFound && at.range.length <= 1)
            continue;

        NSRange range1 = at.range;
        range1.location -= clipLength;
        NSString *atString = [string.string substringWithRange:range1];

        NSCharacterSet *set                = [NSCharacterSet characterSetWithCharactersInString:@"><"];
        NSArray *array                     = [atString componentsSeparatedByCharactersInSet:set];
        NSString *name                     = array[2];
        NSMutableAttributedString *nameAtt = [[NSMutableAttributedString alloc] initWithString:name];
        [string replaceCharactersInRange:range1 withAttributedString:nameAtt];

        range1 = NSMakeRange(range1.location, name.length);

        __block BOOL containsBindingRange = NO;
        [string enumerateAttribute:NSForegroundColorAttributeName
                           inRange:range1
                           options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                        usingBlock:^(id value, NSRange range, BOOL *stop) {
                            if (value) {
                                containsBindingRange = YES;
                                *stop                = YES;
                            }
                        }];
        if (containsBindingRange)
            continue;
        clipLength += at.range.length - name.length;
    }

    return string;
}

+ (NSMutableAttributedString *)qy_filterHTMLWithString:(NSMutableAttributedString *)string HTMLLabel:(NSString *)htmlLabel addAtt:(NSDictionary<NSString *, id> *)addAtt {
    NSArray *atResults = [[self regexHTML:htmlLabel] matchesInString:string.string options:kNilOptions range:NSMakeRange(0, string.length)];

    NSUInteger clipLength = 0;

    for (NSTextCheckingResult *at in atResults) {
        if (at.range.location == NSNotFound && at.range.length <= 1)
            continue;

        NSRange range1 = at.range;
        range1.location -= clipLength;
        NSString *atString = [string.string substringWithRange:range1];

        NSCharacterSet *set                = [NSCharacterSet characterSetWithCharactersInString:@"><"];
        NSArray *array                     = [atString componentsSeparatedByCharactersInSet:set];
        NSString *name                     = array[2];
        NSMutableAttributedString *nameAtt = [[NSMutableAttributedString alloc] initWithString:name];
        [string replaceCharactersInRange:range1 withAttributedString:nameAtt];

        range1 = NSMakeRange(range1.location, name.length);

        __block BOOL containsBindingRange = NO;
        [string enumerateAttribute:NSForegroundColorAttributeName
                           inRange:range1
                           options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                        usingBlock:^(id value, NSRange range, BOOL *stop) {
                            if (value) {
                                containsBindingRange = YES;
                                *stop                = YES;
                            }
                        }];
        if (containsBindingRange)
            continue;
        clipLength += at.range.length - name.length;
        [string setAttributes:@{NSForegroundColorAttributeName:KQYCColor(ff530d, ff530d)} range:range1];
    }

    return string;
}
+ (NSRegularExpression *)regexHTML:(NSString *)html {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"<%@>(.*?)</%@>", html, html] options:kNilOptions error:NULL];
    });
    return regex;
}

@end
