//
//  NSObject+QYCExtensionEntId.h
//  Qiyeyun
//
//  Created by dong on 2019/7/10.
//  Copyright © 2019 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (QYCExtensionEntId)

@property (nonatomic, copy) NSString *qyc_entId;

- (NSString *)URLPath:(NSString *)path entId:(NSString *)entId;

/**
 获取企业ID已经拼装好的URL的路径。前提是该企业ID也是通过该类赋值的。

 @param path 原路径
 @return 企业ID已经拼装好的URL的路径
 */
- (NSString *)URLPath:(NSString *)path;

- (NSString *)getRealEntId;
@end

NS_ASSUME_NONNULL_END
