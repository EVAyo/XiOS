//[3]    (null)    @"NSLocalizedDescription" : @"Request failed: unauthorized (401)"    //  NET.m
//  Qiyeyun
//
//  Created by 钱立新 on 15/10/28.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import "NET.h"
#import "AFNetworking.h"
#import "PPNetworkHelper.h"
#import <QYCAppConfig/QYCAppConfig.h>

NSNotificationName const QYCNETWORKEErrorNotification = @"QYCNETWORKEErrorNotification";

@implementation NET

+ (void)cancelRequestWithUniqueMark:(NSString *_Nonnull)mark {
    [PPNetworkHelper cancelRequestWithUniqueMark:mark];
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    [PPNetworkHelper cancelRequestWithURL:[self dealNormalUrl:URL]];
}
+ (BOOL)isNetwork {
    return [PPNetworkHelper isNetwork];
}

+ (void)errorCode:(NSInteger)code {
    [PPNetworkHelper cancelAllRequest];
    [[NSNotificationCenter defaultCenter] postNotificationName:QYCNETWORKEErrorNotification object:nil userInfo:@{@"errorCode" : @(code)}];
}

+ (void)requestWithMethod:(NSString *)method URLStr:(NSString *)URLString parameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *_Nullable error))failure {
    /**
     modify LHL

     old version token request without header,replace original request and add the head method ect.
     */
    dispatch_semaphore_t disp = dispatch_semaphore_create(0);
    __block id responseData;
    NSString *aURL = [self dealNormalUrl:URLString];
    [PPNetworkHelper GET:aURL
        parameters:nil
        success:^(id responseObject) {
            responseData = responseObject;
            dispatch_semaphore_signal(disp);
        }
        failure:^(NSError *error) {
            responseData = error;
            dispatch_semaphore_signal(disp);
        }];
    dispatch_semaphore_wait(disp, DISPATCH_TIME_FOREVER);

    if ([responseData isKindOfClass:NSError.class]) {
        NSError *error = (NSError *)responseData;
        if ([error.localizedDescription containsString:@"(401)"]) {
            [self errorCode:401];
            return;
        }
        if ([error.localizedDescription containsString:@"(503)"]) {
            [self errorCode:503];
            return;
        }

        if (failure) {
            failure(error);
        }
    }
    else {
        NSDictionary *tokenDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        if ([tokenDic[@"status"] integerValue] == 503) {
            [self errorCode:503];
            return;
        }
        if ([tokenDic[@"status"] integerValue] == 2101) {
            [self errorCode:2101];
            return;
        }
        if (success) {
            success(tokenDic);
        }
    }
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *aURL = [self dealNormalUrl:URLString];

    [PPNetworkHelper GET:aURL
        parameters:parameters ?: @{}
        success:^(id responseObject) {
            if (success) {
                success(responseObject);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }

            if (failure) {
                failure(error);
            }
        }];
}
+ (void)POST:(NSString *)URLString parameters:(id)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *aURL = [self dealNormalUrl:URLString];

    [PPNetworkHelper POST:aURL
        parameters:parameter ?: @{}
        success:^(id responseObject) {
            if (success) {
                success(responseObject);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }
            if (failure) {
                failure(error);
            }
        }];
}

+ (void)UploadFile:(NSString *)URLString parameter:(id)parameters name:(NSString *)name filePath:(NSString *)filePath fileData:(NSData *)data mimeType:(NSString *)mimeType uniqueMark:(NSString *)uniqueMark progress:(nullable void (^)(CGFloat))uploadProgress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *aURL = [self dealNormalUrl:URLString];
    [PPNetworkHelper uploadFileWithURL:aURL
        parameters:parameters
        name:name
        filePath:filePath
        fileData:data
        mimeType:mimeType
        uniqueMark:uniqueMark
        progress:^(NSProgress *progress) {
            float p = 1.f * progress.completedUnitCount / progress.totalUnitCount;
            uploadProgress(p);
        }
        success:^(id responseObject) {
            if (success) {
                success(responseObject);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }
            if (failure) {
                failure(error);
            }
        }];
}

+ (void)Upload:(NSString *)URLSting parameter:(id)parameters uploadParam:(NSArray *)uploadParams success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *aURL = [self dealNormalUrl:URLSting];
    [PPNetworkHelper Upload:aURL
        parameter:parameters ?: @{}
        uploadParam:uploadParams
        progress:nil
        success:^(id _Nullable responseObject) {
            success ? success(responseObject) : nil;
        }
        failure:^(NSError *_Nullable error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }

            failure ? failure(error) : nil;
        }];
}

+ (void)Delete:(NSString *)urlString parameter:(id)paramer success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *aURL = [self dealNormalUrl:urlString];

    [PPNetworkHelper DELETE:aURL
        parameters:paramer ?: @{}
        success:^(id responseObject) {
            if (success) {
                success(responseObject);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }
            if (failure) {
                failure(error);
            }
        }];
}

+ (void)Put:(NSString *)urlString parameter:(id)paramer success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *aURL = [self dealNormalUrl:urlString];

    [PPNetworkHelper PUT:aURL
        parameters:paramer ?: @{}
        success:^(id responseObject) {
            if (success) {
                success(responseObject);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }
            if (failure) {
                failure(error);
            }
        }];
}

