//
//  CTMediator+QChat.m
//  Qiyeyun
//
//  Created by 启业云 on 2020/10/23.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator+QChat.h"

NSString *const QYCMediatorTargetQChat                         = @"QChat";
NSString *const QYCMediatorActionConversationListVC            = @"enterConversationListVC";
NSString *const QYCMediatorActionConversationVC                = @"enterConversationVC";
NSString *const QYCMediatorActionFavorVC                       = @"enterMessageFavorVC";
NSString *const QYCMediatorActionChatQcodeVC                   = @"enterChatQcodeVC";
NSString *const QYCMediatorActionOtherSpaceVC                  = @"enterOtherSpaceVC";
NSString *const QYCMediatorActionOtherFieldsVC                 = @"enterOtherFieldsVC";
NSString *const QYCMediatorActionPersionDetailVC               = @"enterPersonDetailVC";
NSString *const QYCMediatorActionforward                       = @"forwardImage";
NSString *const QYCMediatorActionForwardRichContentMessage     = @"forwardRichContentMessage";
NSString *const QYCMediatorActionConversationListClass         = @"conversationListClass";
NSString *const QYCMediatorActionConversationClass             = @"conversationClass";
NSString *const QYCMediatorActionPersonDetailClass             = @"personDetailClass";
NSString *const QYCMediatorActionupdateBadge                   = @"updateBadgeValueForTabBarItem";
NSString *const QYCMediatorActionLoginRCServer                 = @"loginRCServer";
NSString *const QYCMediatorActionDisconnectRemoveToken         = @"disconnectAndRemoveToken";
NSString *const QYCMediatorActionUploadFileMaxSize             = @"fetchUploadFileMaxSize";
NSString *const QYCMediatorActionneedOrgGroup                  = @"needOrgGroup";
NSString *const QYCMediatorActioncontactsVC                    = @"contactsVC";
NSString *const QYCMediatorActioncreateGroup                   = @"createGroup";
NSString *const QYCMediatorActionGetPersonDataByUserId         = @"personDataByUserId";
NSString *const QYCMediatorActionGetPersonDataByImId           = @"getPersonDataByImId";
NSString *const QYCMediatorActionUpdataPersonCacheDataByImId   = @"updataPersonCacheDataByImId";
NSString *const QYCMediatorActionInviteJoinGroupChatVC         = @"inviteJoinGroupChatVC";
NSString *const QYCMediatorActionChatAddVC                     = @"ChatAddVC";
NSString *const QYCMediatorActionjudgeAcrossSpaceGroupLink     = @"judgeAcrossSpaceGroupLink";
NSString *const QYCMediatorActioncreateFileMsg                 = @"createFileMsg";
NSString *const QYCMediatorActioncreteMessageModel             = @"creteMessageModel";
NSString *const QYCMediatorActionforwardMessageModel           = @"forwardMessageModel";
NSString *const QYCMediatorActioncreateRichContentMessage      = @"createRichContentMessage";
NSString *const QYCMediatorActionrcFileIcon                    = @"rcFileIcon";
NSString *const QYCMediatorActiongetReadableStringForFileSize  = @"getReadableStringForFileSize";
NSString *const QYCMediatorActionupdataPersonCacheDataByUserId = @"updataPersonCacheDataByUserId";
NSString *const QYCMediatorActioncreateGIFMessage              = @"createGIFMessage";
NSString *const QYCMediatorActioncreateImageMessage            = @"createImageMessage";
NSString *const QYCMediatorActioncreateTextMessage             = @"createTextMessage";
NSString *const QYCMediatorActionsendMsg                       = @"sendMsg";
NSString *const QYCMediatorActionMessageForwardViewController  = @"messageForwardViewController";
NSString *const QYCMediatorActionNearestContacterVC            = @"nearestContacterVC";
NSString *const QYCMediatorActionForwardManagerTitle           = @"forwardManagerTitle";
NSString *const QYCMediatorActionContactsGroupVC               = @"contactsGroupVC";
NSString *const QYCMediatorActionAppDetailsShare               = @"appDetailsShareToQChat";

