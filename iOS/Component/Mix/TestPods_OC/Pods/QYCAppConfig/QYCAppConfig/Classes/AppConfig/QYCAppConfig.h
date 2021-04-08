//
//  QYCEnvConfig.h
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/5/15.
//  Copyright © 2020 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///<DEBUG持久化保存域名key
FOUNDATION_EXTERN NSString *const EnvCurrKey;
FOUNDATION_EXTERN NSString *const RCloudDebugKey;

#define BaseURL [[QYCAppConfig shareConfig] appCurrentUrlEnv]

/// app环境Url
@interface QYCAppConfig : NSObject

/// 初始化
+ (instancetype)shareConfig;
#pragma mark - env
///当前URL环境
- (NSString *)appCurrentUrlEnv;

/// 附件地址
- (NSString *)appFileDomain;

/// 当前app的是所有环境
- (NSArray *)appEnvs;
#pragma mark - base info
/// 当前产品名称
- (NSString *)appCurrentName;

/// BundleId
- (NSString *)appBundleId;

/// 版本
- (NSString *)appVersion;

/// 构建版本
- (NSString *)appBuildVersion;

/// AppStore ID
- (NSString *)appStoreID;

/// AppStore地址
- (NSString *)appStoreUrl;

/// share group
- (NSString *)appShareExtensionGroup;

///share extension Sheme
- (NSString *)appShareURLScheme;

/// 加入启聊 Sheme
- (NSString *)appApplyjoinURLScheme;

/// 《隐私协议》
- (NSString *)appPrivacyURL;

/// 《用户协议》
- (NSString *)appUseragreementURL;

/// 登录logo（废弃）
- (NSString *)appLoginLogo;

/// UmengKey
- (NSString *)appUmengKey;

/// Umeng分享appkey
- (NSDictionary *)appShareKey;
/// 百度key
- (NSString *)appBaiduKey;

/// 融云debugKey
- (NSString *)rongCloud_debugKey;

/// 融云debugKey
- (NSString *)rongCloud_releaseKey;

/// 打开高德Scheme
- (NSString *)gaodeAppURLScheme;

/// 直播debugKey
- (UInt32)videoLive_debugKey;

/// 直播releaseKey
- (UInt32)videoLive_releaseKey;

/// 微信支付的key
- (NSString *)WCPayKey;

/// bugly的key
- (NSString *)buglyKey;

#pragma mark - 配置功能

/// 是否开启第三方登录功能
- (BOOL)appOpenThirdLogin;

/// 是否开启检测AppStore更新功能
- (BOOL)appOpenAppStoreUpdate;

/// 是否显示启动页
- (BOOL)appOpenLaunchImageVC;

/// 个人设置页配置
- (NSArray *)profileItemConfig;

/// 是否开启全局配置的头像
- (BOOL)appOpenGlobalUserHeader;


#pragma mark - 配置模块

/// 配置的集成模块
- (NSArray *)appConfigModules;

/// 首页默认展示模块
- (NSArray *)appHomeDefalutModules;

#pragma mark - 辅助

/// debug启聊的单点登录
- (BOOL)appIMDebugSingleLogin;

/// debug启聊的key
- (NSString *)appCustomRCDebugKey;

@end

NS_ASSUME_NONNULL_END
