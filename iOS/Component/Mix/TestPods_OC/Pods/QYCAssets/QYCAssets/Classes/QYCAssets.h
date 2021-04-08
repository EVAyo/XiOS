//
//  QYCAssets.h
//  QYCAssets
//
//  Created by 启业云03 on 2020/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYCAssets : NSObject

/// 获取公共资源
/// @param name 图片名：eg: defaultLargePortal，建议不加后缀
+ (nullable UIImage *)imageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