+ (void)Put:(NSString *)urlString requestSerializer:(AFHTTPRequestSerializer *)requestSerializer parameter:(id)paramer success:(void (^)(id data))success failure:(void (^)(NSError *error))failure {
    [PPNetworkHelper putWithHead:requestSerializer
        PUT:urlString
        parameters:paramer
        success:^(id responseObject) {
            if (success) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"code"] integerValue] == 15000 || [result[@"code"] integerValue] == 16007) {
                        [self errorCode:15000];
                        return;
                    }
                }
                success(responseObject);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }
            if (failure) {
                failure(error);
            }
        }];
}

+ (void)Down:(NSString *)urlString parameter:(id)paramer fileName:(NSString *)fileName success:(void (^)(NSString *filePath))success failure:(void (^)(NSError *error))failure {
    NSString *aURL = [self dealNormalUrl:urlString];

    [PPNetworkHelper downloadWithURL:aURL
        fileDir:fileName
        progress:^(NSProgress *progress) {

        }
        success:^(NSString *filePath) {
            if (success) {
                success(filePath);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }
            if (failure) {
                failure(error);
            }
        }];
}

+ (void)Down:(NSString *)urlString parameter:(id)paramer fileName:(NSString *)fileName progress:(void (^)(NSProgress *downProgress))downProgress success:(void (^)(NSString *filePath))success failure:(void (^)(NSError *error))failure {
    NSString *aURL = [self dealNormalUrl:urlString];

    [PPNetworkHelper downloadWithURL:aURL
        fileDir:fileName
        progress:^(NSProgress *progress) {
            if (downProgress) {
                downProgress(progress);
            }
        }
        success:^(NSString *filePath) {
            if (success) {
                success(filePath);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }
            if (failure) {
                failure(error);
            }
        }];
}

+ (void)DownChatFile:(NSString *)urlString folderName:(NSString *)folderName fileName:(NSString *)fileName progress:(void (^)(NSProgress *downProgress))downProgress success:(void (^)(NSString *filePath))success failure:(void (^)(NSError *error))failure {
    NSString *aURL = [self dealNormalUrl:urlString];
    
    [PPNetworkHelper downloadChatFileWithURL:aURL
        folderName:folderName
        fileName:fileName
        progress:^(NSProgress *progress) {
            if (downProgress) {
                downProgress(progress);
            }
        }
        success:^(NSString *filePath) {
            if (success) {
                success(filePath);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }
            if (failure) {
                failure(error);
            }
        }];
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters responseCache:(void (^)(id responseCache))cache success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSString *aURL = [self dealNormalUrl:URLString];

    [PPNetworkHelper GET:aURL
        parameters:parameters ?: @{}
        responseCache:^(id responseCache) {
            cache(responseCache);
        }
        success:^(id responseObject) {
            if (success) {
                success(responseObject);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }

            if (failure) {
                failure(error);
            }
        }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters responseCache:(void (^)(id responseCache))cache success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSString *aURL = [self dealNormalUrl:URLString];

    [PPNetworkHelper POST:aURL
        parameters:parameters ?: @{}
        responseCache:^(id responseCache) {
            cache(responseCache);
        }
        success:^(id responseObject) {
            if (success) {
                success(responseObject);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }

            if (failure) {
                failure(error);
            }
        }];
}

+ (void)GETWithHead:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *aURL = [self dealNormalUrl:URLString];
    [PPNetworkHelper GET:aURL
        parameters:parameters ?: @{}
        success:^(id responseObject) {
            if (success) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"code"] integerValue] == 15000 || [result[@"code"] integerValue] == 16007) {
                        [self errorCode:15000];
                        return;
                    }
                }
                success(responseObject);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }

            if (failure) {
                failure(error);
            }
        }];
}

+ (void)POSTWithHead:(NSString *)URLString parameters:(id)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *aURL = [self dealNormalUrl:URLString];

    [PPNetworkHelper POST:aURL
        parameters:parameter
        success:^(id responseObject) {
            if (success) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"code"] integerValue] == 15000 || [result[@"code"] integerValue] == 16007) {
                        [self errorCode:15000];
                        return;
                    }
                }
                success(responseObject);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }
            if (failure) {
                failure(error);
            }
        }];
}

+ (void)POST:(NSString *)URLString requestSerializer:(BOOL)requestSerializer parameters:(id)parameter
              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure {
    [PPNetworkHelper POST:URLString
        serializer:requestSerializer
        parameters:parameter
        success:^(id responseObject) {
            if (success) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"code"] integerValue] == 15000 || [result[@"code"] integerValue] == 16007) {
                        [self errorCode:15000];
                        return;
                    }
                }
                success(responseObject);
            }
        }
        failure:^(NSError *error) {
            if ([error.localizedDescription containsString:@"(401)"]) {
                [self errorCode:401];
                return;
            }
            if ([error.localizedDescription containsString:@"(503)"]) {
                [self errorCode:503];
                return;
            }
            if (failure) {
                failure(error);
            }
        }];
}

+ (NSString *)dealNormalUrl:(NSString *)urlStr {
    if ([urlStr hasPrefix:@"/"] || [urlStr hasPrefix:@"space-/"] || [urlStr hasPrefix:@"space-null/"]) {
        NSRange range = [urlStr rangeOfString:@"/"];
        return [NSString stringWithFormat:@"%@%@", BaseURL, [urlStr substringFromIndex:range.location + range.length]];
    }
    else {
        return [urlStr containsString:@"//"] ? urlStr : [NSString stringWithFormat:@"%@%@", BaseURL, urlStr];
    }
}

@end
