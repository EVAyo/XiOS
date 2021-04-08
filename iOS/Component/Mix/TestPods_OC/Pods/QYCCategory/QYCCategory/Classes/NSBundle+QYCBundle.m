//
//  NSBundle+QYCBundle.m
//  QYCCategory
//
//  Created by Qiyeyun2 on 2020/12/29.
//

#import "NSBundle+QYCBundle.h"

@implementation NSBundle (QYCBundle)

+ (NSBundle *)bundleWithaClass:(Class)aClass aBundle:(NSString *)aBundle {
    NSBundle *bundle = [NSBundle bundleForClass:aClass];
    NSURL *url       = [bundle URLForResource:aBundle withExtension:@"bundle"];
    if (url) {
        return [NSBundle bundleWithURL:url];
    }else {
        return  [NSBundle mainBundle];
    }
}

@end
