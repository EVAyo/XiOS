//
//  QYCEnvConfig.m
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/5/15.
//  Copyright © 2020 安元. All rights reserved.
//

#import "QYCAppConfig.h"

NSString *const EnvCurrKey = @"envConfigKey";
NSString *const RCloudDebugKey = @"RCloudDebugKey";
NSString *const IMSingleLoginKey = @"IMSingleLoginKey";


/// 安全性考虑，key的规则为第二位开始插入三位随机数
/// @param key
NSString * getRealKey(NSString * key) {
    //当key的长度
    if (key.length < 5) {
        return key;
    }
    NSMutableString *realKey = [[NSMutableString alloc] initWithString:key];
    [realKey replaceCharactersInRange:NSMakeRange(2, 3) withString:@""];
    return realKey.copy;
}


@implementation QYCAppConfig

+ (instancetype)shareConfig {
    static QYCAppConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config             = [QYCAppConfig new];
    });
    return config;
}

- (NSString *)appCurrentUrlEnv {
    NSString *baseURL;
    #ifdef DEBUG
        if ([[NSUserDefaults standardUserDefaults] objectForKey:EnvCurrKey]) {
            baseURL = [[NSUserDefaults standardUserDefaults] objectForKey:EnvCurrKey];
            return baseURL.length > 0 ? baseURL : @"https://www.qycloud.com.cn/";
        }
    #endif
    baseURL = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_domain"];
    if (!baseURL || [baseURL isEqualToString:@""]) {
        return @"https://www.qycloud.com.cn/";
    }
    return baseURL;
}


- (NSString *)appFileDomain {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_file_domain"]?:@"";
}

- (NSString *)appCurrentName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_displayName"]?:@"";
}

- (NSArray *)appEnvs {
    return @[@"https://www.qycloud.com.cn/",@"http://wwwrelease.qycloud.com.cn/",@"https://hotfix.qycloud.com.cn/",@"http://www172168000071.pinwheel.qycloud.com.cn:39000/"];
}

- (NSString *)appBundleId {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_bundleId"]?:@"";
}

- (NSString *)appStoreID {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_appStoreId"]?:@"";
}

- (NSString *)appStoreUrl {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_appStoreURL"]?:@"";
}

- (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_version"]?:@"";
}

- (NSString *)appBuildVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_buildVersion"]?:@"";
}

/// share group
- (NSString *)appShareExtensionGroup {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_appGroup"]?:@"";
}

///share extension Sheme
- (NSString *)appShareURLScheme {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_shareURLScheme"]?:@"";
}

/// 加入启聊 Sheme
- (NSString *)appApplyjoinURLScheme {
   return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_applyjoinURLScheme"]?:@"";
}

- (NSString *)appPrivacyURL {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_privacyURL"]?:@"";
}

- (NSString *)appUseragreementURL {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_useragreementURL"]?:@"";;
}

- (BOOL)appOpenThirdLogin {
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_function_thirdLogin"]?:@"";
    if ([value isEqualToString:@"true"]) {
        return  YES;
    }else if ([value isEqualToString:@"false"]) {
        return  NO;
    }
    return NO;
}

- (NSString *)appLoginLogo {
    return @"LogoTitle";
}

