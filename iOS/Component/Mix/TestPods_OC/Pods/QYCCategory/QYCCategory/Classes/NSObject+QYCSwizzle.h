//
//  NSObject+QYCSwizzle.h
//  Qiyeyun
//
//  Created by dong on 2017/11/10.
//  Copyright © 2017年 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (QYCSwizzle)
+ (BOOL)qyc_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_;
+ (BOOL)qyc_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_;
@end
