//
//  NSString+QYCStringExtension.m
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/9/7.
//  Copyright © 2020 安元. All rights reserved.
//

#import "NSString+QYCStringExtension.h"

@implementation NSString (QYCStringExtension)

+ (NSString *)filterVoidLine:(NSString *)string {
    NSArray *stringArray     = [string componentsSeparatedByString:@"\n"];
    NSMutableArray *newArray = [NSMutableArray array];
    [stringArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (obj && ![obj isEqualToString:@""]) {
            [newArray addObject:obj];
        }
    }];
    return [newArray componentsJoinedByString:@"\n"];
}

+ (NSString *)filterAllVoidLine:(NSString *)string {
    NSArray *stringArray     = [string componentsSeparatedByString:@"\n"];
    NSMutableArray *newArray = [NSMutableArray array];
    [stringArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (obj && ![obj isEqualToString:@""]) {
            [newArray addObject:obj];
        }
    }];
    return [newArray componentsJoinedByString:@""];
}

+ (NSString *)filterAllVoidLine:(NSString *)string withReplace:(NSString *)replace {
    NSArray *stringArray     = [string componentsSeparatedByString:@"\n"];
    NSMutableArray *newArray = [NSMutableArray array];
    [stringArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (obj && ![obj isEqualToString:@""]) {
            [newArray addObject:obj];
        }
    }];
    return [newArray componentsJoinedByString:replace];
}

@end
