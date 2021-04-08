//
//  NSObject+QYCFile.m
//  Qiyeyun
//
//  Created by 许冬冬 on 2020/2/18.
//  Copyright © 2020 安元. All rights reserved.
//

#import "NSObject+QYCFile.h"
#import <UIKit/UIKit.h>

long long const QYCFileMaxPreSize = 10*1024*1024;

@implementation NSObject (QYCFile)

+ (NSString *)qyc_fileTypeWithFilePath:(NSString *)filePath{
    NSString *fileExtension = [filePath pathExtension];
    return [fileExtension lowercaseString];
}

+ (NSString *)qyc_fileIconWithFilePath:(NSString *)filePath{
    NSString *fileExtension = [self qyc_fileTypeWithFilePath:filePath];
    //pic
    if ([fileExtension isEqualToString:@"png"] || [fileExtension isEqualToString:@"jpeg"]|| [fileExtension isEqualToString:@"jpg"]|| [fileExtension isEqualToString:@"gif"]|| [fileExtension isEqualToString:@"webp"]) {
        fileExtension = @"PIC";
    }
    //audio
    if ([fileExtension isEqualToString:@"mp3"] || [fileExtension isEqualToString:@"wav"]|| [fileExtension isEqualToString:@"aac"]|| [fileExtension isEqualToString:@"m4a"]|| [fileExtension isEqualToString:@"mid"]) {
        fileExtension = @"AUDIO";
    }
    //video
    if ([fileExtension isEqualToString:@"mp4"] || [fileExtension isEqualToString:@"m4v"]|| [fileExtension isEqualToString:@"mkv"]|| [fileExtension isEqualToString:@"mov"]|| [fileExtension isEqualToString:@"avi"]|| [fileExtension isEqualToString:@"wmv"]|| [fileExtension isEqualToString:@"flv"]|| [fileExtension isEqualToString:@"3gp"]) {
        fileExtension = @"VIDEO";
    }
    //zip
    if ([fileExtension isEqualToString:@"zip"] || [fileExtension isEqualToString:@"rar"]|| [fileExtension isEqualToString:@"tar"]|| [fileExtension isEqualToString:@"7z"]) {
        fileExtension = @"ZIP";
    }
    //word
    if ([fileExtension isEqualToString:@"doc"] || [fileExtension isEqualToString:@"docx"]) {
        fileExtension = @"WORD";
    }
    //ppt
    if ([fileExtension isEqualToString:@"ppt"] || [fileExtension isEqualToString:@"pptx"]) {
        fileExtension = @"PPT";
    }
    //excel
    if ([fileExtension isEqualToString:@"xls"] || [fileExtension isEqualToString:@"xlsx"]) {
        fileExtension = @"EXCEL";
    }

    return fileExtension?[fileExtension uppercaseString]:@"其他";
}

/// 支持该文件类型
/// @param fileType 文件类型
+ (BOOL)qyc_supportFileType:(NSString *)fileType{
    static  NSArray *supportedTypes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        supportedTypes = @[
                           @"pdf",
                           @"ppt",@"pptx",@"pptm",@"ppsx",@"ppsm",@"potx",@"potm",@"ppam",
                           @"xlsx",@"xls",@"xlsm",@"xltx",@"xltm",@"xlsb",@"xlam",
                           @"doc",@"docx",@"docm",@"dotx",
                           @"png",@"jpeg",@"jpg",@"gif",@"webp",@"apng"
                           ];
    });
    return [supportedTypes containsObject:[fileType lowercaseString]];
}

/// 文件的大小（B,KB,M,G）
/// @param length
+ (NSString *)qyc_fileSizeWithLength:(NSInteger)length {
     CGFloat GBUint = length/(1024*1024*1024.0);
     CGFloat MBUint = length/(1024*1024.0);
     CGFloat KBUint = length/1024.0;
     NSInteger BUint = length;
    if (GBUint>1) {
        return [NSString stringWithFormat:@"%.2fG",GBUint];
    }else if (MBUint>1){
        return [NSString stringWithFormat:@"%.2fM",MBUint];
    }else if (KBUint>1){
        return [NSString stringWithFormat:@"%.2fKB",KBUint];
    }else{
        return [NSString stringWithFormat:@"%ldB",BUint];
    }
    
}

@end
