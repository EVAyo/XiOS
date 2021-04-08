//
//  NSString+Byte.h
//  Qiyeyun
//
//  Created by 启业云 on 2019/10/23.
//  Copyright © 2019 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Byte)

// 计算字符串的字节数(汉字占两个)
- (int)getByteNum;

// 从字符串中截取指定字节数
- (NSString *)subStringByByteWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
