//
//  CTMediator+Profile.m
//  Qiyeyun
//
//  Created by 启业云03 on 2020/10/27.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator+Profile.h"

NSString *const kTarget_Profile                          = @"Profile";
NSString *const kAction_enterProfileVC                   = @"enterProfileVC";
NSString *const kAction_enterChangeSecretVC              = @"enterChangeSecretVC";
NSString *const kAction_enterPhoneVerifyVC               = @"enterPhoneVerifyVC";
NSString *const kAction_enterTwoVerifyVC                 = @"enterTwoVerifyVC";
NSString *const kAction_enterSwitchEntVC                 = @"enterSwitchEntVC";
NSString *const kAction_setProfileValue                  = @"setProfileValue";
NSString *const kAction_requestPersonalInfo              = @"requestPersonalInfo";
NSString *const kAction_requestChangeInfo                = @"requestChangeInfo";
NSString *const kAction_profileClass                     = @"profileClass";
NSString *const kAction_logout                           = @"logout";
NSString *const kAction_addNavgationBarUserHeaderToVC    = @"addNavgationBarUserHeaderToVC";
NSString *const kAction_updateNavgationBarUserHeaderToVC = @"updateNavgationBarUserHeaderToVC";
NSString *const kAction_getHeaderToVC                    = @"getHeaderToVC";
NSString *const kAction_showPrivacyAcessView             = @"showPrivacyAcessView";

@implementation CTMediator (Profile)

/// 获取页面
- (UIViewController *)mediator_enterProfileVC {
    UIViewController *vc = [self performTarget:kTarget_Profile action:kAction_enterProfileVC params:nil shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_enterChangeSecretVCWithWeakPassword:(BOOL)weakPassword title:(NSString *)title {
    NSDictionary *dic    = @{@"weakPassword" : [NSNumber numberWithBool:weakPassword],
                          @"title" : title ?: @""};
    UIViewController *vc = [self performTarget:kTarget_Profile action:kAction_enterChangeSecretVC params:dic shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_enterPhoneVerifyVCWithTitle:(NSString *)title {
    NSDictionary *dic    = @{@"title" : title ?: @""};
    UIViewController *vc = [self performTarget:kTarget_Profile action:kAction_enterPhoneVerifyVC params:dic shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_enterTwoVerifyVCWithTitle:(NSString *)title phone:(NSString *)phone forceTwoVerify:(BOOL)forceTwoVerify {
    NSDictionary *dic = @{
        @"title" : title ?: @"",
        @"phone" : phone ?: @"",
        @"forceTwoVerify" : [NSNumber numberWithBool:forceTwoVerify],
    };
    UIViewController *vc = [self performTarget:kTarget_Profile action:kAction_enterTwoVerifyVC params:dic shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_enterSwitchEntVCWithEntId:(NSString *)entId selecteEntId:(NSString *)selecteEntId callback:(void (^)(NSString *spaceId, NSString *spaceName))callback {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (entId) {
        dic[@"entId"] = entId;
    }
    if (selecteEntId) {
        dic[@"selecteEntId"] = selecteEntId;
    }
    if (callback) {
        dic[@"callBack"] = callback;
    }
    UIViewController *vc = [self performTarget:kTarget_Profile action:kAction_enterSwitchEntVC params:dic shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (void)mediator_setProfileValueWithVC:(UIViewController *)vc fromHome:(BOOL)fromHome navTitle:(NSString *)navTitle {
    NSDictionary *dic = @{
        @"vc" : vc ?: [UIViewController new],
        @"fromHome" : [NSNumber numberWithBool:fromHome],
        @"navTitle" : navTitle ?: @"",
    };
    [self performTarget:kTarget_Profile action:kAction_setProfileValue params:dic shouldCacheTarget:NO];
}

- (void)mediator_requestPersonalInfoWithEntId:(NSString *)entId userId:(NSString *)userId callback:(void (^)(BOOL sucess, id data))callback {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (entId) {
        dic[@"entId"] = entId;
    }
    if (userId) {
        dic[@"userId"] = userId;
    }
    if (callback) {
        dic[@"callBack"] = callback;
    }
    [self performTarget:kTarget_Profile action:kAction_requestPersonalInfo params:dic shouldCacheTarget:NO];
}

- (void)mediator_requestChangeInfoWithEntId:(NSString *)entId callback:(void (^)(BOOL sucess, id data))callback {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (entId) {
        dic[@"entId"] = entId;
    }
    if (callback) {
        dic[@"callBack"] = callback;
    }
    [self performTarget:kTarget_Profile action:kAction_requestChangeInfo params:dic shouldCacheTarget:NO];
}

- (Class)mediator_profileClass {
    return [self performTarget:kTarget_Profile action:kAction_profileClass params:nil shouldCacheTarget:YES];
}

/// 触发退出
- (void)mediator_logout {
    [self performTarget:kTarget_Profile action:kAction_logout params:nil shouldCacheTarget:NO];
}

- (void)mediator_addNavgationBarUserHeaderToVC:(UIViewController *)vc {
    NSDictionary *params = @{@"vc" : vc ?: [UIViewController new]};
    [self performTarget:kTarget_Profile
                   action:kAction_addNavgationBarUserHeaderToVC
                   params:params
        shouldCacheTarget:YES];
}

- (void)mediator_updateNavgationBarUserHeaderToVC:(UIViewController *)vc {
    NSDictionary *params = @{@"vc" : vc ?: [UIViewController new]};
    [self performTarget:kTarget_Profile
                   action:kAction_updateNavgationBarUserHeaderToVC
                   params:params
        shouldCacheTarget:YES];
}

- (UIBarButtonItem *)mediator_getHeaderToVC:(UIViewController *)vc {
    NSDictionary *params = @{@"vc" : vc ?: [UIViewController new]};
    return [self performTarget:kTarget_Profile
                        action:kAction_getHeaderToVC
                        params:params
             shouldCacheTarget:NO];
}

/// 调用隐私政策
- (void)mediator_showPrivacyAcessView {
    [self performTarget:kTarget_Profile
                   action:kAction_showPrivacyAcessView
                   params:nil
        shouldCacheTarget:YES];
}

@end
