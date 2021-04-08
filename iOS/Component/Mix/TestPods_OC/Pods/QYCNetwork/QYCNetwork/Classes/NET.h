//
//  NET.h
//  Qiyeyun
//
//  Created by 钱立新 on 15/10/28.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFHTTPRequestSerializer;

FOUNDATION_EXTERN NSNotificationName const _Nonnull QYCNETWORKEErrorNotification;

@interface NET : NSObject

/**
 取消指定标识符的HTTP请求
 */
+ (void)cancelRequestWithUniqueMark:(NSString *_Nonnull)mark;
/**
 取消指定URL的HTTP请求
 */
+ (void)cancelRequestWithURL:(NSString *_Nullable)URL;

/**
 *  发送同步请求同步
 *
 *  @param method     请求方式
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 */
+ (void)requestWithMethod:(NSString *_Nonnull)method URLStr:(NSString *_Nonnull)URLString parameters:(id _Nullable)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *_Nullable error))failure;

/**
 *  发送get请求异步
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *_Nonnull)URLString parameters:(id _Nullable)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *_Nullable error))failure;

/**
 *  发送post请求异步
 *
 *  @param URLString 请求的基本url
 *  @param parameter 请求的参数字典
 *  @param success   请求成功的回调
 *  @param failure   请求失败的回调
 */
+ (void)POST:(NSString *_Nonnull)URLString parameters:(id _Nullable)parameter success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *_Nullable error))failure;

/**
 *  上传文件
 *
 *  @param URLString        请求地址
 *  @param parameters 请求参数
 *  @param name       文件对应服务器上的字段
 *  @param filePath   文件本地的沙盒路径
 *  @param data   文件本地的内容 （于filePathc互斥）
 *  @param mimeType 文件类型
 *  @param uniqueMark   该请求的唯一标识符
 *  @param uploadProgress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @discussion filePath 、 fileData  二者传一个即可，filePath优先级高
*/
+ (void)UploadFile:(NSString *_Nonnull)URLString parameter:(id _Nullable)parameters name:(NSString *_Nonnull)name filePath:(NSString *_Nullable)filePath fileData:(NSData *_Nullable)data mimeType:(NSString *_Nullable)mimeType uniqueMark:(NSString *_Nonnull)uniqueMark progress:(nullable void (^)(CGFloat progress))uploadProgress success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *_Nullable error))failure;
/**
 *  上传请求
 *
 *  @param URLSting    请求的基本的url
 *  @param parameters   请求的URLSting典
 *  @param uploadParams  上传的内容
 *  @param success      请求成功的uploadParams @param failure      请求失败的回调
 */
+ (void)Upload:(NSString *_Nonnull)URLSting parameter:(id _Nullable)parameters uploadParam:(NSArray *_Nonnull)uploadParams success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *_Nullable error))failure;

/**
 *  delete请求
 *
 *  @param urlString 请求的基本url
 *  @param paramer 请求的参数字典
 *  @param success   请求成功的回调
 *  @param failure   请求失败的回调
 */
+ (void)Delete:(NSString *_Nonnull)urlString parameter:(id _Nullable)paramer success:(void (^_Nullable)(id _Nullable responseObject))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

/**
 *  put请求
 *
 *  @param urlString 请求的基本url
 *  @param paramer 请求的参数字典
 *  @param success   请求成功的回调
 *  @param failure   请求失败的回调
 */
+ (void)Put:(NSString *_Nonnull)urlString parameter:(id _Nullable)paramer success:(void (^_Nullable)(id _Nullable responseObject))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

+ (void)Put:(NSString *_Nullable)urlString requestSerializer:(AFHTTPRequestSerializer *_Nullable)requestSerializer parameter:(id _Nullable )paramer success:(void (^_Nullable)(id _Nullable data))success failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  文件下载
 *
 *  @param urlString 请求的基本url
 *  @param paramer 请求的参数字典
 *  @param fileName  保存的文件名称
 *  @param success   请求成功的回调
 *  @param failure   请求失败的回调
 */
+ (void)Down:(NSString *_Nonnull)urlString parameter:(id _Nullable)paramer fileName:(NSString *_Nullable)fileName success:(void (^_Nullable)(NSString *_Nullable filePath))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

/**
 文件下载     同上，只是多一个下载进度progress

 @param urlString 请求的基本url
 @param paramer   请求的参数字典
 @param fileName  保存的文件名称
 @param downProgress  下载进度
 @param success   请求成功的回调
 @param failure   请求失败的回调
 */
+ (void)Down:(NSString *_Nonnull)urlString parameter:(id _Nullable)paramer fileName:(NSString *_Nullable)fileName progress:(void (^_Nullable)(NSProgress *_Nullable downProgress))downProgress success:(void (^_Nullable)(NSString *_Nullable filePath))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

/**
 启聊文件专用下载
 
 @param urlString   请求的基本url
 @param folderName  上级文件夹名(可不传，fileName上级文件目录)
 @param fileName    保存的文件名称
 @param downProgress    下载进度
 @param success     请求成功的回调
 @param failure     请求失败的回调
 */
+ (void)DownChatFile:(NSString *_Nullable)urlString folderName:(NSString *_Nullable)folderName fileName:(NSString *_Nullable)fileName progress:(void (^_Nullable)(NSProgress * _Nullable downProgress))downProgress success:(void (^_Nullable)(NSString * _Nullable filePath))success failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 发送带有缓存的get请求异步
 
 @param URLString 请求的基本的url
 @param parameters 请求的参数字典
 @param cache 缓存的回调
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)GET:(NSString *_Nonnull)URLString parameters:(id _Nullable)parameters responseCache:(void (^_Nullable)(id _Nullable responseCache))cache success:(void (^_Nullable)(id _Nullable responseObject))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

/**
 发送带有缓存的post请求异步

 @param URLString 请求的基本的url
 @param parameter 请求的参数字典
 @param cache 缓存的回调
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)POST:(NSString *_Nonnull)URLString parameters:(id _Nullable)parameter responseCache:(void (^_Nullable)(id _Nullable responseCache))cache success:(void (^_Nullable)(id _Nullable responseObject))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

/// post
/// @param URLString <#URLString description#>
/// @param requestSerializer YES: JSON(AFJSONRequestSerializer);
///                          NO:  二进制(,AFHTTPRequestSerializer)
/// @param parameter <#parameter description#>
/// @param success <#success description#>
/// @param failure <#failure description#>
+ (void)POST:(NSString *_Nonnull)URLString
    requestSerializer:(BOOL)requestSerializer
           parameters:(id _Nullable)parameter
              success:(void (^_Nullable)(id _Nullable responseObject))success
              failure:(void (^_Nullable)(NSError *_Nullable error))failure;

/**
 需要用到token的get请求

 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GETWithHead:(NSString *_Nonnull)URLString
         parameters:(id _Nullable)parameters
            success:(void (^_Nullable)(id _Nullable responseObject))success
            failure:(void (^_Nullable)(NSError *_Nullable error))failure;

/**
 需要用到token的POST请求

 @param URLString  请求的基本的url
 @param parameter  请求的参数字典
 @param success    请求成功的回调
 @param failure    请求失败的回调
 */
+ (void)POSTWithHead:(NSString *_Nonnull)URLString
          parameters:(id _Nullable)parameter
             success:(void (^_Nullable)(id _Nullable responseObject))success
             failure:(void (^_Nullable)(NSError *_Nullable error))failure;

/**
 有网YES, 无网:NO
 */
+ (BOOL)isNetwork;

@end
