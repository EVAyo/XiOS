//
//  PPNetworkHelper.h
//  PPNetworkHelper
//
//  Created by AndyPang on 16/8/12.
//  Copyright © 2016年 AndyPang. All rights reserved.
//

/*
 *********************************************************************************
 *
 *⭐️⭐️⭐️ 新建 PP-iOS学习交流群: 323408051 欢迎加入!!! ⭐️⭐️⭐️
 *
 * 如果您在使用 PPNetworkHelper 的过程中出现bug或有更好的建议,还请及时以下列方式联系我,我会及
 * 时修复bug,解决问题.
 *
 * Weibo : jkpang-庞
 * Email : jkpang@outlook.com
 * QQ 群 : 323408051
 * GitHub: https://github.com/jkpang
 *
 * PS:我的另外两个很好用的封装,欢迎使用!
 * 1.一行代码获取通讯录联系人,并进行A~Z精准排序(已处理姓名所有字符的排序问题):
 *   GitHub:https://github.com/jkpang/PPGetAddressBook
 * 2.iOS中一款高度可定制性商品计数按钮(京东/淘宝/饿了么/美团外卖/百度外卖样式):
 *   GitHub:https://github.com/jkpang/PPNumberButton
 *
 * 如果 PPGetAddressBookSwift 好用,希望您能Star支持,你的 ⭐️ 是我持续更新的动力!
 *
 * version: 0.8.0
 *********************************************************************************
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PPNetworkCache.h"

#ifndef kIsNetwork
#define kIsNetwork     [PPNetworkHelper isNetwork]  // 一次性判断是否有网的宏
#endif

#ifndef kIsWWANNetwork
#define kIsWWANNetwork [PPNetworkHelper isWWANNetwork]  // 一次性判断是否为手机网络的宏
#endif

#ifndef kIsWiFiNetwork
#define kIsWiFiNetwork [PPNetworkHelper isWiFiNetwork]  // 一次性判断是否为WiFi网络的宏
#endif

typedef NS_ENUM(NSUInteger, PPNetworkStatusType) {
    /** 未知网络*/
    PPNetworkStatusUnknown,
    /** 无网络*/
    PPNetworkStatusNotReachable,
    /** 手机网络*/
    PPNetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    PPNetworkStatusReachableViaWiFi
};

typedef NS_ENUM(NSUInteger, PPRequestSerializer) {
    /** 设置请求数据为JSON格式*/
    PPRequestSerializerJSON,
    /** 设置请求数据为二进制格式*/
    PPRequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, PPResponseSerializer) {
    /** 设置响应数据为JSON格式*/
    PPResponseSerializerJSON,
    /** 设置响应数据为二进制格式*/
    PPResponseSerializerHTTP,
};

/** 请求成功的Block */
typedef void(^PPHttpRequestSuccess)(id responseObject);

/** 请求失败的Block */
typedef void(^PPHttpRequestFailed)(NSError *error);

/** 缓存的Block */
typedef void(^PPHttpRequestCache)(id responseCache);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^PPHttpProgress)(NSProgress *progress);

/** 网络状态的Block*/
typedef void(^PPNetworkStatus)(PPNetworkStatusType status);

@class AFHTTPSessionManager,AFHTTPRequestSerializer;
@interface PPNetworkHelper : NSObject

/**
 有网YES, 无网:NO
 */
+ (BOOL)isNetwork;

/**
 手机网络:YES, 反之:NO
 */
+ (BOOL)isWWANNetwork;

/**
 WiFi网络:YES, 反之:NO
 */
+ (BOOL)isWiFiNetwork;

/**
 取消所有HTTP请求
 */
+ (void)cancelAllRequest;

/**
 实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)networkStatusWithBlock:(PPNetworkStatus)networkStatus;

/**
 取消指定标识符的HTTP请求
 */
+ (void)cancelRequestWithUniqueMark:(NSString *)mark;

/**
 取消指定URL的HTTP请求
 */
+ (void)cancelRequestWithURL:(NSString *)URL;

/**
 开启日志打印 (Debug级别)
 */
+ (void)openLog;

/**
 关闭日志打印,默认关闭
 */
+ (void)closeLog;


/**
 *  GET请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(id)parameters
                           success:(PPHttpRequestSuccess)success
                           failure:(PPHttpRequestFailed)failure;

/**
 *  GET请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(id)parameters
                     responseCache:(PPHttpRequestCache)responseCache
                           success:(PPHttpRequestSuccess)success
                           failure:(PPHttpRequestFailed)failure;

/**
 *  POST请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                         parameters:(id)parameters
                            success:(PPHttpRequestSuccess)success
                            failure:(PPHttpRequestFailed)failure;

/**
 *  POST请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                         parameters:(id)parameters
                      responseCache:(PPHttpRequestCache)responseCache
                            success:(PPHttpRequestSuccess)success
                            failure:(PPHttpRequestFailed)failure;

/**
 *  上传文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       文件对应服务器上的字段
 *  @param filePath   文件本地的沙盒路径
 *  @param fileData   文件本地的内容 （于filePathc互斥）
 *  @param mimeType  文件类型
 *  @param uniqueMark   该请求的唯一标识符
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 *  @discussion filePath 、 fileData  二者传一个即可，filePath优先级高
 */
