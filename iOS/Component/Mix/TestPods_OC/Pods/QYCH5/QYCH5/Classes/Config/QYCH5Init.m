//
//  QYCH5Init.m
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/12/4.
//  Copyright © 2020 安元. All rights reserved.
//

#import "QYCH5Init.h"
#import <WechatOpenSDK/WXApi.h>
#import "QYCAppConfig.h"

@interface QYCH5Init () <WXApiDelegate>

@end

@implementation QYCH5Init

+ (void)load {
    [self registerModule];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL use = [WXApi registerApp:[QYCAppConfig shareConfig].WCPayKey universalLink:@"https://www.bugVegetables.com/"];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    if ([url.host isEqualToString:@"pay"]) {
        [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

- (void)onResp:(BaseResp *)resp {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QYCPayWeChatPayFinishCallback" object:resp];
}

@end
