//
//  CTMediator+QYCApplicationCenterModuleActions.m
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/10/30.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator+QYCApplicationCenterModuleActions.h"

NSString *const kQYCMediatorTargetApplicationCenterModule = @"ApplicationCenterModule";

NSString *const kQYCMediatorActionAppCenterIsLoading = @"appCenterIsLoading";

NSString *const kQYCMediatorActionAppCenterReloadList = @"appCenterReloadList";

NSString *const kQYCMediatorActionFetchAppCenterVC = @"nativeFetchAppCenterVC";

NSString *const kQYCMediatorActionFetchAppCenterClass = @"nativeFetchAppCenterClass";

NSString *const kQYCMediatorActionOpenLinkApp = @"openLinkApplication";

NSString *const kQYCMediatorActionOpenApplicationFromVC = @"openApplicationFromVC";

@implementation CTMediator (QYCApplicationCenterModuleActions)

- (BOOL)mediator_appCenterIsLoading:(UIViewController *)vc {
    NSDictionary *params = @{@"vc" : vc ?: [UIViewController new]};
    id result            = [self performTarget:kQYCMediatorTargetApplicationCenterModule action:kQYCMediatorActionAppCenterIsLoading params:params shouldCacheTarget:NO];
    return [result boolValue];
}

- (void)mediator_appCenterReloadList:(UIViewController *)vc {
    NSDictionary *params = @{@"vc" : vc ?: [UIViewController new]};
    [self performTarget:kQYCMediatorTargetApplicationCenterModule action:kQYCMediatorActionAppCenterReloadList params:params shouldCacheTarget:NO];
}

- (UIViewController *)mediator_openAppCenter {
    UIViewController *vc = [self performTarget:kQYCMediatorTargetApplicationCenterModule action:kQYCMediatorActionFetchAppCenterVC params:nil shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (Class)mediator_appCenterClass {
    Class cls = [self performTarget:kQYCMediatorTargetApplicationCenterModule action:kQYCMediatorActionFetchAppCenterClass params:nil shouldCacheTarget:NO];
    return cls;
}

/// 跳转链接应用
/// @param link 链接
/// @param entId 企业id
/// @param appName 应用名称
- (void)mediator_openApplicationWithVC:(UIViewController *)vc link:(NSString *)link entId:(nullable NSString *)entId appName:(nullable NSString *)appName {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (!vc || !link) {
        return;
    }
    params[@"vc"]   = vc;
    params[@"link"] = link;

    if (entId) {
        params[@"entId"] = entId;
    }
    if (appName) {
        params[@"appName"] = appName;
    }
    [self performTarget:kQYCMediatorTargetApplicationCenterModule action:kQYCMediatorActionOpenLinkApp params:params shouldCacheTarget:NO];
}

- (void)mediator_openApplicationFromVC:(UIViewController *)vc
                                 entId:(nullable NSString *)entId
                              app_type:(nullable NSString *)app_type
                                  link:(nullable NSString *)link
                               appName:(nullable NSString *)appName {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (!vc || link.length == 0) {
        return;
    }
    params[@"vc"]       = vc;
    params[@"entId"]    = entId;
    params[@"app_type"] = app_type;
    params[@"link"]     = link;
    params[@"name"]     = appName;
    [self performTarget:kQYCMediatorTargetApplicationCenterModule action:kQYCMediatorActionOpenApplicationFromVC params:params shouldCacheTarget:NO];
}
@end