NSString *const QYCMediatorActionCurrentUserInfo               = @"currentUserInfo";
NSString *const QYCMediatorActionCurrentUserImId               = @"currentUserImId";
NSString *const QYCMediatorActionGetUnreadCount                = @"getUnreadCount";
NSString *const QYCMediatorActionRefreshUserInfoCache          = @"refreshUserInfoCache";
NSString *const QYCMediatorActionClearGroupInfoCache           = @"clearGroupInfoCache";
NSString *const QYCMediatorActionClearUserInfoCache            = @"clearUserInfoCache";
NSString *const QYCMediatorActionSetNotificationQuiet          = @"setNotificationQuiet";
NSString *const QYCMediatorActionRemoveNotificationQuiet       = @"removeNotificationQuiet";
NSString *const QYCMediatorActionGetNotificationQuiet          = @"getNotificationQuiet";
NSString *const QYCMediatorActionClearMessagesUnreadStatus     = @"clearMessagesUnreadStatus";
NSString *const QYCMediatorActionSetConversionToTop            = @"setConversionToTop";
NSString *const QYCMediatorActionGetConversionToTop            = @"getConversionToTop";
NSString *const QYCMediatorActionSetConversionNotificationdStatus  = @"setConversionNotificationdStatus";
NSString *const QYCMediatorActionGetConversationNotificationStatus = @"getConversationNotificationStatus";
NSString *const QYCMediatorActionDispatchMessageNotification       = @"DispatchMessageNotification";



NSString *const QYCMediatorActionLogout               = @"logout";

