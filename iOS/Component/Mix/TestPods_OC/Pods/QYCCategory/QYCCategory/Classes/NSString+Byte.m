//
//  NSString+Byte.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/10/23.
//  Copyright © 2019 安元. All rights reserved.
//

#import "NSString+Byte.h"

@implementation NSString (Byte)

- (int)getByteNum {
    int strlength = 0;
    char *p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for ( int i=0; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

- (NSString *)subStringByByteWithIndex:(NSInteger)index {
    NSInteger sum = 0;
    NSString *subStr = [[NSString alloc] init];
    for(int i = 0; i<[self length]; i++) {
        unichar strChar = [self characterAtIndex:i];
        if(strChar < 256) {
            sum += 1;
        }
        else {
            sum += 2;
        }
        if (sum >= index) {
            subStr = [self substringToIndex:i+1];
            return subStr;
        }
    }
    return subStr;
}

@end
