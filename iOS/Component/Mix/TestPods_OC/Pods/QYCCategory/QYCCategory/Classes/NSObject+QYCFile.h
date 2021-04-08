//
//  NSObject+QYCFile.h
//  Qiyeyun
//
//  Created by 许冬冬 on 2020/2/18.
//  Copyright © 2020 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//文件最大预览大小
FOUNDATION_EXTERN  long long const QYCFileMaxPreSize;

@interface NSObject (QYCFile)

/// 根据文件路径判断文件类型
/// @param filePath 文件路径
+ (NSString *)qyc_fileTypeWithFilePath:(NSString *)filePath;

/// 文件的icon
/// @param filePath 文件路径
+ (NSString *)qyc_fileIconWithFilePath:(NSString *)filePath;

/// 支持该文件类型
/// @param fileType 文件类型
+ (BOOL)qyc_supportFileType:(NSString *)fileType;

/// 文件的大小（B,KB,M,G）
/// @param length  文件大小 B
+ (NSString *)qyc_fileSizeWithLength:(NSInteger)length;

@end

NS_ASSUME_NONNULL_END