@implementation CTMediator (QChat)
- (UIViewController *)mediator_enterConversationListVC {
    UIViewController *vc = [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionConversationListVC params:@{@"chatBadge" : @YES} shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_enterConversationVCWithType:(NSInteger)type targetId:(NSString *)targetId title:(NSString *)title entId:(NSString *)entId {
    NSMutableDictionary *dic = @{}.mutableCopy;
    dic[@"conversationType"] = @(type);
    dic[@"targetId"]         = targetId;
    dic[@"title"]            = title;
    dic[@"entId"]            = entId;
    UIViewController *vc     = [self performTarget:QYCMediatorTargetQChat
                                        action:QYCMediatorActionConversationVC
                                        params:dic
                             shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_enterPersonDatailWithName:(NSString *)name userId:(NSString *)userId imUserId:(nullable NSString *)imUserId headPhotoUrl:(nullable NSString *)url entId:(NSString *)entId {
    NSMutableDictionary *dic = @{@"name" : name ?: @"", @"userId" : userId ?: @""}.mutableCopy;
    dic[@"imUserId"]         = imUserId;
    dic[@"headPhotoUrl"]     = url;
    dic[@"entId"]            = entId;
    UIViewController *vc     = [self performTarget:QYCMediatorTargetQChat
                                        action:QYCMediatorActionPersionDetailVC
                                        params:dic
                             shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_forwardImage:(NSData *)imageData entId:(NSString *)entId {
    UIViewController *vc = [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionforward params:@{@"image" : imageData, @"entId" : entId} shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}
- (UIViewController *)mediator_forwardRichContentMessageWithEntId:(NSString *)entId
                                                            title:(NSString *)title
                                                           digest:(NSString *)digest
                                                         imageURL:(NSString *)imageURL
                                                              url:(NSString *)url
                                                            extra:(NSString *)extra {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"entId"]            = entId;
    param[@"title"]            = title;
    param[@"digest"]           = digest;
    param[@"imageURL"]         = imageURL;
    param[@"url"]              = url;
    param[@"extra"]            = extra;
    UIViewController *vc       = [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionForwardRichContentMessage params:param shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}
- (UIViewController *)mediator_enterFavorVC {
    UIViewController *vc = [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionFavorVC params:@{@"useStyle" : @0} shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_enterChatQcodeVCWithEntId:(NSString *)entId name:(NSString *)name identifier:(NSString *)identifier number:(NSString *)number chatQCodeType:(NSInteger)type headerUrl:(NSString *)headerUrl groupType:(NSInteger)groupType {
    NSDictionary *dic = @{
        @"entId" : entId ?: @"",
        @"name" : name ?: @"",
        @"identifier" : identifier ?: @"",
        @"number" : number ?: @"",
        @"type" : [NSNumber numberWithInteger:type] ?: @0,
        @"headerUrl" : headerUrl ?: @"",
        @"groupType" : [NSNumber numberWithInteger:groupType] ?: @0,
    };

    UIViewController *vc = [self performTarget:QYCMediatorTargetQChat
                                        action:QYCMediatorActionChatQcodeVC
                                        params:dic
                             shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_enterOtherSpaceVCWithEntId:(NSString *)entId userId:(NSString *)userId {
    NSDictionary *dic = @{
        @"entId" : entId ?: @"",
        @"userId" : userId ?: @"",
    };
    UIViewController *vc = [self performTarget:QYCMediatorTargetQChat
                                        action:QYCMediatorActionOtherSpaceVC
                                        params:dic
                             shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_enterOtherFieldsVCWithEntId:(NSString *)entId userId:(NSString *)userId {
    NSDictionary *dic = @{
        @"entId" : entId ?: @"",
        @"userId" : userId ?: @"",
    };
    UIViewController *vc = [self performTarget:QYCMediatorTargetQChat
                                        action:QYCMediatorActionOtherFieldsVC
                                        params:dic
                             shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (Class)mediator_conversationListClass {
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionConversationListClass params:nil shouldCacheTarget:NO];
}

- (Class)mediator_conversationClass {
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionConversationClass params:nil shouldCacheTarget:NO];
}

- (Class)mediator_personDetailClass {
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionPersonDetailClass params:nil shouldCacheTarget:NO];
}

- (void)mediator_updateBadgeValueForTabBarItem:(UIViewController *)vc {
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionupdateBadge params:@{@"ConversationListVC" : vc} shouldCacheTarget:NO];
}

/// 登陆链接融云
- (void)mediator_loginRCServer {
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionLoginRCServer params:nil shouldCacheTarget:NO];
}

/// 断开融云的链接并移除token（远程推送并没有可以接受到）
- (void)mediator_disconnectAndRemoveToken {
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionDisconnectRemoveToken params:nil shouldCacheTarget:NO];
}

- (void)mediator_needOrgGroup {
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionneedOrgGroup params:nil shouldCacheTarget:NO];
}

- (void)mediator_fetchUploadFileMaxSize {
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionUploadFileMaxSize params:nil shouldCacheTarget:NO];
}

- (void)mediator_getPersonDataByUserId:(NSString *)userId callBack:(void (^_Nullable)(NSInteger code, NSDictionary *model))callBack {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (userId) {
        params[@"userId"] = userId;
    }
    if (callBack) {
        params[@"callBack"] = callBack;
    }
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionGetPersonDataByUserId params:params shouldCacheTarget:NO];
}

- (void)mediator_getPersonDataByImId:(NSString *)imId callBack:(void (^_Nullable)(NSInteger code, NSDictionary *model))callBack {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (imId) {
        params[@"imId"] = imId;
    }
    if (callBack) {
        params[@"callBack"] = callBack;
    }
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionGetPersonDataByImId params:params shouldCacheTarget:NO];
}
- (void)mediator_updataPersonCacheDataByImId:(NSString *)imId callBack:(void (^_Nullable)(NSInteger code, NSDictionary *model))callBack {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (imId) {
        params[@"imId"] = imId;
    }
    if (callBack) {
        params[@"callBack"] = callBack;
    }
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionUpdataPersonCacheDataByImId params:params shouldCacheTarget:NO];
}
- (UIViewController *)mediator_contactsVC {
    UIViewController *vc = [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActioncontactsVC params:nil shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}
- (void)mediator_createGroupWithVC:(UIViewController *)vc {
    NSDictionary *params = @{@"vc" : vc ?: [UIViewController new]};
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActioncreateGroup params:params shouldCacheTarget:NO];
}

- (UIViewController *)mediator_inviteJoinGroupChatVCWithLinkUrl:(NSString *)url presentStyle:(BOOL)presentStyle {
    NSDictionary *params = @{@"url" : url ?: @"", @"presentStyle" : @(presentStyle)};
    UIViewController *vc = [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionInviteJoinGroupChatVC params:params shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_enterChatAddVCWithEntId:(NSString *)entId name:(NSString *)name discussId:(NSString *)discussId discussUserId:(NSString *)discussUserId {
    NSDictionary *dic = @{@"entId" : entId ?: @"",
                          @"name" : name ?: @"",
                          @"discussId" : discussId ?: @"",
                          @"discussUserId" : discussUserId ?: @""};
    UIViewController *vc = [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionChatAddVC params:dic shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (BOOL)mediator_judgeAcrossSpaceGroupLink:(NSString *)url {
    NSDictionary *params = @{@"url" : url ?: @""};
    return [[self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionjudgeAcrossSpaceGroupLink params:params shouldCacheTarget:NO] boolValue];
}

- (UIViewController *)mediator_forwardMessageModel:(id)messageModel
                               selectedCancelBlock:(nullable void (^)(void))selectedCancelBlock
                                forwardCancelBlock:(nullable void (^)(void))forwardCancelBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (messageModel) {
        [params setValue:messageModel forKey:@"messageModel"];
    }
    if (selectedCancelBlock) {
        [params setValue:selectedCancelBlock forKey:@"selectedCancelBlock"];
    }
    if (forwardCancelBlock) {
        [params setValue:forwardCancelBlock forKey:@"forwardCancelBlock"];
    }

    UIViewController *vc = [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionforwardMessageModel params:params shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (id)mediator_creteMessageModelWithMsgContent:(id)msgContent objectName:(NSString *)objectName sentStatus:(NSUInteger)sentStatus {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (msgContent) {
        [params setValue:msgContent forKey:@"msgContent"];
    }
    [params setValue:objectName ?: @"" forKey:@"objectName"];
    [params setValue:@(sentStatus) forKey:@"sentStatus"];
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActioncreteMessageModel params:params shouldCacheTarget:NO];
}

- (id)mediator_createFileMsgWithName:(NSString *)name fileUrl:(NSString *)fileUrl size:(long long)size type:(NSString *)type localPath:(nullable NSString *)localPath {
    NSDictionary *params = @{@"name" : name ?: @"", @"fileUrl" : fileUrl ?: @"", @"size" : @(size) ?: @0, @"type" : type ?: @"", @"localPath" : localPath ?: @""};
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActioncreateFileMsg params:params shouldCacheTarget:NO];
}

- (id)mediator_createRichContentMessageWithTitle:(NSString *)title digest:(NSString *)digest imageURL:(NSString *)imageURL url:(NSString *)url extra:(NSString *)extra {
    NSDictionary *params = @{@"title" : title ?: @"",
                             @"digest" : digest ?: @"",
                             @"imageURL" : imageURL ?: @"",
                             @"url" : url ?: @"",
                             @"extra" : extra ?: @""};
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActioncreateRichContentMessage params:params shouldCacheTarget:NO];
}

- (id)mediator_createGIFMessageWithRemoteUrl:(NSString *)remoteUrl gifDataSize:(long long)gifDataSize width:(long)width height:(long)height name:(NSString *)name {
    NSDictionary *params = @{@"remoteUrl" : remoteUrl ?: @"",
                             @"gifDataSize" : @(gifDataSize) ?: @(0),
                             @"width" : @(width) ?: @0,
                             @"height" : @(height) ?: @0,
                             @"name" : name ?: @""};
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActioncreateGIFMessage params:params shouldCacheTarget:NO];
}

- (id)mediator_createImageMessageWithImage:(UIImage *)image imageUrl:(NSString *)imageUrl {
    NSDictionary *params = @{@"image" : image ?: [UIImage new],
                             @"imageUrl" : imageUrl ?: @""};
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActioncreateImageMessage params:params shouldCacheTarget:NO];
}

- (UIImage *)mediator_rcFileIconType:(NSString *)type {
    NSDictionary *params = @{@"type" : type ?: @""};
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionrcFileIcon params:params shouldCacheTarget:NO];
}

- (NSString *)mediator_getReadableStringForFileSize:(long long)byteSize {
    NSDictionary *params = @{@"byteSize" : @(byteSize)};
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActiongetReadableStringForFileSize params:params shouldCacheTarget:NO];
}

- (void)mediator_updataPersonCacheDataByUserId:(NSString *)userId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (userId) {
        [params setValue:userId forKey:@"userId"];
    }
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionupdataPersonCacheDataByUserId params:params shouldCacheTarget:NO];
}

