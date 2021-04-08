//
//  NSBundle+QYCBundle.h
//  QYCCategory
//
//  Created by Qiyeyun2 on 2020/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (QYCBundle)

+ (NSBundle *)bundleWithaClass:(Class)aClass aBundle:(NSString *)aBundle;

@end

NS_ASSUME_NONNULL_END
