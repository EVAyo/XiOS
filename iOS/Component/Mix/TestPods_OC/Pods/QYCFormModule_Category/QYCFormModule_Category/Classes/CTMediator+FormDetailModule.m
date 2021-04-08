//
//  CTMediator+FormDetailModule.m
//  Qiyeyun
//
//  Created by 安元科技 on 2020/10/26.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator+FormDetailModule.h"
NSString *const QYCMediatorTargetFormDetail                        = @"FormDetail";
NSString *const QYCMediatorActionNativFetchDataFlowVC              = @"nativeFetchDataFlowVC";
NSString *const QYCMediatorActionNativFetchWorkFlowVC              = @"nativeFetchWorkFlowVC";
NSString *const QYCMediatorActionNativUserSigntureRequest          = @"nativeUserSigntureRequest";
NSString *const QYCMediatorActionAttachmentUrlDownload             = @"attachmentUrlDownload";
NSString *const QYCMediatorActionAttachmentattachmentUploadFile    = @"attachmentUploadFileWithTableId";
NSString *const QYCMediatorActionAttachmentDownlaodBaseURL         = @"attachmentDownlaodBaseURL";
NSString *const QYCMediatorActionAttachmentInputView               = @"attachmentInputView";
NSString *const QYCMediatorActionNativeDFAddRecord                 = @"nativeDFAddRecord";
NSString *const QYCMediatorActionNativeFetchTextEditVC             = @"nativeFetchTextEditVC";
NSString *const QYCMediatorActionNativeFetchHistoryVC              = @"nativeFetchHistoryVC";
NSString *const QYCMediatorActionNativeFetchRadioPresentView       = @"nativeFetchRadioPresentView";
NSString *const QYCMediatorActionNativeFetchImageEditVC            = @"nativeFetchImageEditVC";
NSString *const QYCMediatorActionNativeFetchAttachmentSignatureVC  = @"nativeFetchAttachmentSignatureVC";
NSString *const QYCMediatorActionNativeFetchShowAttachVC           = @"nativeFetchShowAttachVC";
NSString *const QYCMediatorActionNativeFetchGetRowSubTypeWithField = @"nativeFetchGetRowSubTypeWithField";
NSString *const QYCMediatorActionOpenAnswerDetaileViewController   = @"openAnswerDetaileViewController";
NSString *const QYCMediatorActionOpenFormShareFieldViewController  = @"openFormShareFieldViewController";
NSString *const QYCMediatorActionOpenNewHistoryViewController      = @"openNewHistoryViewController";
NSString *const QYCMediatorActionOpenPermissionsViewController     = @"openPermissionsViewController";
NSString *const QYCMediatorActionOpenCoordinateViewController      = @"openCoordinateViewController";
NSString *const QYCMediatorActionOpenDSSelectionViewController     = @"openDSSelectionViewController";
NSString *const QYCMediatorActionNativeFetchRichTextVC             = @"nativeFetchRichTextVC";
NSString *const QYCMediatorActionNativeFetchOrgWhiteCell           = @"nativeFetchOrgWhiteCell";
NSString *const QYCMediatorActionNativeFetchOrgWhiteBlackCell      = @"nativeFetchOrgWhiteBlackCell";
NSString *const QYCMediatorActionStringFromOrgWhiteCell            = @"stringFromOrgWhiteCell";
NSString *const QYCMediatorActionStringFromOrgWhiteBlackCell       = @"stringFromOrgWhiteBlackCell";
NSString *const QYCMediatorActionDetailSendFileForChatRequest       = @"detailSendFileForChatRequest";