- (id)mediator_createTextMessageWithText:(NSString *)text {
    NSDictionary *params = @{@"text" : text ?: @""};
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActioncreateTextMessage params:params shouldCacheTarget:NO];
}

- (void)mediator_sendMsg:(id)msg conversationType:(NSInteger)conversationType targetId:(NSString *)targetId {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    if (msg) {
        [params setValue:msg forKey:@"msg"];
    }
    [params setValue:@(conversationType) forKey:@"conversationType"];
    if (targetId) {
        [params setValue:targetId forKey:@"targetId"];
    }
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionsendMsg params:params shouldCacheTarget:NO];
}

- (UIViewController *)mediator_messageForwardViewControllerWithContent:(id)content name:(NSString *)name avatar:(NSString *)avatar placeholder:(NSString *)placeholder fromVC:(UIViewController *)vc row:(NSInteger)row clickActionBlock:(nullable void (^)(BOOL isSend, NSString *message))clickActionBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:content forKey:@"content"];
    [param setValue:name forKey:@"name"];
    [param setValue:avatar forKey:@"avatar"];
    [param setValue:placeholder forKey:@"placeholder"];
    [param setValue:vc forKey:@"vc"];
    [param setValue:@(row) forKey:@"row"];
    [param setValue:clickActionBlock forKey:@"clickActionBlock"];
    UIViewController *VC = [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionMessageForwardViewController params:param shouldCacheTarget:NO];
    if (VC == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return VC;
    }
}

