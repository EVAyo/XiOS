//
//  CTMediator+OrgAndRoleGroup.h
//  Qiyeyun
//
//  Created by 启业云 on 2020/10/30.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator.h"

typedef NS_OPTIONS(NSUInteger, KOrgSelectType) {
    // 组织架构 Member 为 KOrgSelectTypeMember | KOrgSelectTypeRole | KOrgSelectTypeDepartment
    // 组织架构 Role 为 KOrgSelectTypeRole | KOrgSelectTypeDepartment
    // 组织架构 Name 为 KOrgSelectTypeMember
    KOrgSelectTypeNone       = 0,      // 默认
    KOrgSelectTypeMember     = 1 << 0, // 可选人
    KOrgSelectTypeRole       = 1 << 1, // 可选岗位
    KOrgSelectTypeDepartment = 1 << 2, // 可选部门
};

typedef enum : NSUInteger {
    KOrgNextStep = 0,
    KOrgField,
    KOrgDefault,
    KOrgInfoCenterAt,
    KOrgEntrust,
    KOrgCopy,
    KOrgAt,
} KOrgType;

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (OrgAndRoleGroup)
- (id)mediator_entetRoleGroupVCWithGroupIds:(nullable NSArray<NSString *> *)groupIds selecteArr:(nullable NSArray *)selectArr callback:(void (^_Nonnull)(NSArray *_Nullable selectedFinish))callBack;

- (void)mediator_releaseCacheTarget;

//--
- (id)mediator_enterOrgVCGetWhiteListWithAppType:(KOrgType)appType isRadio:(BOOL)isRadio selectType:(KOrgSelectType)selectType andSelectedOrg:(nullable id)selectedOrg selectRange:(nullable NSDictionary *)selectRange entId:(NSString *)entId callBack:(void (^_Nonnull)(NSArray *_Nullable arr))callBack;

//--
- (id)mediator_enterOrgVCHandNodeDataWithAppType:(KOrgType)appType isRadio:(BOOL)isRadio selectType:(KOrgSelectType)selectType andSelectedOrg:(nullable id)selectedOrg selectRange:(nullable NSDictionary *)selectRange entId:(NSString *)entId callBack:(void (^_Nonnull)(NSString *_Nullable data))callBack;

//--
- (id)mediator_enterOrgVCGetHandNextStopDataWithAppType:(KOrgType)appType isRadio:(BOOL)isRadio selectType:(KOrgSelectType)selectType andSelectedOrg:(nullable id)selectedOrg selectRange:(nullable NSDictionary *)selectRange entId:(NSString *)entId callBack:(void (^_Nonnull)(NSArray *_Nullable data))callBack;

//--
- (id)mediator_enterOrgVCHandCCDataWithEntId:(NSString *)entId isNeedAssign:(BOOL)isNeedAssign callBack:(void (^_Nonnull)(NSArray *_Nullable data, NSString *_Nullable str))callBack;

//--
- (id)mediator_enterOrgVCHandShareDataWithParams:(NSDictionary *)tempParams entId:(NSString *)entId callBack:(void (^_Nonnull)(NSArray *_Nullable data))callBack;

//--
- (NSDictionary *)mediator_standardDataFormOrgFieldWithWhiteList:(NSDictionary *)whiteList isRange:(BOOL)isRange;

//--
- (NSDictionary *)mediator_standardDataFormNextStepWithArray:(NSArray *)array isRange:(BOOL)isRange;

@end

NS_ASSUME_NONNULL_END
