//
//  CTMediator+Profile.h
//  Qiyeyun
//
//  Created by 启业云03 on 2020/10/27.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (Profile)

/// 进入『我』页面
- (UIViewController *)mediator_enterProfileVC;

/// 进入修改密码页面
/// @param weakPassword 是否弱密码（nil 等价于 NO）
/// @param title
- (UIViewController *)mediator_enterChangeSecretVCWithWeakPassword:(BOOL)weakPassword title:(NSString *)title;

/// 进入绑定手机页面
/// @param title
- (UIViewController *)mediator_enterPhoneVerifyVCWithTitle:(NSString *)title;

/// 进入两步验证页面
/// @param title
/// @param phone 手机号码
/// @param forceTwoVerify 是否强制两步验证
- (UIViewController *)mediator_enterTwoVerifyVCWithTitle:(NSString *)title phone:(NSString *)phone forceTwoVerify:(BOOL)forceTwoVerify;

/// 进入切换企业页面
/// @param entId 企业Id
/// @param selecteEntId 已选择的企业Id
/// @param callback 回调
- (UIViewController *)mediator_enterSwitchEntVCWithEntId:(NSString *)entId selecteEntId:(nullable NSString *)selecteEntId callback:(nullable void (^)(NSString *spaceId, NSString *spaceName))callback;

/// 设置ProfileVC属性值
/// @param vc profileVC
/// @param fromHome 来源是否为Home页
/// @param navTitle 标题
- (void)mediator_setProfileValueWithVC:(nonnull UIViewController *)vc fromHome:(BOOL)fromHome navTitle:(NSString *)navTitle;

/// 请求个人信息
/// @param entId 企业Id
/// @param userId 用户Id
/// @param callback 回调
- (void)mediator_requestPersonalInfoWithEntId:(nullable NSString *)entId userId:(nullable NSString *)userId callback:(void (^)(BOOL sucess, id data))callback;

/// 请求用户相关企业信息
/// @param entId 企业Id
/// @param callback 回调
- (void)mediator_requestChangeInfoWithEntId:(NSString *)entId callback:(void (^)(BOOL sucess, id data))callback;

/// 获取『我』的Class
- (Class)mediator_profileClass;

/// 退出
- (void)mediator_logout;

/// 导航添加用户头像
/// @param vc
- (void)mediator_addNavgationBarUserHeaderToVC:(UIViewController *)vc;

/// 更新导航用户头像
/// @param vc
- (void)mediator_updateNavgationBarUserHeaderToVC:(UIViewController *)vc;

/// 获取导航用户头像Item
- (UIBarButtonItem *)mediator_getHeaderToVC:(UIViewController *)vc;

/// 调用隐私政策
- (void)mediator_showPrivacyAcessView;

@end

NS_ASSUME_NONNULL_END
