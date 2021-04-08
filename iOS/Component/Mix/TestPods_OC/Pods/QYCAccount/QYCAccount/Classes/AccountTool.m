//
//  AccountTool.m
//  Qiyeyun
//
//  Created by 钱立新 on 15/11/19.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import "AccountTool.h"
//#import "AFNetworking.h"
//#import "AllURLHeader.h"
//#import "CacheTool.h"
//#import "LoginViewController.h"
//#import "MBProgressHUD+CZ.h"
#import "MJExtension.h"
//#import "NET.h"
//#import "NSString+AEScode.h"
//#import "QYCForceUpdateViewController.h"
//#import "QYCRememberAccountTools.h"
//#import "QYCToast.h"
//#import "QYCWeakPasswordTool.h"
//#import "WorkCircleStatusModel.h"
//#import <QYCAppConfig/QYCAppConfig.h>
//#import <RongIMKit/RongIMKit.h>
//#import <YYKit/NSString+YYAdd.h>

#define KFileDomaumentDir(fileName) [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:fileName]

@interface AccountTool ()

@end

@implementation AccountTool

+ (void)saveAccount:(Account *)account {
    if (@available(iOS 11.0, *)) {
        NSError *error = nil;
        NSData *data   = [NSKeyedArchiver archivedDataWithRootObject:account requiringSecureCoding:YES error:&error];
        //        [CacheTool createFileAtPath:KFileDomaumentDir(@"cache/account.data") contents:data overwrite:YES error:&error];
        NSString *directoryPath = [KFileDomaumentDir(@"cache/account.data") stringByDeletingLastPathComponent];
        if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath]) {
            // 创建文件夹
            NSFileManager *manager = [NSFileManager defaultManager];
            BOOL isSuccess         = [manager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:NULL];
        }
        BOOL isSuccess = [[NSFileManager defaultManager] createFileAtPath:KFileDomaumentDir(@"cache/account.data") contents:data attributes:nil];
    }
    else {
        [NSKeyedArchiver archiveRootObject:account toFile:KFileDomaumentDir(@"cache/account.data")];
    }
}

+ (Account *)accountEntrust {
    AccountTool *tool = [[AccountTool alloc] init];
    Account *model    = (Account *)[tool.cache objectForKey:@"entrust"];
    return model;
}

+ (Account *)account {
    if (@available(iOS 11.0, *)) {
        NSError *error  = nil;
        NSData *newData = [NSData dataWithContentsOfFile:KFileDomaumentDir(@"cache/account.data")];
        return [NSKeyedUnarchiver unarchivedObjectOfClass:[Account class] fromData:newData error:&error];
    }
    else {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:KFileDomaumentDir(@"cache/account.data")];
    }
}

- (YYDiskCache *)cache {
    if (!_cache) {
        NSArray *paths       = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        NSString *cachePatch = [paths.firstObject stringByAppendingPathComponent:@"cache/allAddressBook"];
        _cache               = [[YYDiskCache alloc] initWithPath:cachePatch];
        _cache.ageLimit      = 3 * 60 * 60;
    }
    return _cache;
}

#pragma mark 网络请求
//发送评论
//+ (void)accountWithSendCommentParamer:(NSDictionary *)paramer Success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
//    [NET POST:send_comment_url
//        parameters:paramer
//           success:^(id responseObject) {
//               NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//               if ([dic[@"status"] isEqual:@1200]) {
//                   success(dic);
//               }
//           }
//           failure:^(NSError *error){
//
//           }];
//}
// 发送评论 + 企业ID
//+ (void)accountWithSendCommentParamer:(NSDictionary *)paramer entId:(NSString *)entid Success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
//    NSString *url = [NSString stringWithFormat:@"%@/%@", entid, send_comment_url];
//    [NET POST:url
//        parameters:paramer
//           success:^(id responseObject) {
//               NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//               if ([dic[@"status"] isEqual:@1200]) {
//                   success(dic);
//               }
//           }
//           failure:^(NSError *error){
//
//           }];
//}