@implementation CTMediator (FormDetailModule)
- (UIViewController *)mediator_openDataflowVC:(NSDictionary *)param {
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativFetchDataFlowVC params:param shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_openWorkflowVC:(NSDictionary *)param {
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativFetchWorkFlowVC params:param shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (void)mediator_userSigntureRequest {
    [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativUserSigntureRequest params:nil shouldCacheTarget:NO];
}

- (void)mediator_attachmentDownloadWithURL:(NSString *)url progress:(void (^_Nullable)(NSProgress *downProgress))downProgress callback:(void (^)(BOOL success, NSString *_Nullable filePath))callback {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:url forKey:@"url"];
    [param setValue:downProgress forKey:@"downProgress"];
    [param setValue:callback forKey:@"callback"];
    [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionAttachmentUrlDownload params:param.copy shouldCacheTarget:NO];
}

- (void)mediator_attachmentUploadFileWithTableId:(NSString *)tableId fieldId:(NSString *)fieldId recordId:(NSString *)recordId uploadParams:(NSArray *)uploadParams callback:(void (^)(BOOL success, NSArray *_Nullable fileNames))callback {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:tableId forKey:@"tableId"];
    [param setValue:fieldId forKey:@"fieldId"];
    [param setValue:recordId forKey:@"recordId"];
    [param setValue:uploadParams forKey:@"uploadParams"];
    [param setValue:callback forKey:@"callback"];
    [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionAttachmentattachmentUploadFile params:param.copy shouldCacheTarget:NO];
}

- (NSString *)mediator_attachmentDownlaodBaseURL {
    return [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionAttachmentDownlaodBaseURL params:nil shouldCacheTarget:NO];
}

- (UIView *)mediator_AttachmentInputViewCameraBlock:(dispatch_block_t)cameraBlock photoAblum:(dispatch_block_t)photoAblumBlock file:(void (^)(id file))fileBlock cancle:(dispatch_block_t)cancleBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:cameraBlock forKey:@"cameraBlock"];
    [param setValue:photoAblumBlock forKey:@"photoAblumBlock"];
    [param setValue:fileBlock forKey:@"fileBlock"];
    [param setValue:cancleBlock forKey:@"cancleBlock"];

    return [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionAttachmentInputView params:param shouldCacheTarget:NO];
}

- (void)mediator_DFAddRecordWithTableId:(NSString *)tableId entId:(NSString *)entId recordId:(NSString *)recordId params:(NSDictionary *)params isShowAlter:(BOOL)showAlert callback:(void (^)(BOOL succ, id data))callback {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:tableId forKey:@"tableId"];
    [dic setValue:entId forKey:@"entId"];
    [dic setValue:recordId forKey:@"recordId"];
    [dic setValue:params forKey:@"params"];
    [dic setValue:@(showAlert) forKey:@"showAlert"];
    [dic setValue:callback forKey:@"callback"];
    [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativeDFAddRecord params:dic shouldCacheTarget:NO];
}

- (UIViewController *)mediator_openTextEditViewController:(NSString *)title text:(NSString *)disPlayText edit:(BOOL)isEdit textBlock:(void (^)(NSString *text))textBlock {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:title forKey:@"title"];
    [dic setValue:disPlayText forKey:@"disPlayText"];
    [dic setValue:@(isEdit) forKey:@"isEdit"];
    [dic setValue:textBlock forKey:@"textBlock"];
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativeFetchTextEditVC params:dic shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_openHistoryVcWithAppId:(NSString *)appId tableId:(NSString *)tableId recordId:(NSString *)recordId entId:(NSString *)entId {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:appId forKey:@"appId"];
    [dic setValue:tableId forKey:@"tableId"];
    [dic setValue:recordId forKey:@"recordId"];
    [dic setValue:entId forKey:@"entId"];
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativeFetchHistoryVC params:dic shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIView *)mediator_radioPresentViewWithRadio:(BOOL)isRadio dataSourceArray:(NSArray *)dataSourceArray selectedArr:(NSMutableArray *)selectedArr selectedData:(void (^)(NSMutableArray *data))selectedData {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(isRadio) forKey:@"isRadio"];
    [dic setValue:dataSourceArray forKey:@"dataSourceArray"];
    [dic setValue:selectedArr forKey:@"selectedArr"];
    [dic setValue:selectedData forKey:@"selectedData"];
    return [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativeFetchRadioPresentView params:dic shouldCacheTarget:NO];
}

