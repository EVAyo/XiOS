//
//  CTMediator+FormViewModule.h
//  Qiyeyun
//
//  Created by 安元科技 on 2020/11/11.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (FormViewModule)

/// 获取FormView主页面
/// @param entId 企业Id
/// @param param {paramAppIdKey: appId,
///              paramAppNameKey: appName,
///              paramAppTypeKey: appType,
///              paramLabelIdKey: labelId}
- (UIViewController *)mediator_enterFormViewWithEntId:(NSString *)entId formViewParam:(NSDictionary *)param filterCondtions:(nullable NSArray *)filterCondtions;

- (void)mediator_openFormViewWithTargetVC:(UIViewController *)vc param:(NSDictionary *)param entId:(NSString *_Nullable)entId;

/// View设置初始化参数
/// @param params
- (void)mediator_formViewParams:(NSDictionary *)params vc:(UIViewController *)vc;

/// View设置企业Id
/// @param entId <#entId description#>
/// @param vc <#vc description#>
- (void)mediator_formViewEntId:(NSString *)entId vc:(UIViewController *)vc;

/// View设置导航左侧
/// @param action <#action description#>
- (void)mediator_formLeftNavTitleAction:(void (^)(BOOL isUsing, UIViewController *formVC))action vc:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