//切换信息
//+ (void)accountWithChangeInfoWithEntId:(NSString *)entId success:(void (^)(id data))success failure:(void (^)(NSError *error))failure {
//    NSString *url = [NSString stringWithFormat:@"%@/%@", entId, change_info_Url];
//    [NET GET:url
//        parameters:@{}
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if ([dic[@"status"] isEqual:@200]) {
//                success(dic[@"result"]);
//            }
//        }
//        failure:^(NSError *error) {
//            if (failure)
//                failure(error);
//        }];
//}
//托管状态的切换
//+ (void)accountWithTrustStatusChangeParamer:(NSDictionary *)paramer Success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
//    [NET POST:trust_status_change_Url
//        parameters:paramer
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
//            if (success) {
//                success(dic);
//            }
//        }
//        failure:^(NSError *error) {
//            failure(error);
//        }];
//}
//托管的状态
//+ (void)accountWithTrustStatusSuccess:(void (^)(id data))success failure:(void (^)(NSError *error))failure {
//    [NET GET:trust_status_Url1
//        parameters:@{}
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            success(dic);
//        }
//        failure:^(NSError *error) {
//            failure(error);
//        }];
//}

//+ (void)accountWithCloseTrustSuccess:(void (^)(id data))success failure:(void (^)(NSError *error))failure {
//    [NET GET:close_trust_url
//        parameters:@{}
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
//            if (success) {
//                success(dic);
//            }
//        }
//        failure:^(NSError *error) {
//            if (failure)
//                failure(error);
//        }];
//}

//用户托管的请求
//+ (void)accountWithTrustParamer:(NSDictionary *)paramer Success:(void (^)(NSNumber *num, id data))success failure:(void (^)(NSError *error))failure {
//    [NET POST:trust_Url
//        parameters:paramer
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
//            if (success) {
//                success(dic[@"success"], dic);
//            }
//        }
//        failure:^(NSError *error) {
//            failure(error);
//        }];
//}

+ (void)saveLoginSuccessDataWithData:(NSDictionary *)data {
    //记住登录账户UserId,用于切换隐藏
    [[NSUserDefaults standardUserDefaults] setObject:data[@"result"][@"userId"] forKey:@"loginAccount"];
    [[NSUserDefaults standardUserDefaults] setObject:data[@"microServiceToken"] forKey:@"loginmicroServiceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // 字典转模型
    //Account *account = [Account accountWithDict:data[@"result"]];
    Account *account = [Account mj_objectWithKeyValues:data[@"result"]];
    // 保存账号信息 以后不用归档，用数据库，直接改业务类
    [AccountTool saveAccount:account];

    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        if ([cookie.name isEqualToString:@"PHPSESSID"]) {
            //存储归档后的cookie
            [[NSUserDefaults standardUserDefaults] setObject:cookie.properties forKey:@"PHPCookie"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

////登陆请求
//+ (void)accountWithLoginName:(NSString *)userName passWord:(NSString *)paw success:(void (^)(NSNumber *succ, id data, id verify))success failure:(void (^)(NSError *error))failure {
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (id obj in [cookieJar cookies]) {
//        [cookieJar deleteCookie:obj];
//    }
//
//    [NET requestWithMethod:@"GET"
//        URLStr:Token_Url
//        parameters:nil
//        success:^(id _Nullable tokenDic) {
//            if (!tokenDic || !tokenDic[@"result"]) { //
//                if (success) {
//                    success(@0, @"链接异常，请检查网络", nil);
//                }
//                return;
//            }
//            if ([tokenDic[@"status"] integerValue] == 2101) {
//                if (success) {
//                    success(tokenDic[@"status"], nil, nil);
//                }
//                return;
//            }
//
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//            NSString *passWd          = [NSString AESPassword:userName password:paw withToken:tokenDic[@"result"]];
//            [dict setObject:tokenDic[@"result"] forKey:@"token"];
//            NSString *name = [userName isNotBlank] ? userName : @"";
//            [dict setObject:passWd forKey:@"password"];
//            [dict setObject:name forKey:@"username"];
//            [dict setObject:@"true" forKey:@"ismobile"];
//            [dict setObject:@"true" forKey:@"rememberMe"];
//#ifndef __OPTIMIZE__
//            [dict setObject:@"1"
//                     forKey:@"isadmin"];
//#else
//#endif
//
//            [NET POST:LoginBase_Url
//                parameters:dict
//                success:^(id responseObject) {
//                    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                    if ([data[@"status"] integerValue] == 402) {
//                        if (success) {
//                            success(data[@"status"], data[@"msg"], nil);
//                        }
//                    }
//                    else if ([data[@"status"] integerValue] == 200) {
//                        // 首次登录是否需要强制修改密码
//                        NSNumber *firstPswChange = data[@"result"][@"firstPswChange"];
//                        if ([firstPswChange boolValue]) {
//                            if (success) {
//                                success(
//                                    data[@"status"], @{@"firstPswChange" : @YES}, nil);
//
//                                NSString *currentAccount = [QYCRememberAccountTools getCurrentLoginAccount];
//                                NSString *userId         = data[@"result"][@"userId"];
//                                [QYCRememberAccountTools saveLoginAccount:currentAccount userId:userId];
//                                return;
//                            }
//                        }
//
//                        //记住登录账户UserId,用于切换隐藏
//                        [Kdefaults setObject:data[@"result"][@"userId"] forKey:@"loginAccount"];
//                        [Kdefaults setObject:data[@"microServiceToken"] forKey:KLOGINTOKEN];
//                        [Kdefaults synchronize];
//
//                        // ShareExtension功能，登录成功，记录状态 add by linx for 2019.11_2：ShareExtension优化
//                        NSUserDefaults *shareUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:[QYCAppConfig shareConfig].appShareExtensionGroup];
//                        [shareUserDefaults setValue:@YES forKey:@"LoginStatusForShareExtension"];
//
//                        // 字典转模型
//                        Account *account = [Account mj_objectWithKeyValues:data[@"result"]];
//                        // 保存账号信息 以后不用归档，用数据库，直接改业务类
//                        [AccountTool saveAccount:account];
//
//                        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//                            if ([cookie.name isEqualToString:@"PHPSESSID"]) {
//                                //存储归档后的cookie
//                                [Kdefaults setObject:cookie.properties forKey:PHPCookie];
//                                [Kdefaults synchronize];
//                            }
//                        }
//
//                        if (success) {
//                            success(data[@"status"], nil, data[@"result"][@"verify_two"]);
//                        }
//                        NSString *currentAccount = [QYCRememberAccountTools getCurrentLoginAccount];
//                        NSString *userId         = data[@"result"][@"userId"];
//                        [QYCRememberAccountTools saveLoginAccount:currentAccount userId:userId];
//                    }
//                    else {
//                        if (success)
//                            success(data[@"status"], data[@"msg"], nil);
//                    }
//                }
//                failure:^(NSError *error) {
//                    if (failure)
//                        failure(error);
//                }];
//        }
//        failure:^(NSError *_Nullable error) {
//            if (failure) {
//                failure(error);
//            }
//        }];
//}

//+ (void)accountWithPersonalInfo:(NSString *)url Success:(void (^)(NSNumber *succ, NSDictionary *dic))success failure:(void (^)(NSError *error))failure {
//    [NET GET:url
//        parameters:nil
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            [QYCWeakPasswordTool handleWeakPasswordAndVerifyTwoWithDict:dic];
//            if (success) {
//                if ([dic[@"status"] integerValue] == 200) {
//                    success(dic[@"status"], dic[@"result"]);
//                }
//                else if ([dic[@"status"] integerValue] == 2101) {
//                    [QYCForceUpdateViewController forceUpdate];
//                    return;
//                }
//                else {
//                    success(dic[@"status"], dic[@"msg"]); //错误信息不太确定，待修改
//                }
//            }
//        }
//        failure:^(NSError *error) {
//            if (failure) {
//                failure(error);
//            }
//        }];
//}

//上传图片  status = 1200成功
//+ (void)UploadPhotoWithURLStr:(NSString *)Urlstr image:(UIImage *)image pramer:(NSDictionary *)prame Success:(void (^)(NSNumber *, NSString *))success failure:(void (^)(NSError *))failure {
//    // 创建上传的模型
//    NSDictionary *upload = @{@"data" : UIImageJPEGRepresentation(image, 0.9),
//                             @"name" : @"Filedata",
//                             @"fileName" : @"filename.jpg",
//                             @"uploadType" : @"image/jpg"};
//
//    [NET Upload:Urlstr
//        parameter:prame
//        uploadParam:@[ upload ]
//        success:^(id responseObject) {
//            if (success) {
//                success(responseObject[@"status"], responseObject[@"avatar"]);
//            }
//        }
//        failure:^(NSError *error) {
//            if (failure) {
//                failure(error);
//            }
//        }];
//}

//修改密码
//+ (void)accountWithModifyPasswordParamer:(NSDictionary *)paramer Success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
//    [NET POST:modifyPassword_Url
//        parameters:paramer
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
//            if (success) {
//                success(dic);
//            }
//        }
//        failure:^(NSError *error) {
//            failure(error);
//        }];
//}

/// 管理员注册的用户，首次登录强制修改密码。
//+ (void)accountWithForceModifyPasswordParamer:(NSDictionary *)paramer Success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
//    [NET POST:forceModifyPassword_Url
//        parameters:paramer
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if (success) {
//                success(dic);
//            }
//        }
//        failure:^(NSError *error) {
//            failure(error);
//        }];
//}

////检查当前用户是否在群组中
//+ (void)checkUserInGroup:(NSString *)groupId entId:(NSString *)entId Success:(void (^)(BOOL, BOOL, NSString *, NSString *))success failure:(void (^)(NSError *))failure {
//    NSString *url = [NSString stringWithFormat:@"%@/%@", entId, checkUseringGroup];
//    Account *acc  = [AccountTool account];
//    [NET POST:url
//        parameters:@{@"data" : [@{@"groupId" : groupId, @"entId" : acc.entId} jsonStringEncoded]}
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if ([dic[@"status"] integerValue] == 200) {
//                if ([dic[@"code"] integerValue] == 1200) { //不在群组
//                    success(YES, NO, dic[@"result"][@"groupName"], nil);
//                }
//                else if ([dic[@"code"] integerValue] == 1000) { //在群组中
//                    success(YES, YES, dic[@"result"][@"groupName"], dic[@"msg"]);
//                }
//                else if ([dic[@"code"] integerValue] == 1100) { //群组已经解散
//                    success(NO, NO, nil, dic[@"msg"]);
//                }
//                else if ([dic[@"code"] integerValue] == 1400) { //不在当前企业
//                    success(NO, NO, nil, dic[@"msg"]);
//                }
//            }
//            else {
//                success(NO, NO, nil, dic[@"msg"]);
//            }
//        }
//        failure:^(NSError *error) {
//            failure(error);
//        }];
//}

//用户屏蔽某条工作圈帖子
//+ (void)shildPost:(NSString *)postId Block:(void (^)(BOOL succ))block {
//    [NET Put:shildPostStatue
//        parameter:@{@"postId" : postId}
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if ([dic[@"status"] longLongValue] == 1000000) {
//                block(YES);
//            }
//            else {
//                block(NO);
//            }
//        }
//        failure:^(NSError *error) {
//            block(NO);
//        }];
//}

//+ (void)shildPost:(NSString *)postId entId:(NSString *)entId Block:(void (^)(BOOL succ))block {
//    NSString *url = [NSString stringWithFormat:@"%@/%@", entId, shildPostStatue];
//    [NET Put:url
//        parameter:@{@"postId" : postId}
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if ([dic[@"status"] longLongValue] == 1000000) {
//                block(YES);
//            }
//            else {
//                block(NO);
//            }
//        }
//        failure:^(NSError *error) {
//            block(NO);
//        }];
//}

//检测某个用户的g动态是否被当前用户不再关注
//+ (void)checkUserBlocked:(NSString *)userId entId:(NSString *)entId Block:(void (^)(BOOL succ, BOOL status))block {
//    NSString *url = [NSString stringWithFormat:@"%@/%@", entId, getBlockListStatue];
//    [NET GET:url
//        parameters:@{@"checkUserId" : userId}
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if ([dic[@"status"] integerValue] == 1000000) {
//                block(YES, [dic[@"data"] boolValue]);
//            }
//            else {
//                block(NO, NO);
//            }
//        }
//        failure:^(NSError *error) {
//            block(NO, NO);
//        }];
//}

////是否关注某个用户的工作圈动态
//+ (void)shieldingbUser:(NSString *)userId isBlack:(BOOL)isBlack entId:(NSString *)entId Block:(void (^)(BOOL succ))block {
//    NSString *url = [NSString stringWithFormat:@"%@/%@", entId, saveBlockListStatue];
//    [NET POST:url
//        parameters:@{@"blackUserId" : userId, @"isBlack" : @(isBlack)}
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if ([dic[@"status"] longLongValue] == 1000000) {
//                block([dic[@"data"] boolValue]);
//            }
//            else {
//                block(NO);
//            }
//        }
//        failure:^(NSError *error) {
//            block(NO);
//        }];
//}
//
//+ (void)shieldingbUser:(NSString *)userId entId:(NSString *)entId isBlack:(BOOL)isBlack Block:(void (^)(BOOL succ))block {
//    NSString *url = [NSString stringWithFormat:@"%@/%@", entId, saveBlockListStatue];
//    [NET POST:url
//        parameters:@{@"blackUserId" : userId, @"isBlack" : @(isBlack)}
//        success:^(id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if ([dic[@"status"] longLongValue] == 1000000) {
//                block([dic[@"data"] boolValue]);
//            }
//            else {
//                block(NO);
//            }
//        }
//        failure:^(NSError *error) {
//            block(NO);
//        }];
//}

// 获取工作圈的未读数数
//+ (void)getWorkCircleUnreadNum:(BOOL)reddot complete:(void (^)(BOOL succ, NSInteger status))complete {
//    NSString *url = getUnreadCount;
//    if (reddot) {
//        url = [NSString stringWithFormat:@"%@?red=1", getUnreadCount];
//    }
//    [NET GET:url
//        parameters:nil
//        success:^(id responseObject) {
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if ([dict[@"status"] integerValue] == 200) {
//                NSInteger result = [dict[@"result"] integerValue];
//                complete(YES, result);
//            }
//            else {
//                complete(NO, 0);
//            }
//        }
//        failure:^(NSError *error) {
//            complete(NO, 0);
//        }];
//}
//
//+ (void)getWorkCircleUnreadNum:(BOOL)reddot entId:(NSString *)entId complete:(void (^)(BOOL succ, NSInteger status))complete {
//    NSString *url = @"";
//    if (reddot) {
//        url = [NSString stringWithFormat:@"%@/%@?red=1", entId, getUnreadCount];
//    }
//    else {
//        url = [NSString stringWithFormat:@"%@/%@", entId, getUnreadCount];
//    }
//    [NET GET:url
//        parameters:nil
//        success:^(id responseObject) {
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if ([dict[@"status"] integerValue] == 200) {
//                NSInteger result = [dict[@"result"] integerValue];
//                complete(YES, result);
//            }
//            else {
//                complete(NO, 0);
//            }
//        }
//        failure:^(NSError *error) {
//            complete(NO, 0);
//        }];
//}

/// 获取消息提醒中心未读数据
//+ (void)getPlatformRemindsUnreadNumWithEntId:(NSString *)entId complete:(void (^)(BOOL succ, NSInteger status))complete {
//    NSString *url = [NSString stringWithFormat:@"%@/%@", entId, PlatformReminds_GetUnReadMessageCount];
//    [NET GET:url
//        parameters:nil
//        success:^(id responseObject) {
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if ([dict[@"status"] integerValue] == 200 && [dict[@"code"] integerValue] == 200) {
//                NSInteger newUnread = [dict[@"result"][@"newUnread"] integerValue];
//                complete(YES, newUnread);
//            }
//            else {
//                complete(NO, 0);
//            }
//        }
//        failure:^(NSError *error) {
//            complete(NO, 0);
//        }];
//}

//+ (void)filePreviewServiceRequest {
//    NSString *url = [NSString stringWithFormat:@"%@", FilePreviewService];
//    [NET GET:url
//        parameters:nil
//        success:^(id _Nullable responseObject) {
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//            if (dict[@"result"] && [dict[@"result"] isKindOfClass:[NSString class]]) {
//                [Kdefaults setObject:dict[@"result"] forKey:@"QYC_PreviewService"];
//            }
//            else {
//                [Kdefaults setObject:@"" forKey:@"QYC_PreviewService"];
//            }
//        }
//        failure:^(NSError *_Nullable error) {
//            [Kdefaults setObject:@"" forKey:@"QYC_PreviewService"];
//        }];
//}
//
//+ (void)filePreviewTypesRequest {
//    NSString *url = [NSString stringWithFormat:@"%@", FilePreviewTypes];
//    [NET GET:url
//        parameters:nil
//        success:^(id _Nullable responseObject) {
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//            if ([dict[@"code"] integerValue] == 200 && [dict[@"result"] isKindOfClass:[NSArray class]]) {
//                [Kdefaults setObject:dict[@"result"] forKey:@"QYC_PreviewTypes"];
//            }
//            else {
//                [Kdefaults setObject:@[] forKey:@"QYC_PreviewTypes"];
//            }
//        }
//        failure:^(NSError *_Nullable error) {
//            [Kdefaults setObject:@"" forKey:@"QYC_PreviewTypes"];
//        }];
//}

@end