- (UIViewController *)mediator_nearestContacterVCIsGroupSearch:(BOOL)groupSearch multiSelect:(BOOL)multiSelect maxOfMultiSelect:(NSUInteger)maxOfMultiSelect entId:(NSString *)entId selectedGroupBlock:(void (^)(NSMutableArray *groupOrUser, UIViewController *vc))selectedGroupBlock cancelBlock:(nullable dispatch_block_t)cancelBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@(groupSearch) forKey:@"groupSearch"];
    [param setValue:@(multiSelect) forKey:@"multiSelect"];
    [param setValue:@(maxOfMultiSelect) forKey:@"maxOfMultiSelect"];
    [param setValue:selectedGroupBlock forKey:@"selectedGroupBlock"];
    [param setValue:cancelBlock forKey:@"cancelBlock"];
    [param setValue:entId forKey:@"entId"];
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionNearestContacterVC params:param shouldCacheTarget:NO];
}

- (NSString *)mediator_forwardManagerTitleWithTargets:(NSMutableArray *)targets {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:targets forKey:@"targets"];
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionForwardManagerTitle params:param shouldCacheTarget:NO];
}

- (UIViewController *)mediator_contactsGroupVCEntId:(NSString *)entId forward:(BOOL)forward multiSelect:(BOOL)multiSelect maxOfMultiSelect:(NSUInteger)maxOfMultiSelect selectedData:(nullable NSMutableArray *)selectedData selectedBlock:(nullable void (^)(NSMutableArray *groupOrUser))selectedBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:entId forKey:@"entId"];
    [param setValue:@(forward) forKey:@"forward"];
    [param setValue:@(multiSelect) forKey:@"multiSelect"];
    [param setValue:@(maxOfMultiSelect) forKey:@"maxOfMultiSelect"];
    [param setValue:selectedData forKey:@"selectedData"];
    [param setValue:selectedBlock forKey:@"selectedBlock"];
    UIViewController *vc = [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionContactsGroupVC params:param shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (void)mediator_shareAppDetailsWidthEndId:(NSString *)dataEntId
                                    fromVC:(UIViewController *)vc
                                     appId:(NSString *)appId
                                   appType:(NSString *)appType
                                    formId:(nullable NSString *)formId
                                      open:(nullable NSString *)open
                                   nodeKey:(nullable NSString *)nodeKey
                                     label:(nullable NSString *)label {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"dataEntId"] = dataEntId;
    param[@"vc"] = vc;
    param[@"appId"] = appId;
    param[@"appType"] = appType;
    param[@"formId"] = formId;
    param[@"open"] = open;
    param[@"nodeKey"] = nodeKey;
    param[@"label"] = label;

    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionAppDetailsShare params:param shouldCacheTarget:NO];
}