- (NSString *)appUmengKey {
//    #if defined(PROJECTTYPE) || defined(PROJECTTYPE_Pre)
//        #define UMSOCIALKEY @"577629de67e58e6bcb001eef"
//    #elif defined PROJECTTYPE_INDUSTRY
//        #define UMSOCIALKEY @"58d8c815a40fa37ff900075a"
//    #elif defined PROJECTTYPE_NM
//        #define UMSOCIALKEY @"5bf50096b465f5eb2700001e"
//    #elif defined(PROJECTTYPE_SAFETY) || defined(PROJECTTYPE_SAFETYPRE)
//        #define UMSOCIALKEY @"5965be5c1061d20a150002c2"
//    #endif
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_um"]?:@"";
    return getRealKey(value);

}
- (NSDictionary *)appShareKey {
    NSMutableDictionary *dict =   [[NSMutableDictionary alloc] init];
    dict[@"QYC_WXAPK"]        =   [self mainBundleKey:@"QYC_WXAPK"];
    dict[@"QYC_WXSCT"]        =   [self mainBundleKey:@"QYC_WXSCT"];
    dict[@"QYC_QAPK"]         =   [self mainBundleKey:@"QYC_QAPK"];
    dict[@"QYC_QSCT"]         =   [self mainBundleKey:@"QYC_QSCT"];
    dict[@"QYC_SNAPK"]        =   [self mainBundleKey:@"QYC_SNAPK"];
    dict[@"QYC_SNSCT"]        =   [self mainBundleKey:@"QYC_SNSCT"];
    return dict;
}
- (id)mainBundleKey:(NSString *)key {
    id value = [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
    if ([value isKindOfClass:NSString.class]) {
        return getRealKey((NSString *)value);
    }
    return value;
}
- (NSString *)appBaiduKey {
//    #ifdef PROJECTTYPE
//        #define BAIDUMAP_KEY @"ZDj9aY81pR8TZ9G3tahMRg1th9zovdpF"
//    #elif defined PROJECTTYPE_Pre
//        #define BAIDUMAP_KEY @"pYlTeR2cnIUZXbZfGBKnba0ZODGaGllz"
//    #elif defined PROJECTTYPE_INDUSTRY
//        #define BAIDUMAP_KEY @"SxbopnG5L0A95l6ztlgZTNot0EM72817"
//    #elif defined PROJECTTYPE_SAFETY
//        #define BAIDUMAP_KEY @"xmWla8QOCh3eOy3RsqW1XAtooY9R3ldQ"
//    #elif defined PROJECTTYPE_SAFETYPRE
//        #define BAIDUMAP_KEY @"kXR60AS9unNY51tknmRgLtssRgQjThAl"
//    #elif defined PROJECTTYPE_NM
//        #define BAIDUMAP_KEY @"Kz6o6xglpkKumMgo1xUfiIjztd0i2WwE"
//    #else
//        #define BAIDUMAP_KEY @"ZDj9aY81pR8TZ9G3tahMRg1th9zovdpF"
//    #endif
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_bd"]?:@"";
    return getRealKey(value);
}

- (NSString *)rongCloud_debugKey {
#ifdef DEBUG
    if ([self appCustomRCDebugKey] && ![[self appCustomRCDebugKey] isEqual:@""]) {
        return [self appCustomRCDebugKey];
    }
#endif
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_rcd"]?:@"";
    return getRealKey(value);

}

- (NSString *)rongCloud_releaseKey {
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_rcr"]?:@"";
    return getRealKey(value);

}

- (UInt32)videoLive_debugKey {
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_vld"]?:@"";
    return [getRealKey(value) intValue];
}

- (NSString *)buglyKey {
//    // 启业云
//    #if defined(PROJECTTYPE) || defined(PROJECTTYPE_Pre)
//    [Bugly startWithAppId:@"7f152aceb0"];
//    // 安全无忧
//    #elif defined(PROJECTTYPE_SAFETY) || defined(PROJECTTYPE_SAFETYPRE)
//    [Bugly startWithAppId:@"a54107c789"];
//    #endif
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_by"]?:@"";
    return getRealKey(value);

}

- (NSString *)WCPayKey {
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_wcp"]?:@"";
    return getRealKey(value);

}

- (UInt32)videoLive_releaseKey {
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_vlr"]?:@"";
    return [getRealKey(value) intValue];

}

- (NSString *)gaodeAppURLScheme {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_gaodeAppURLScheme"]?:@"";
}

- (BOOL)appOpenAppStoreUpdate {
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_function_appStoreUpdate"]?:@"";
    if ([value isEqualToString:@"true"]) {
        return  YES;
    }else if ([value isEqualToString:@"false"]) {
        return  NO;
    }
    return YES;
}

- (BOOL)appOpenGlobalUserHeader {
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_function_globalUserHeader"]?:@"";
    if ([value isEqualToString:@"true"]) {
        return  YES;
    }else if ([value isEqualToString:@"false"]) {
        return  NO;
    }
    return YES;
}

- (BOOL)appOpenLaunchImageVC {
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_function_launchImageVC"]?:@"";
    if ([value isEqualToString:@"true"]) {
        return  YES;
    }else if ([value isEqualToString:@"false"]) {
        return  NO;
    }
    return YES;
}

- (NSArray *)profileItemConfig {
    NSArray *arr = @[
        @[ @"Trends", @"Favorite" ],
        @[ @"AccountSafe" ],
        @[ @"ClearMemery", @"SystemPermission", @"About"  ],
        @[ @"Logout" ]
    ];
    return arr;
}

- (NSArray *)appConfigModules {
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_module_config"]?:@"";
    if ([value isEqualToString:@""]) {
        return @[];
    }
    return [value componentsSeparatedByString:@","];
}

- (NSArray *)appHomeDefalutModules {
    NSString *value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"QYC_home_module"]?:@"";
    if ([value isEqualToString:@""]) {
        return @[];
    }
    return [value componentsSeparatedByString:@","];
}

/// debug启聊的单点登录
- (BOOL)appIMDebugSingleLogin {
    BOOL value = [[NSUserDefaults standardUserDefaults] boolForKey:IMSingleLoginKey];
    return value;
}

/// debug启聊的key
- (NSString *)appCustomRCDebugKey {
#ifdef DEBUG
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:RCloudDebugKey];
    if (key && ![key isEqual:@""]) {
        return key;
    }
#endif
    return nil;
}

@end
