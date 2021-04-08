//
//  PPNetworkHelper.m
//  PPNetworkHelper
//
//  Created by AndyPang on 16/8/12.
//  Copyright © 2016年 AndyPang. All rights reserved.
//


#import "PPNetworkHelper.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#include <sys/sysctl.h>

#ifdef DEBUG
#define PPLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define PPLog(...)
#endif

#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

@interface UIDevice (PP)
- (NSString *)machineModel;
@end

@implementation UIDevice(PP)
- (NSString *)machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}
@end

@implementation PPNetworkHelper

static BOOL _isOpenLog;   // 是否已开启日志打印
static NSMutableArray *_allSessionTask;
static NSMutableDictionary *_allMarkSessionTask;
static AFHTTPSessionManager *_sessionManager;

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(PPNetworkStatus)networkStatus {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(PPNetworkStatusUnknown) : nil;
                    if (_isOpenLog) PPLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(PPNetworkStatusNotReachable) : nil;
                    if (_isOpenLog) PPLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(PPNetworkStatusReachableViaWWAN) : nil;
                    if (_isOpenLog) PPLog(@"手机自带网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(PPNetworkStatusReachableViaWiFi) : nil;
                    if (_isOpenLog) PPLog(@"WIFI");
                    break;
            }
        }];
    });
}

+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)openLog {
    _isOpenLog = YES;
}

+ (void)closeLog {
    _isOpenLog = NO;
}