#pragma mark - 融云消息操作

///  获取当前用户登录的融云信息
- (NSDictionary *)mediator_currentUserInfo {
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionCurrentUserInfo params:nil shouldCacheTarget:NO];
}

///  获取当前用户登录的融云Id
- (NSString *)mediator_currentUserImId {
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionCurrentUserImId params:nil shouldCacheTarget:NO];
}

/// 获取某些类型的会话中所有的未读消息数（聊天室会话除外）
/// @param conversationTypes 会话类型的数组
/// @param isContain 是否包含免打扰消息的未读数
/// @return 该类型的会话中所有的未读消息数
- (int)mediator_getUnreadCount:(NSArray *)conversationTypes containBlocked:(bool)isContain {

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"conversationTypes"] = conversationTypes;
    param[@"isContain"] = @(isContain);

    return [[self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionGetUnreadCount params:param shouldCacheTarget:NO] intValue];
}

/// 刷新当前融云用户信息
/// @param userImId 用户的I吗Id
- (void)mediator_refreshUserInfoCache:(NSString *)userImId name:(NSString *)userName avatar:(NSString *)avatar {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userImId"] = userImId;
    param[@"userName"] = userName;
    param[@"avatar"] = avatar;
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionRefreshUserInfoCache params:param shouldCacheTarget:NO];
}

/// 清理群组融云缓存
- (void)mediator_clearGroupInfoCache {
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionClearGroupInfoCache params:nil shouldCacheTarget:NO];
}

/// 清理用户融云缓存
- (void)mediator_clearUserInfoCache {
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionClearUserInfoCache params:nil shouldCacheTarget:NO];
}

/// 全局屏蔽某个时间段的消息提醒
/// @param startTime 开始消息免打扰时间，格式为 HH:MM:SS
/// @param spanMins  需要消息免打扰分钟数，0 < spanMins < 1440（ 比如，您设置的起始时间是 00：00， 结束时间为23：59，则 spanMins 为 23 * 60 + 59 = 1339 分钟。）
/// @param successBlock  屏蔽成功的回调
/// @param errorBlock 屏蔽失败的回调 [status:屏蔽失败的错误码]
- (void)mediator_setNotificationQuietHours:(NSString *)startTime
                                  spanMins:(int)spanMins
                                   success:(void (^)(void))successBlock
                                     error:(void (^)(NSInteger status))errorBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"startTime"] = startTime;
    param[@"spanMins"] = @(spanMins);
    param[@"successBlock"] = successBlock;
    param[@"errorBlock"] = errorBlock;
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionSetNotificationQuiet params:param shouldCacheTarget:NO];
}

/// 删除已设置的全局时间段消息提醒屏蔽
/// @param successBlock 删除屏蔽成功的回调
/// @param errorBlock  删除屏蔽失败的回调 [status:失败的错误码]
- (void)mediator_removeNotificationQuietHours:(void (^)(void))successBlock error:(void (^)(NSInteger status))errorBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"successBlock"] = successBlock;
    param[@"errorBlock"] = errorBlock;

    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionRemoveNotificationQuiet params:param shouldCacheTarget:NO];
}

