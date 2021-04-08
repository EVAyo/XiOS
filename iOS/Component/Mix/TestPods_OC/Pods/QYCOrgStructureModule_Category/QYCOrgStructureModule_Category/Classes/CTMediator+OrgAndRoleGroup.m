//
//  CTMediator+OrgAndRoleGroup.m
//  Qiyeyun
//
//  Created by 启业云 on 2020/10/30.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator+OrgAndRoleGroup.h"

NSString *const QYCMediatorTargetRoleGroup   = @"roleGroup";
NSString *const QYCMediatorActionRoleGroupVC = @"enterRoleGroupVC";

NSString *const QYCMediatorTargetOrg                      = @"org";
NSString *const QYCMediatorActionOrgWhiteList             = @"enterOrgReturnWhiteList";
NSString *const QYCMediatorActionOrgHandNodeData          = @"enterOrgReturnHandNodeData";
NSString *const QYCMediatorActionOrgNextStopData          = @"enterOrgReturnHandNextStopData";
NSString *const QYCMediatorActionOrgCCData                = @"enterOrgReturnCCData";
NSString *const QYCMediatorActionOrgShareData             = @"enterOrgReturnShareData";
NSString *const QYCMediatorActionStandardDataFormOrgField = @"standardDataFormOrgField";
NSString *const QYCMediatorActionStandardDataFormNextStep = @"standardDataFormNextStep";
@implementation CTMediator (OrgAndRoleGroup)

- (id)mediator_entetRoleGroupVCWithGroupIds:(nullable NSArray<NSString *> *)groupIds selecteArr:(nullable NSArray *)selectArr callback:(void (^_Nonnull)(NSArray *_Nullable selectedFinish))callBack {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (groupIds) {
        params[@"groupIds"] = groupIds;
    }
    if (selectArr) {
        params[@"seletedArr"] = selectArr;
    }
    if (callBack) {
        params[@"callBack"] = callBack;
    }
    UIViewController *vc = [self performTarget:QYCMediatorTargetRoleGroup action:QYCMediatorActionRoleGroupVC params:params shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (void)mediator_releaseCacheTarget {
    [self releaseCachedTargetWithFullTargetName:[NSString stringWithFormat:@"Target_%@", QYCMediatorTargetRoleGroup]];
}

#pragma mark - Org

- (id)mediator_enterOrgVCGetWhiteListWithAppType:(KOrgType)appType isRadio:(BOOL)isRadio selectType:(KOrgSelectType)selectType andSelectedOrg:(nullable id)selectedOrg selectRange:(nullable NSDictionary *)selectRange entId:(NSString *)entId callBack:(void (^_Nonnull)(NSArray *_Nullable arr))callBack {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"appType"]          = @(appType);
    params[@"isRadio"]          = @(isRadio);
    params[@"selectType"]       = @(selectType);
    if (selectedOrg) {
        params[@"selectedOrg"] = selectedOrg;
    }
    if (selectRange) {
        params[@"selectRange"] = selectRange;
    }
    if (entId) {
        params[@"entId"] = entId;
    }
    if (callBack) {
        params[@"callBack"] = callBack;
    }
    UIViewController *vc = [self performTarget:QYCMediatorTargetOrg action:QYCMediatorActionOrgWhiteList params:params shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

//--
- (id)mediator_enterOrgVCHandNodeDataWithAppType:(KOrgType)appType isRadio:(BOOL)isRadio selectType:(KOrgSelectType)selectType andSelectedOrg:(nullable id)selectedOrg selectRange:(nullable NSDictionary *)selectRange entId:(NSString *)entId callBack:(void (^_Nonnull)(NSString *_Nullable data))callBack {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"appType"]          = @(appType);
    params[@"isRadio"]          = @(isRadio);
    params[@"selectType"]       = @(selectType);
    if (selectedOrg) {
        params[@"selectedOrg"] = selectedOrg;
    }
    if (selectRange) {
        params[@"selectRange"] = selectRange;
    }
    if (entId) {
        params[@"entId"] = entId;
    }
    if (callBack) {
        params[@"callBack"] = callBack;
    }
    UIViewController *vc = [self performTarget:QYCMediatorTargetOrg action:QYCMediatorActionOrgHandNodeData params:params shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

//--
- (id)mediator_enterOrgVCGetHandNextStopDataWithAppType:(KOrgType)appType isRadio:(BOOL)isRadio selectType:(KOrgSelectType)selectType andSelectedOrg:(nullable id)selectedOrg selectRange:(nullable NSDictionary *)selectRange entId:(NSString *)entId callBack:(void (^_Nonnull)(NSArray *_Nullable data))callBack {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"appType"]          = @(appType);
    params[@"isRadio"]          = @(isRadio);
    params[@"selectType"]       = @(selectType);
    if (selectedOrg) {
        params[@"selectedOrg"] = selectedOrg;
    }
    if (selectRange) {
        params[@"selectRange"] = selectRange;
    }
    if (entId) {
        params[@"entId"] = entId;
    }
    if (callBack) {
        params[@"callBack"] = callBack;
    }
    UIViewController *vc = [self performTarget:QYCMediatorTargetOrg action:QYCMediatorActionOrgNextStopData params:params shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

//--

- (id)mediator_enterOrgVCHandCCDataWithEntId:(NSString *)entId isNeedAssign:(BOOL)isNeedAssign callBack:(void (^_Nonnull)(NSArray *_Nullable data, NSString *_Nullable str))callBack {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"isNeedAssign"]     = @(isNeedAssign);

    if (entId) {
        params[@"entId"] = entId;
    }
    if (callBack) {
        params[@"callBack"] = callBack;
    }
    UIViewController *vc = [self performTarget:QYCMediatorTargetOrg action:QYCMediatorActionOrgCCData params:params shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (id)mediator_enterOrgVCHandShareDataWithParams:(NSDictionary *)tempParams entId:(NSString *)entId callBack:(void (^_Nonnull)(NSArray *_Nullable data))callBack {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"other"]            = tempParams;

    if (entId) {
        params[@"entId"] = entId;
    }
    if (callBack) {
        params[@"callBack"] = callBack;
    }
    UIViewController *vc = [self performTarget:QYCMediatorTargetOrg action:QYCMediatorActionOrgShareData params:params shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (NSDictionary *)mediator_standardDataFormOrgFieldWithWhiteList:(NSDictionary *)whiteList isRange:(BOOL)isRange {
    if (!whiteList) {
        return nil;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"whiteList"]        = whiteList;
    params[@"isRange"]          = @(isRange);
    return [self performTarget:QYCMediatorTargetOrg action:QYCMediatorActionStandardDataFormOrgField params:params shouldCacheTarget:NO];
}

- (NSDictionary *)mediator_standardDataFormNextStepWithArray:(NSArray *)array isRange:(BOOL)isRange {
    if (!array) {
        return nil;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"array"]            = array;
    params[@"isRange"]          = @(isRange);
    return [self performTarget:QYCMediatorTargetOrg action:QYCMediatorActionStandardDataFormNextStep params:params shouldCacheTarget:NO];
}
@end