+ (__kindof NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                                      parameters:(id)parameters
                                            name:(NSString *)name
                                        filePath:(NSString *)filePath
                                        fileData:(NSData *)data
                                        mimeType:(NSString *)mimeType
                                      uniqueMark:(NSString*)uniqueMark
                                        progress:(PPHttpProgress)progress
                                         success:(PPHttpRequestSuccess)success
                                         failure:(PPHttpRequestFailed)failure;
/**
 *  上传请求
 *
 *  @param URLString    请求的基本的url
 *  @param parameters   请求的参数字典
 *  @param uploadParam  上传的内容
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 */
+(__kindof NSURLSessionTask *_Nonnull)Upload:(NSString *_Nonnull)URLSting parameter:(id _Nullable )parameters uploadParam:(NSArray*_Nonnull)uploadParams progress:(PPHttpProgress)progress success:(nullable void(^)(id _Nullable responseObject))success failure:(nullable void(^)( NSError *_Nullable error))failure;


/**
 *  上传单/多张图片
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *_Nonnull)uploadImagesWithURL:(NSString *_Nonnull)URL
                                                parameters:(id _Nullable )parameters
                                              name:(NSString *)name
                                            images:(NSArray<UIImage *> *)images
                                         fileNames:(NSArray<NSString *> *)fileNames
                                        imageScale:(CGFloat)imageScale
                                         imageType:(NSString *)imageType
                                          progress:(PPHttpProgress)progress
                                           success:(PPHttpRequestSuccess)success
                                           failure:(PPHttpRequestFailed)failure;

/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Document/MyFile)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)URL
                                       fileDir:(NSString *)fileDir
                                      progress:(PPHttpProgress)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(PPHttpRequestFailed)failure;
/**
 *  下载文件
 *
 *  @param URL         请求地址
 *  @param folderName  上级文件夹名(可不传，url使用md5转换后可用作唯一性处理)
 *  @param fileName    文件名(存储路径为Document/MyFile/folderName/fileName 或Document/MyFile/fileName)
 *  @param progress    文件下载的进度信息
 *  @param success     下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure     下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (NSURLSessionTask *)downloadChatFileWithURL:(NSString *)URL
                                   folderName:(NSString *)folderName
                                     fileName:(NSString *)fileName
                                     progress:(PPHttpProgress)progress
                                      success:(void (^)(NSString *))success
                                      failure:(PPHttpRequestFailed)failure;
/**
 PUT请求,无缓存
 
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)PUT:(NSString *)URL
               parameters:(id)parameters
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure;

/**
 DELETE请求,无缓存
 
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)DELETE:(NSString *)URL
                  parameters:(id)parameters
                     success:(PPHttpRequestSuccess)success
                     failure:(PPHttpRequestFailed)failure;

/**
 PUT请求,自动缓存
 
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */

+ (NSURLSessionTask *)PUT:(NSString *)URL
               parameters:(id)parameters
            responseCache:(PPHttpRequestCache)responseCache
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure;

/**
 DELETE请求,自动缓存

 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)DELETE:(NSString *)URL
                  parameters:(id)parameters
               responseCache:(PPHttpRequestCache)responseCache
                     success:(PPHttpRequestSuccess)success
                     failure:(PPHttpRequestFailed)failure;

/**
 需要用到token的GET请求

 @param URL 请求地址
 @param serializer  YES: JSON(AFJSONRequestSerializer);   NO:  二进制(,AFHTTPRequestSerializer)
 @param parameters 请求参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 返回的对象可取消请求，调用cancel风那个发达
 */
+ (NSURLSessionTask *)GET:(NSString *)URL
              seerializer:(BOOL)serializer
               parameters:(id)parameters
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure;

/**
 需要用到token的GET请求

 @param serializer 请求的response
 @param URL 请求地址
 @param parameters 请求参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 返回的对象可取消请求，调用cancel风那个发达
 */
+ (NSURLSessionTask *)getWithHead:(AFHTTPRequestSerializer *)serializer
                           geturl:(NSString *)URL
                       parameters:(id)parameters
                          success:(PPHttpRequestSuccess)success
                          failure:(PPHttpRequestFailed)failure;

/**
 需要用到token的POST请求

 @param URL 请求地址
 @param serializer YES: JSON(AFJSONRequestSerializer);   NO:  二进制(,AFHTTPRequestSerializer)
 @param parameters 请求参数
 @param success 请求成功回掉
 @param failure 请求失败回掉
 @return 返回的对象可取消请求，调用cancel方法
 */
+ (NSURLSessionTask *)POST:(NSString *)URL
                serializer:(BOOL)serializer
                parameters:(id)parameters
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure;

/**
 需要用到token的POST请求

 @param serializer 请求的response
 @param URL 请求地址
 @param parameters 请求参数
 @param success 请求成功回掉
 @param failure 请求失败回掉
 @return 返回的对象可取消请求，调用cancel方法
 */
+ (NSURLSessionTask *)postWithHead:(AFHTTPRequestSerializer *)serializer
                              POST:(NSString *)URL
                        parameters:(id)parameters
                           success:(PPHttpRequestSuccess)success
                           failure:(PPHttpRequestFailed)failure;

/**
 需要用到token的Put请求

 @param serializer 请求的response
 @param URL 请求地址
 @param parameters 请求参数
 @param success 请求成功回掉
 @param failure 请求失败回掉
 @return 返回的对象可取消请求，调用cancel方法
 */
+ (NSURLSessionTask *)putWithHead:(AFHTTPRequestSerializer *)serializer
                              PUT:(NSString *)URL
                       parameters:(id)parameters
                          success:(PPHttpRequestSuccess)success
                          failure:(PPHttpRequestFailed)failure;

/*
 **************************************  说明  **********************************************
 *
 * 在一开始设计接口的时候就想着方法接口越少越好,越简单越好,只有GET,POST,上传,下载,监测网络状态就够了.
 *
 * 无奈的是在实际开发中,每个APP与后台服务器的数据交互都有不同的请求格式,如果要修改请求格式,就要在此封装
 * 内修改,再加上此封装在支持CocoaPods后,如果使用者pod update最新PPNetworkHelper,那又要重新修改此
 * 封装内的相关参数.
 *
 * 依个人经验,在项目的开发中,一般都会将网络请求部分封装 2~3 层,第2层配置好网络请求工具的在本项目中的各项
 * 参数,其暴露出的方法接口只需留出请求URL与参数的入口就行,第3层就是对整个项目请求API的封装,其对外暴露出的
 * 的方法接口只留出请求参数的入口.这样如果以后项目要更换网络请求库或者修改请求URL,在单个文件内完成配置就好
 * 了,大大降低了项目的后期维护难度
 *
 * 综上所述,最终还是将设置参数的接口暴露出来,如果通过CocoaPods方式使用PPNetworkHelper,在设置项目网络
 * 请求参数的时候,强烈建议开发者在此基础上再封装一层,通过以下方法配置好各种参数与请求的URL,便于维护
 *
 **************************************  说明  **********************************************
 */

#pragma mark - 设置AFHTTPSessionManager相关属性
#pragma mark 注意: 因为全局只有一个AFHTTPSessionManager实例,所以以下设置方式全局生效
/**
 在开发中,如果以下的设置方式不满足项目的需求,就调用此方法获取AFHTTPSessionManager实例进行自定义设置
 (注意: 调用此方法时在要导入AFNetworking.h头文件,否则可能会报找不到AFHTTPSessionManager的❌)
 @param sessionManager AFHTTPSessionManager的实例
 */
+ (void)setAFHTTPSessionManagerProperty:(void(^)(AFHTTPSessionManager *sessionManager))sessionManager;

/**
 *  设置网络请求参数的格式:默认为二进制格式
 *
 *  @param requestSerializer PPRequestSerializerJSON(JSON格式),PPRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(PPRequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer PPResponseSerializerJSON(JSON格式),PPResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(PPResponseSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为30S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/**
 *  设置请求头
 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 *  是否打开网络状态转圈菊花:默认打开
 *
 *  @param open YES(打开), NO(关闭)
 */
+ (void)openNetworkActivityIndicator:(BOOL)open;

/**
 配置自建证书的Https请求, 参考链接: http://blog.csdn.net/syg90178aw/article/details/52839103

 @param cerPath 自建Https证书的路径
 @param validatesDomainName 是否需要验证域名，默认为YES. 如果证书的域名与请求的域名不一致，需设置为NO; 即服务器使用其他可信任机构颁发
        的证书，也可以建立连接，这个非常危险, 建议打开.validatesDomainName=NO, 主要用于这种情况:客户端请求的是子域名, 而证书上的是另外
        一个域名。因为SSL证书上的域名是独立的,假如证书上注册的域名是www.google.com, 那么mail.google.com是无法验证通过的.
 */
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName;

@end