- (UIViewController *)mediator_imageEditVCWithImages:(NSMutableArray<UIImage *> *)images isCamera:(BOOL)isCamera callBack:(void (^)(NSArray<UIImage *> *imageList))callBack {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(isCamera) forKey:@"isCamera"];
    [dic setValue:images forKey:@"imageList"];
    [dic setValue:callBack forKey:@"callBackData"];
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativeFetchImageEditVC params:dic shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_attachmentSignatureVCWithParams:(NSDictionary *)params upLoadType:(NSString *)upLoadType callBack:(nullable void (^)(id params))callback {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:params forKey:@"param"];
    [dic setValue:upLoadType forKey:@"upLoadType"];
    [dic setValue:callback forKey:@"callback"];
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativeFetchAttachmentSignatureVC params:dic shouldCacheTarget:YES];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}
- (UIViewController *)mediator_showAttachVcWithEntID:(NSString *)entId sourcePath:(NSString *)sourcePath title:(NSString *)title {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:entId forKey:@"entId"];
    [dic setValue:sourcePath forKey:@"sourcePath"];
    [dic setValue:title forKey:@"title"];
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativeFetchShowAttachVC params:dic shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}
- (UIViewController *)mediator_openAnswerDetaileViewControllerWithEntId:(NSString *)entId
                                                                 appKey:(NSString *)appKey {
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionOpenAnswerDetaileViewController params:@{@"entId" : entId ?: @"", @"appKey" : appKey ?: @""} shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}
- (UIViewController *)mediator_openFormShareFieldViewControllerWithEntId:(NSString *)entId
                                                                   appId:(NSString *)appId
                                                                 records:(NSArray *)records
                                                                callBack:(void (^)(BOOL))callBack {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"entId"]            = entId ?: @"";
    params[@"appId"]            = appId ?: @"";
    params[@"records"]         = records ?: @[];
    if (callBack) {
        params[@"callBack"] = callBack;
    }
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionOpenFormShareFieldViewController params:params shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}
- (UIViewController *)mediator_openNewHistoryViewControllerWithEntId:(NSString *)entId
                                                               appId:(nonnull NSString *)appId
                                                             tableId:(nullable NSString *)tableId
                                                            recordId:(nonnull NSString *)recordId
                                                             appType:(nonnull NSString *)appType
                                                              nodeId:(nullable NSString *)nodeId
                                                        real_handler:(nullable NSString *)real_handler {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"entId"]            = entId ?: @"";
    params[@"appId"]            = appId ?: @"";
    params[@"recordId"]         = recordId ?: @"";
    params[@"appType"]          = appType ?: @"workflow";
    if (tableId.length > 0) {
        params[@"tableId"] = tableId;
    }
    if (nodeId.length > 0) {
        params[@"nodeId"] = nodeId;
    }
    if (real_handler.length > 0) {
        params[@"real_handler"] = real_handler;
    }
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionOpenNewHistoryViewController params:params shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}
- (UIViewController *)mediator_openPermissionsViewControllerWithEntId:(NSString *)entId
                                                              tableId:(NSString *)tableId
                                                             recordId:(NSString *)recordId {
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionOpenPermissionsViewController params:@{@"entId" : entId ?: @"", @"tableId" : tableId ?: @"", @"recordId" : recordId ?: @""} shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}
- (UIViewController *)mediator_openCoordinateViewControllerWithEntId:(NSString *)entId
                                                             locDict:(NSDictionary *)locDict {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:locDict];
    param[@"entId"]            = entId;
    UIViewController *vc       = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionOpenCoordinateViewController params:param shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}