+ (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

+ (void)cancelRequestWithUniqueMark:(NSString*)mark {
    if (!mark) { return; }
    @synchronized (self) {
        NSMutableDictionary *dict = [self allMarkSessionTask];
        if (dict[mark]) {
            NSURLSessionTask *task = [[self allMarkSessionTask] valueForKey:mark];
            [task cancel];
            [[self allMarkSessionTask] removeObjectForKey:mark];
        }
    }
}

#pragma mark - GET请求无缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure {
    return [self GET:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark - POST请求无缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure {
    return [self POST:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark - GET请求自动缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
            responseCache:(PPHttpRequestCache)responseCache
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure {
   NSString *url = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //读取缓存
    responseCache!=nil ? responseCache([PPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask = [_sessionManager GET:url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
     
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {PPLog(@"responseObject = %@",[self jsonToString:responseObject]);}
        @synchronized(self) {
            [self.allSessionTask removeObject:task];
        }
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        @synchronized(self) {
            [[self allSessionTask] removeObject:task];
        }
        failure ? failure(error) : nil;
        
    }];
    @synchronized(self) {
        // 添加sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    }
    return sessionTask;
}

#pragma mark - POST请求自动缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
             responseCache:(PPHttpRequestCache)responseCache
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure {
    NSString *url = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //读取缓存
    responseCache!=nil ? responseCache([PPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    NSURLSessionTask *sessionTask = [_sessionManager POST:url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {PPLog(@"responseObject = %@",[self jsonToString:responseObject]);}
        @synchronized(self) {
            [[self allSessionTask] removeObject:task];
        }
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        @synchronized(self) {
            [[self allSessionTask] removeObject:task];
        }
        failure ? failure(error) : nil;
        
    }];
    @synchronized(self) {
        // 添加最新的sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    }
    return sessionTask;
}

#pragma mark - 上传文件
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               fileData:(NSData *)data
                               mimeType:(NSString *)mimeType
                             uniqueMark:(NSString*)uniqueMark
                               progress:(PPHttpProgress)progress
                                success:(PPHttpRequestSuccess)success
                                failure:(PPHttpRequestFailed)failure {
    NSString *url = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSessionTask *sessionTask = [_sessionManager POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (filePath && ![filePath isEqualToString:@""]) {
            NSError *error = nil;
            NSURL *fileUrl = [NSURL fileURLWithPath:filePath isDirectory:NO];
            [formData appendPartWithFileURL:fileUrl name:name fileName:name mimeType:mimeType error:&error];
            (failure && error) ? failure(error) : nil;
//            NSData *temp = [NSData dataWithContentsOfFile:filePath];
//            [formData appendPartWithFileData:temp name:@"file" fileName:name mimeType:mimeType];
        }
        else if (data) {
            [formData appendPartWithFileData:data name:name fileName:name mimeType:mimeType];
        }
        else {
            (failure) ? failure(nil) : nil;
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {PPLog(@"responseObject = %@",[self jsonToString:responseObject]);}
        @synchronized(self) {
            [[self allSessionTask] removeObject:task];
            [[self allMarkSessionTask] removeObjectForKey:uniqueMark];
        }
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        @synchronized(self) {
            [[self allSessionTask] removeObject:task];
            [[self allMarkSessionTask] removeObjectForKey:uniqueMark];
        }
        failure ? failure(error) : nil;
    }];
    @synchronized(self) {
        // 添加sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
        sessionTask ? [[self allMarkSessionTask] setValue:sessionTask forKey:uniqueMark] : nil;
    }
    return sessionTask;
}

+ (NSURLSessionTask *)Upload:(NSString *)URLSting parameter:(id)parameters uploadParam:(NSArray *)uploadParams progress:(PPHttpProgress)progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *url = [URLSting stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间
    sessionManager.requestSerializer.timeoutInterval = 30.f;
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    sessionManager.responseSerializer                        = [AFJSONResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];

    NSURLSessionTask *sessionTask = [sessionManager POST:url
        parameters:parameters ?: @{}
        headers:nil
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
            for (NSDictionary *uploadParam in uploadParams) {
                NSData *data = uploadParam[@"data"];
                NSString *name = uploadParam[@"name"];
                NSString *fileName = uploadParam[@"fileName"];
                NSString *type = uploadParam[@"uploadType"];
                [formData appendPartWithFileData:data name:name fileName:fileName mimeType:type];
            }
        }
        progress:^(NSProgress *_Nonnull uploadProgress) {
            //上传进度
            dispatch_sync(dispatch_get_main_queue(), ^{
                progress ? progress(uploadProgress) : nil;
            });
        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            if (_isOpenLog) {PPLog(@"responseObject = %@",[self jsonToString:responseObject]);}
            @synchronized(self) {
                [[self allSessionTask] removeObject:task];
            }
            success ? success(responseObject) : nil;
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            if (_isOpenLog) {PPLog(@"error = %@",error);}
            @synchronized(self) {
                [[self allSessionTask] removeObject:task];
            }
            failure ? failure(error) : nil;
        }];
    @synchronized(self) {
        // 添加sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    }
    return sessionTask;
}

#pragma mark - 上传多张图片
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(PPHttpProgress)progress
                                  success:(PPHttpRequestSuccess)success
                                  failure:(PPHttpRequestFailed)failure {
    NSString *url = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSessionTask *sessionTask = [_sessionManager POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = NSStringFormat(@"%@%ld.%@",str,i,imageType?:@"jpg");
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? NSStringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                    mimeType:NSStringFormat(@"image/%@",imageType ?: @"jpg")];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {PPLog(@"responseObject = %@",[self jsonToString:responseObject]);}
        @synchronized(self) {
            [[self allSessionTask] removeObject:task];
        }
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        @synchronized(self) {
            [[self allSessionTask] removeObject:task];
        }
        failure ? failure(error) : nil;
    }];
    @synchronized(self) {
        // 添加sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    }
    
    return sessionTask;
}

/////////新增

+ (NSURLSessionTask *)uploadImagesModelWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(PPHttpProgress)progress
                                  success:(PPHttpRequestSuccess)success
                                  failure:(PPHttpRequestFailed)failure {
    NSString *url = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSessionTask *sessionTask = [_sessionManager POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = NSStringFormat(@"%@%ld.%@",str,i,imageType?:@"jpg");
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? NSStringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                    mimeType:NSStringFormat(@"image/%@",imageType ?: @"jpg")];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {PPLog(@"responseObject = %@",[self jsonToString:responseObject]);}
        @synchronized(self) {
            [[self allSessionTask] removeObject:task];
        }
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    @synchronized(self) {
        // 添加sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    }
    return sessionTask;
}

////////

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(PPHttpProgress)progress
                              success:(void(^)(NSString *filePath))success
                              failure:(PPHttpRequestFailed)failure {
    NSString *url = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).firstObject  stringByAppendingPathComponent:@"MyFile"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        if (fileDir) {
            NSString *toFilePath = [downloadDir stringByAppendingPathComponent:fileDir];
            //返回文件位置的URL路径
            [fileManager moveItemAtPath:filePath toPath:toFilePath error:nil];
            return [NSURL fileURLWithPath:toFilePath];
        }
        else {
            return [NSURL fileURLWithPath:filePath];
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        @synchronized(self) {
            [[self allSessionTask] removeObject:downloadTask];
        }
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
    }];
    //开始下载
    [downloadTask resume];
    @synchronized(self) {
        // 添加sessionTask到数组
        downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    }
    return downloadTask;
}

+ (NSURLSessionTask *)downloadChatFileWithURL:(NSString *)URL
                                   folderName:(NSString *)folderName
                                     fileName:(NSString *)fileName
                                     progress:(PPHttpProgress)progress
                                      success:(void (^)(NSString *))success
                                      failure:(PPHttpRequestFailed)failure {
    NSURLRequest *request                          = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request
        progress:^(NSProgress *_Nonnull downloadProgress) {
            //下载进度
            dispatch_sync(dispatch_get_main_queue(), ^{
                progress ? progress(downloadProgress) : nil;
            });
        }
        destination:^NSURL *_Nonnull(NSURL *_Nonnull targetPath, NSURLResponse *_Nonnull response) {
            NSString *patchName = @"MyFile";
            if (folderName.length > 0) {
                patchName = [NSString stringWithFormat:@"%@/%@", patchName, folderName];
            }
            //拼接缓存目录
            NSString *downloadDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:patchName];
            //打开文件管理器
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //创建Download目录
            [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
            //拼接文件路径
            NSString *filePath = [downloadDir stringByAppendingPathComponent:[self fileName:fileName downloadDir:downloadDir]];
            return [NSURL fileURLWithPath:filePath];
        }
        completionHandler:^(NSURLResponse *_Nonnull response, NSURL *_Nullable filePath, NSError *_Nullable error) {
            @synchronized(self) {
                [[self allSessionTask] removeObject:downloadTask];
                [[self allMarkSessionTask] removeObjectForKey:URL ?: @""];
            }
            if (failure && error) {
                failure(error);
                return;
            };
            success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        }];
    //开始下载
    [downloadTask resume];
    @synchronized(self) {
        // 添加sessionTask到数组
        downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil;
        downloadTask ? [[self allMarkSessionTask] setValue:downloadTask forKey:URL ?: @""] : nil;
    }
    return downloadTask;
}
/**
 重名文件处理
 */
+ (NSString *)fileName:(NSString *)fileName downloadDir:(NSString *)downloadDir {
    NSFileManager *fileManager = [NSFileManager defaultManager];

    //判断本地是否已存在
    BOOL result = [fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", downloadDir, fileName]];

    if (result) {
        //从文件名尾开始搜索位置
        NSRange range = [fileName rangeOfString:@"(" options:NSBackwardsSearch];

        NSRange range1 = [fileName rangeOfString:@")." options:NSBackwardsSearch];

        if (range.location != NSNotFound && range1.location != NSNotFound && range.location < range1.location) {
            //起始位置
            NSInteger startLocation = range.location + 1;

            //取值目标范围
            NSRange aimRange = NSMakeRange(startLocation, range1.location - startLocation);

            //截取目标字符串
            NSString *str = [fileName substringWithRange:aimRange];

            NSScanner *scan = [NSScanner scannerWithString:str];
            NSInteger val;
            //长整型数字判断
            if ([scan scanInteger:&val] && [scan isAtEnd]) {
                fileName = [fileName stringByReplacingCharactersInRange:aimRange withString:[NSString stringWithFormat:@"%d", str.intValue + 1]];
            }
            else {
                //第一次
                fileName = [self defaultAutoIncrementFileName:fileName];
            }
        }
        else {
            //第一次
            fileName = [self defaultAutoIncrementFileName:fileName];
        }
        fileName = [self fileName:fileName downloadDir:downloadDir];
    }
    return fileName;
}
/**
 存在重名文件第一次默认值设置
 */
+ (NSString *)defaultAutoIncrementFileName:(NSString *)fileName {
    //文件后缀
    NSString *suffix = [fileName pathExtension];

    if (suffix.length > 0) {
        NSString *fileExtension = [@"." stringByAppendingString:suffix];
        fileName                = [NSString stringWithFormat:@"%@(1).%@", [fileName stringByReplacingOccurrencesOfString:fileExtension withString:@""], suffix];
    }
    else {
        fileName = [NSString stringWithFormat:@"%@(1)", fileName];
    }
    return fileName;
}
////////////////////////////////////////////新增 PUT,DELETE/////////////////////////////////////////
#pragma mark - PUT请求无缓存
+ (NSURLSessionTask *)PUT:(NSString *)URL
               parameters:(id)parameters
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure {
    return [self PUT:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark - DELETE请求无缓存
+ (NSURLSessionTask *)DELETE:(NSString *)URL
                parameters:(id)parameters
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure {
    return [self DELETE:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark - PUT请求自动缓存
+ (NSURLSessionTask *)PUT:(NSString *)URL
               parameters:(id)parameters
            responseCache:(PPHttpRequestCache)responseCache
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure {
    NSString *url = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //读取缓存
    responseCache!=nil ? responseCache([PPNetworkCache httpCacheForURL:url parameters:parameters]) : nil;
    NSURLSessionTask *sessionTask = [_sessionManager PUT:url parameters:parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog) {PPLog(@"responseObject = %@",[self jsonToString:responseObject]);}
        @synchronized(self) {
            [[self allSessionTask] removeObject:task];
        }
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    @synchronized(self) {
        // 添加sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    }
    return sessionTask;
}

#pragma mark - DELETE请求自动缓存
+ (NSURLSessionTask *)DELETE:(NSString *)URL
                parameters:(id)parameters
             responseCache:(PPHttpRequestCache)responseCache
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure {
    //读取缓存
    responseCache!=nil ? responseCache([PPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    ///////////////////////////////////////////////////////
    
    AFHTTPSessionManager *sessionM = [AFHTTPSessionManager manager];
    sessionM.requestSerializer.timeoutInterval = 60.f;
    sessionM.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionM.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    sessionM.responseSerializer = [AFJSONResponseSerializer serializer];
    ///////////////////////////////////////////////////////
    NSString *url = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSessionTask *sessionTask = [sessionM DELETE:url parameters:parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog) {PPLog(@"responseObject = %@",[self jsonToString:responseObject]);}
        @synchronized(self) {
            [[self allSessionTask] removeObject:task];
        }
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    @synchronized(self) {
        // 添加最新的sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    }
    return sessionTask;
}

# pragma mark - 需要用到token的GET请求

+ (NSURLSessionTask *)GET:(NSString *)URL
              seerializer:(BOOL)serializer
               parameters:(id)parameters
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure {
    return [self getWithHead:serializer ? [AFJSONRequestSerializer serializer] : [AFHTTPRequestSerializer serializer]
                      geturl:URL
                  parameters:parameters
                     success:success
                     failure:failure];
}

+ (NSURLSessionTask *)getWithHead:(AFHTTPRequestSerializer *)serializer
                           geturl:(NSString *)URL
                       parameters:(id)parameters
                          success:(PPHttpRequestSuccess)success
                          failure:(PPHttpRequestFailed)failure
{
    PPHttpRequestCache responseCache = nil;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = serializer;
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
//    useragent格式 前面两个写死 APP|iOS|QYCloud|6.1.0|0F837B6C-6463-4DCC-8F3F-10800752E268|iPhoneSE|iOS|11.1
    NSString *useragent = [NSString stringWithFormat:@"APP|iOS|%@|%@|%@|%@|%@|%@",@"QYCloud",currentVersion,[UIDevice currentDevice].identifierForVendor.UUIDString,[UIDevice currentDevice].machineModel,[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
    [manager.requestSerializer setValue:useragent forHTTPHeaderField:@"User-Agent"];

    // 设置请求的超时时间
    manager.requestSerializer.timeoutInterval = 30.f;
    // 设置服务器返回结果的类型:JSON /二进制(AFJSONResponseSerializer,AFHTTPResponseSerializer)
    //    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    //读取缓存
    responseCache!=nil ? responseCache([PPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    NSString *url = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSessionTask *sessionTask = [manager GET:url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //判断response的code是否过期，如果code==500，说明token过期，重新获取 token
        if (_isOpenLog) {PPLog(@"responseObject = %@",[self jsonToString:responseObject]);}
        @synchronized(self) {
            [[self allSessionTask] removeObject:task];
        }
        success ? success(responseObject) : nil;
        
        //对数据进行异步缓存
        responseCache!=nil ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    @synchronized(self) {
        // 添加sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    }
    return sessionTask;
}

# pragma mark - 需要用到token的POST请求

+ (NSURLSessionTask *)POST:(NSString *)URL
                serializer:(BOOL)serializer
                parameters:(id)parameters
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure {
    return [self postWithHead:serializer ? [AFJSONRequestSerializer serializer] : [AFHTTPRequestSerializer serializer]
                         POST:URL
                   parameters:parameters
                      success:success
                      failure:failure];
}

+ (NSURLSessionTask *)postWithHead:(AFHTTPRequestSerializer *)serializer
                              POST:(NSString *)URL
                        parameters:(id)parameters
                           success:(PPHttpRequestSuccess)success
                           failure:(PPHttpRequestFailed)failure
{
    PPHttpRequestCache responseCache = nil;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = serializer;
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    //    useragent格式 前面两个写死 APP|iOS|QYCloud|6.1.0|0F837B6C-6463-4DCC-8F3F-10800752E268|iPhoneSE|iOS|11.1
    NSString *useragent = [NSString stringWithFormat:@"APP|iOS|%@|%@|%@|%@|%@|%@",@"QYCloud",currentVersion,[UIDevice currentDevice].identifierForVendor.UUIDString,[UIDevice currentDevice].machineModel,[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
    [manager.requestSerializer setValue:useragent forHTTPHeaderField:@"User-Agent"];

    // 设置请求的超时时间
    manager.requestSerializer.timeoutInterval = 30.f;
    // 设置服务器返回结果的类型:JSON /二进制(AFJSONResponseSerializer,AFHTTPResponseSerializer)
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];

    //读取缓存
    responseCache!=nil ? responseCache([PPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    NSString *url = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSessionTask *sessionTask = [manager POST:url parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog) {PPLog(@"responseObject = %@",[self jsonToString:responseObject]);}
        @synchronized(self) {
            [[self allSessionTask] removeObject:task];
        }
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    @synchronized(self) {
        // 添加最新的sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    }
    return sessionTask;
}

+ (NSURLSessionTask *)putWithHead:(AFHTTPRequestSerializer *)serializer
                              PUT:(NSString *)URL
                       parameters:(id)parameters
                          success:(PPHttpRequestSuccess)success
                          failure:(PPHttpRequestFailed)failur {
    PPHttpRequestCache responseCache = nil;
    AFHTTPSessionManager *manager    = [AFHTTPSessionManager manager];
    manager.requestSerializer        = serializer;
    NSDictionary *infoDic            = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion         = [infoDic objectForKey:@"CFBundleShortVersionString"];
    //    useragent格式 前面两个写死 APP|iOS|QYCloud|6.1.0|0F837B6C-6463-4DCC-8F3F-10800752E268|iPhoneSE|iOS|11.1
    NSString *useragent = [NSString stringWithFormat:@"APP|iOS|%@|%@|%@|%@|%@|%@", @"QYCloud", currentVersion, [UIDevice currentDevice].identifierForVendor.UUIDString, [UIDevice currentDevice].machineModel, [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
//    [manager.requestSerializer setValue:[AccountTool account].entId forHTTPHeaderField:@"entId"];
//    [manager.requestSerializer setValue:[AccountTool account].userId forHTTPHeaderField:@"userId"];
    [manager.requestSerializer setValue:useragent forHTTPHeaderField:@"User-Agent"];

    // 设置请求的超时时间
    manager.requestSerializer.timeoutInterval = 30.f;
    // 设置服务器返回结果的类型:JSON /二进制(AFJSONResponseSerializer,AFHTTPResponseSerializer)
    manager.responseSerializer                        = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];

    //读取缓存
    responseCache != nil ? responseCache([PPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    NSString *url                 = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSessionTask *sessionTask = [manager PUT:url
        parameters:parameters
        headers:nil
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSDictionary *allHeaders    = response.allHeaderFields;
            NSString *token             = allHeaders[@"Aysaas-Refresh-Token"];
            if (token) {
                [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"loginmicroServiceToken"];
            }
            if (_isOpenLog) {
                PPLog(@"responseObject = %@", [self jsonToString:responseObject]);
            }
            @synchronized(self) {
                [[self allSessionTask] removeObject:task];
            }
            success ? success(responseObject) : nil;
            //对数据进行异步缓存
            responseCache != nil ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            if (_isOpenLog) {
                PPLog(@"error = %@", error);
            }
            [[self allSessionTask] removeObject:task];
            failur ? failur(error) : nil;
        }];
    @synchronized(self) {
        // 添加最新的sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    }
    return sessionTask;
}

////////////////////////////////////////////新增PUT, DELETE/////////////////////////////////////////
/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data {
    if(data == nil) { return nil; }
    if ([data isKindOfClass:[NSDictionary class]]) {
        if ([NSJSONSerialization isValidJSONObject:data]) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
            NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            if (!error) return json;
        }
        return @"非json非二进制数据";
    } else if ([data isKindOfClass:[NSData class]]) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        return @"非json非二进制数据";
    }
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

+ (NSMutableDictionary *)allMarkSessionTask {
    if (!_allMarkSessionTask) {
        _allMarkSessionTask = [NSMutableDictionary dictionary];
    }
    return _allMarkSessionTask;
}

#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    [PPNetworkHelper openLog];
}
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间
    _sessionManager.requestSerializer.timeoutInterval = 60.f;
    // 设置服务器返回结果的类型:JSON /二进制(AFJSONResponseSerializer,AFHTTPResponseSerializer)
//    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    [self setValue:@"ios" forHTTPHeaderField:@"Qycloud-client"];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    [self setValue:currentVersion forHTTPHeaderField:@"Qycloud-version"];
    //    useragent格式 前面两个写死 APP|iOS|QYCloud|6.1.0|0F837B6C-6463-4DCC-8F3F-10800752E268|iPhoneSE|iOS|11.1
    NSString *useragent = [NSString stringWithFormat:@"APP|iOS|%@|%@|%@|%@|%@|%@",@"QYCloud",currentVersion,[UIDevice currentDevice].identifierForVendor.UUIDString,[UIDevice currentDevice].machineModel,[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
    [self setValue:useragent forHTTPHeaderField:@"User-Agent"];

    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)setRequestSerializer:(PPRequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer==PPRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(PPResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer==PPResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}

@end


#pragma mark - NSDictionary,NSArray的分类
/*
 ************************************************************************************
 *新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文
 ************************************************************************************
 */

#ifdef DEBUG
@implementation NSArray (PP)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    
    return strM;
}

@end

@implementation NSDictionary (PP)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
#endif

