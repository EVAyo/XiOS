//
//  CTMediator+QYCApplicationCenterModuleActions.h
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/10/30.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (QYCApplicationCenterModuleActions)

- (BOOL)mediator_appCenterIsLoading:(UIViewController *)vc;

- (void)mediator_appCenterReloadList:(UIViewController *)vc;

- (UIViewController *)mediator_openAppCenter;

- (Class)mediator_appCenterClass;

//- (void)mediator_routeApplicationWithLink:(NSString *)link entId:(NSString *)entId appName:(NSString *)appName vc:(UIViewController *)vc;

/// 跳转链接应用
/// @param link 链接
/// @param entId 企业id
/// @param appName 应用名称
- (void)mediator_openApplicationWithVC:(UIViewController *)vc
                                  link:(NSString *)link
                                 entId:(nullable NSString *)entId
                               appName:(nullable NSString *)appName;

/// 跳转链接应用
/// @param entId 企业id
/// @param link 链接
/// @param app_type 应用类型，不传时默认值为link
/// @param appName 应用名称
- (void)mediator_openApplicationFromVC:(UIViewController *)vc
                                 entId:(nullable NSString *)entId
                              app_type:(nullable NSString *)app_type
                                  link:(nullable NSString *)link
                               appName:(nullable NSString *)appName;

@end

NS_ASSUME_NONNULL_END
