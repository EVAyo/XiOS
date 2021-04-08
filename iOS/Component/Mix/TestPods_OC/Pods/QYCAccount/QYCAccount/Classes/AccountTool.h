//
//  AccountTool.h
//  Qiyeyun
//
//  Created by 钱立新 on 15/11/19.
//  Copyright © 2015年 钱立新. All rights reserved.
//  专门处理账号的业务（账号存储和读取）

#import "Account.h"
#import <Foundation/Foundation.h>
#import <YYCache/YYDiskCache.h>
@interface AccountTool : NSObject

@property (nonatomic, strong) YYDiskCache *cache;

+ (void)saveLoginSuccessDataWithData:(NSDictionary *)data;

//保存登陆返回信息
+ (void)saveAccount:(Account *)account;

//获取登陆返回信息
+ (Account *)account;
/**
 *  发送评论
 *
 *  @param success 成功时回调
 *  @param failure 失败时回调
 */
//+ (void)accountWithSendCommentParamer:(NSDictionary *)paramer Success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 发送评论 + 企业ID

 @param paramer 参数
 @param entid 企业ID
 @param success 成功时回调
 @param failure 失败时回调
 */
//+ (void)accountWithSendCommentParamer:(NSDictionary *)paramer entId:(NSString *)entid Success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  切换信息
 *
 *  @param success 成功时回调
 *  @param failure 失败时回调
 */
//+ (void)accountWithChangeInfoWithEntId:(NSString *)entId success:(void (^)(id data))success failure:(void (^)(NSError *error))failure;
/**
 *  托管状态的切换
 *
 *  @param success 成功时回调
 *  @param failure 失败时回调
 */
//+ (void)accountWithTrustStatusChangeParamer:(NSDictionary *)paramer Success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  关闭托管
 *
 *  @param success 成功时回调
 *  @param failure 失败时回调
 */
//+ (void)accountWithCloseTrustSuccess:(void (^)(id data))success failure:(void (^)(NSError *error))failure;
/**
 *  托管状态
 *
 *  @param success 成功时回调
 *  @param failure 失败时回调
 */
//+ (void)accountWithTrustStatusSuccess:(void (^)(id data))success failure:(void (^)(NSError *error))failure;
/**
 *  用户托管
 *
 *  @param success 成功时回调
 *  @param failure 失败时回调
 */
//+ (void)accountWithTrustParamer:(NSDictionary *)paramer Success:(void (^)(NSNumber *num, id data))success failure:(void (^)(NSError *error))failure;
/**
 *  登录请求
 *
 *  @param success 成功时回调
 *  @param failure 失败时回调
 */
//+ (void)accountWithLoginName:(NSString *)userName passWord:(NSString *)paw success:(void (^)(NSNumber *succ, id data, id verify))success failure:(void (^)(NSError *error))failure;

/**
 *  请求个人信息
 *
 *  @param success 成功时回调
 *  @param failure 失败时回调
 */
//+ (void)accountWithPersonalInfo:(NSString *)url Success:(void (^)(NSNumber *succ, NSDictionary *dic))success failure:(void (^)(NSError *error))failure;

/**
 *  上传图片
 *
 *  @param Urlstr     上传地址
 *  @param image      待上传的图片
 *  @param imageName  待上传的图片的名称
 *  @param success    成功时回调
 *  @param failure    失败时回调
 */
//+ (void)UploadPhotoWithURLStr:(NSString *)Urlstr image:(UIImage *)image pramer:(NSDictionary *)prame Success:(void (^)(NSNumber *succ, NSString *avatar))success failure:(void (^)(NSError *error))failure;

/**
 *  修改密码
 *
 *  @param success 成功时回调
 *  @param failure 失败时回调
 */
//+ (void)accountWithModifyPasswordParamer:(NSDictionary *)paramer Success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/// 管理员注册的用户，首次登录强制修改密码。
/// @param paramer 入参
/// @param success 成功时回调
/// @param failure 失败时回调
//+ (void)accountWithForceModifyPasswordParamer:(NSDictionary *)paramer Success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 检查当前用户是否在群组中

 @param groupId 群组Id
 @param entId 企业Id
 @param success 成功时回调
 @param failure 失败时回调
 */
//+ (void)checkUserInGroup:(NSString *)groupId entId:(NSString *)entId Success:(void (^)(BOOL succ, BOOL exist, NSString *groupName, NSString *msg))success failure:(void (^)(NSError *error))failure;

/**
 用户屏蔽某条工作圈帖子
 
 @param postId 帖子Id
 @param block 结果回调
 */
//+ (void)shildPost:(NSString *)postId Block:(void (^)(BOOL succ))block;

/**
 用户屏蔽某条工作圈帖子

 @param postId 帖子Id
 @param entId 企业ID
 @param block 结果回调
 */
//+ (void)shildPost:(NSString *)postId entId:(NSString *)entId Block:(void (^)(BOOL succ))block;

/**
 检测某个用户的g动态是否被当前用户不再关注
 
 @param userId 被检测的用户Id
 @param entId  企业id
 @param block 结果回调
 */
//+ (void)checkUserBlocked:(NSString *)userId entId:(NSString *)entId Block:(void (^)(BOOL succ, BOOL status))block;

///**
// 是否关注某个用户的工作圈动态
//
// @param userId 不在关注的用户Id
// @param isBlock 是否不关注，YES：不关注， NO：关注
// @param block 结果回调
// */
//+ (void)shieldingbUser:(NSString *)userId isBlack:(BOOL)isBlack entId:(NSString *)entId Block:(void (^)(BOOL succ))block;
///**
// 是否关注某个用户的工作圈动态
//
// @param userId 不在关注的用户Id
// @param entId 企业ID
// @param isBlack 是否不关注，YES：不关注， NO：关注
// @param block 结果回调
// */
//+ (void)shieldingbUser:(NSString *)userId entId:(NSString *)entId isBlack:(BOOL)isBlack Block:(void (^)(BOOL succ))block;

/**
 获取工作圈的未读数数

 @param reddot 是否查询小红点
// */
//+ (void)getWorkCircleUnreadNum:(BOOL)reddot complete:(void (^)(BOOL succ, NSInteger status))complete;
///**
// 获取工作圈的未读数数
//
// @param reddot 是否查询小红点
// @param entId 企业ID
// @param complete 结果回调
// */
//+ (void)getWorkCircleUnreadNum:(BOOL)reddot entId:(NSString *)entId complete:(void (^)(BOOL succ, NSInteger status))complete;

/// 获取消息提醒中心未读数据（默认都是红点显示）
/// @param entId 企业ID
/// @param complete 结果回调
//+ (void)getPlatformRemindsUnreadNumWithEntId:(NSString *)entId complete:(void (^)(BOOL succ, NSInteger status))complete;

////获取预览服务
//+ (void)filePreviewServiceRequest;
////获取预览服务支持的文件类型
//+ (void)filePreviewTypesRequest;
@end