/// 查询已设置的全局时间段消息提醒屏蔽
/// @param successBlock  屏蔽成功的回调 [startTime:已设置的屏蔽开始时间, spansMin:已设置的屏蔽时间分钟数，0 < spansMin < 1440]
/// @param errorBlock 查询失败的回调 [status:查询失败的错误码]
- (void)mediator_getNotificationQuietHours:(void (^)(NSString *startTime, int spansMin))successBlock
                                     error:(void (^)(NSInteger status))errorBlock {

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"successBlock"] = successBlock;
    param[@"errorBlock"] = errorBlock;
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionGetNotificationQuiet params:param shouldCacheTarget:NO];
}

/// 清除消息未读数
/// @param conversationType 会话类型，单聊: 1, 群组: 3, 系统会话: 6
/// @param targetId  会话 ID
- (void)mediator_clearMessagesUnreadStatus:(int)conversationType targetId:(NSString *)targetId {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"targetId"] = targetId;
    param[@"conversationType"] = @(conversationType);

    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionClearMessagesUnreadStatus params:param shouldCacheTarget:NO];
}

///  设置消息是否置顶
/// @param conversationType 会话类型，单聊: 1, 群组: 3, 系统会话: 6
/// @param targetId  会话 ID
/// @param isTop 是否置顶
/// @return isTop  设置是否成功
- (BOOL)mediator_setConversionToTop:(int)conversationType targetId:(NSString *)targetId isTop:(BOOL)isTop {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"targetId"] = targetId;
    param[@"conversationType"] = @(conversationType);
    param[@"isTop"] = @(isTop);

    return [[self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionSetConversionToTop params:param shouldCacheTarget:NO] boolValue];
}

/// 获取单个会话是否置顶
/// @param conversationType 会话类型，单聊: 1, 群组: 3, 系统会话: 6
/// @param targetId 会话 ID
- (BOOL)mediator_getConversionToTop:(int)conversationType targetId:(NSString *)targetId {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"targetId"] = targetId;
    param[@"conversationType"] = @(conversationType);
    return [[self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionGetConversionToTop params:param shouldCacheTarget:NO] boolValue];
}

/// 设置会话的消息提醒状态
/// @param conversationType 会话类型，单聊: 1, 群组: 3, 系统会话: 6
/// @param targetId  会话 ID
/// @param isBlocked 是否屏蔽消息提醒
/// @param successBlock 设置成功的回调 [nStatus:会话设置的消息提醒状态,免打扰：0，新消息提醒：1]
/// @param errorBlock 设置失败的回调 [status:设置失败的错误码]
- (void)mediator_setConversionNotificationdStatus:(int)conversationType
                                         targetId:(NSString *)targetId
                                        isBlocked:(BOOL)isBlocked
                                          success:(void (^)(int nStatus))successBlock
                                            error:(void (^)(NSInteger status))errorBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"targetId"] = targetId;
    param[@"conversationType"] = @(conversationType);
    param[@"isBlocked"] = @(isBlocked);
    param[@"errorBlock"] = errorBlock;
    param[@"successBlock"] = successBlock;
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionSetConversionNotificationdStatus params:param shouldCacheTarget:NO];
}

///  查询会话的消息提醒状态
/// @param conversationType  会话类型，单聊: 1, 群组: 3, 系统会话: 6
/// @param targetId 会话 ID
/// @param successBlock 查询成功的回调 [nStatus:会话设置的消息提醒状态]
/// @param errorBlock 查询失败的回调 [status:设置失败的错误码]
- (void)mediator_getConversationNotificationStatus:(int)conversationType
                                          targetId:(NSString *)targetId
                                           success:(void (^)(int nStatus))successBlock
                                             error:(void (^)(NSInteger status))errorBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"targetId"] = targetId;
    param[@"conversationType"] = @(conversationType);
    param[@"errorBlock"] = errorBlock;
    param[@"successBlock"] = successBlock;
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionGetConversationNotificationStatus params:param shouldCacheTarget:NO];
}

/// 断开与融云服务器的连接，并不再接收远程推送
- (void)mediator_logout {
    [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionLogout params:nil shouldCacheTarget:NO];
}

/*!
  收到消息的Notification
 */
- (NSString *)mediator_DispatchMessageNotification {
    return [self performTarget:QYCMediatorTargetQChat action:QYCMediatorActionDispatchMessageNotification params:nil shouldCacheTarget:NO];
}

@end