- (UIViewController *)mediator_openDSSelectionViewControllerWithEntId:(NSString *)entId
                                                                title:(NSString *)title
                                                              canEdit:(BOOL)canEdit
                                                                isOrg:(BOOL)isOrg
                                                                raido:(BOOL)raido
                                                              rowType:(NSString *)rowType
                                                            selectArr:(NSArray *)selectArr
                                                                 link:(NSDictionary *)link
                                                         controlField:(NSDictionary *)controlField
                                                             callBack:(void (^)(NSArray *_Nonnull, NSArray *_Nonnull))callBack {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"entId"]            = entId;
    param[@"title"]            = title;
    param[@"canEdit"]          = [NSNumber numberWithBool:canEdit];
    param[@"isOrg"]            = [NSNumber numberWithBool:isOrg];
    param[@"raido"]            = [NSNumber numberWithBool:raido];
    param[@"rowType"]          = rowType;
    param[@"selectArr"]        = selectArr;
    param[@"link"]             = link;
    param[@"controlField"]     = controlField;
    if (callBack) {
        param[@"callBack"] = callBack;
    }
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionOpenDSSelectionViewController params:param shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (NSString *)mediator_getRowSubTypeWithField:(NSDictionary *)fieldSchema {
    return [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativeFetchGetRowSubTypeWithField params:fieldSchema shouldCacheTarget:NO];
}

- (UIViewController *)mediator_openRichTextVCWithEntId:(NSString *)entId tableId:(NSString *)tableId fieldId:(NSString *)fieldId title:(NSString *)title content:(NSString *)content canEdit:(BOOL)canEdit callBack:(void (^)(NSString *text))callBack {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:entId forKey:@"entId"];
    [dic setValue:tableId forKey:@"tableId"];
    [dic setValue:fieldId forKey:@"fieldId"];
    [dic setValue:title forKey:@"title"];
    [dic setValue:content forKey:@"content"];
    [dic setValue:@(canEdit) forKey:@"editable"];
    [dic setValue:callBack forKey:@"callBack"];
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativeFetchRichTextVC params:dic shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UICollectionViewCell *)mediator_reusableOrgWhiteCellWithParam:(NSDictionary *)param collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:param forKey:@"param"];
    [dic setValue:collectionView forKey:@"collectionView"];
    [dic setValue:indexPath forKey:@"indexPath"];
    return [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativeFetchOrgWhiteCell params:dic shouldCacheTarget:NO];
}

- (UICollectionViewCell *)mediator_reusableOrgWhiteBlackCellWithParam:(NSDictionary *)param collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:param forKey:@"param"];
    [dic setValue:collectionView forKey:@"collectionView"];
    [dic setValue:indexPath forKey:@"indexPath"];
    return [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionNativeFetchOrgWhiteBlackCell params:dic shouldCacheTarget:NO];
}

- (NSString *)mediator_stringFromOrgWhiteCell {
    return [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionStringFromOrgWhiteCell params:@{} shouldCacheTarget:NO];
}

- (NSString *)mediator_stringFromOrgWhiteBlackCell {
    return [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionStringFromOrgWhiteBlackCell params:@{} shouldCacheTarget:NO];
}

- (void)mediator_detailSendFileForChatRequestEntId:(NSString *)entId
                                           userIds:(NSArray *)userIds
                                          groupIds:(NSArray *)groupIds
                                               fid:(NSString *)fid
                                              from:(NSString *)from
                                           message:(NSString *)message
                                          callback:(void (^)(BOOL sucess,id data))callback{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:entId forKey:@"entId"];
    [dic setValue:userIds forKey:@"userIds"];
    [dic setValue:groupIds forKey:@"groupIds"];
    [dic setValue:fid forKey:@"fid"];
    [dic setValue:from forKey:@"from"];
    [dic setValue:message forKey:@"message"];
    [dic setValue:callback forKey:@"callback"];
    [self performTarget:QYCMediatorTargetFormDetail action:QYCMediatorActionDetailSendFileForChatRequest params:dic shouldCacheTarget:NO];
}
@end
