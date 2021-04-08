//
//  CTMediator+QYCWorkCircleModuleActions.m
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/10/30.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator+QYCWorkCircleModuleActions.h"

NSString *const QYCWCSendTypeKey       = @"remoteShareTypeKey";
NSString *const QYCWCSendText          = @"remoteShareText";
NSString *const QYCWCSendPic           = @"remoteSharePic";
NSString *const QYCWCSendFileName      = @"remoteShareFileName";
NSString *const QYCWCSendFileSize      = @"remoteShareFileSize";
NSString *const QYCWCSendFileObject    = @"remoteShareFileObject";
NSString *const QYCWCSendLinkUrl       = @"remoteShareLinkUrl";
NSString *const QYCWCSendLinkTitle     = @"remoteShareLinkTitle";
NSString *const QYCWCSendFileUrl       = @"remoteShareFileUrl";
NSString *const QYCWCSendFileLocalPath = @"remoteShareFileLocalPath";

NSString *const kQYCMediatorTargetWorkCircleModule = @"WorkCircleModule";

NSString *const kQYCMediatorActionEnterPersonalTrendsVC = @"enterPersonalTrendsVC";

NSString *const kQYCMediatorActionEnterWorkCircleVC = @"enterWorkCicleVC";

NSString *const kQYCMediatorActionDiscoverViewControllerClass = @"discoverViewControllerClass";

NSString *const kQYCMediatorActionWorkCicleViewControlleClass = @"workCicleViewControllerClass";

NSString *const kQYCMediatorActionUpdateTabNumberForWorkCircle = @"updateTabNumberForWorkCircle";

NSString *const kQYCMediatorActionPresentPhotoGroupView = @"presentPhotoGroupView";

NSString *const kQYCMediatorActionremoteSharePost       = @"remoteSharePost";
NSString *const kQYCMediatorActionremoteShareCustomPost = @"customRemoteSharePost";
NSString *const kQYCMediatorActionremoteShareCustomPost_Flutter = @"customRemoteSharePost_Flutter";

NSString *const kQYCMediatorActionWorkCircleHelperParseAttributedString = @"workCircleHelperParseAttributedString";

NSString *const kQYCMediatorActionWorkCircleHelperParseString = @"workCircleHelperParseString";

NSString *const kQYCMediatorActionWorkCircleHelperParseStringURL = @"workCircleHelperParseStringURL";

NSString *const kQYCMediatorActionFilterAtAndEmoji = @"filterAtAndEmoji";

NSString *const kQYCMediatorActionrequestWorkWorldUnreadCount = @"requestWorkWorldUnreadCount";

NSString *const kQYCMediatorActionEmoticonInputView = @"EmoticonInputView";

NSString *const kQYCMediatorActionRegexEmoji = @"regexEmoji";

NSString *const kQYCMediatorActionEmoticonBundle = @"emoticonBundle";

NSString *const kQYCMediatorActionWBImageFormParam = @"WBImageFormParam";

NSString *const kQYCMediatorActionRegexQYCAt = @"regexQYCAt";

@implementation CTMediator (QYCWorkCircleModuleActions)

- (UIViewController *)mediator_enterPersonalTrendsVCWithUserId:(NSString *)userId {
    UIViewController *vc = [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionEnterPersonalTrendsVC params:@{@"userId" : userId ?: @""} shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_enterWorkCircleVCWithEntId:(NSString *)entId title:(NSString *)title {
    UIViewController *vc = [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionEnterWorkCircleVC params:@{@"entId" : entId ?: @"", @"title" : title ?: @""} shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (Class)mediator_discoverViewControllerClass {
    return [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionDiscoverViewControllerClass params:nil shouldCacheTarget:NO];
}

- (Class)mediator_workCicleViewControllerClass {
    return [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionWorkCicleViewControlleClass params:nil shouldCacheTarget:NO];
}

- (void)mediator_updateTabNumberForWorkCircleWithEntId:(NSString *)entId vc:(UIViewController *)vc {
    [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionUpdateTabNumberForWorkCircle params:nil shouldCacheTarget:NO];
}

/**
 items NSString或者NSDictionary(可键值：thumbView（UIImage）、url、width、height、gifDataSize或dataSize)
 */
- (UIView *)mediator_presentPhotoGroupViewFromView:(UIView *)fromView
                                       toContainer:(UIView *)toContainer
                                             items:(NSArray *)items
                                             frame:(CGRect)frame
                                          animated:(BOOL)animated
                                     fromItemIndex:(NSInteger)fromItemIndex
                                       hiddenPager:(BOOL)hiddenPager
                                        canForward:(BOOL)canForward
                                          canShare:(BOOL)canShare
                                       canDownload:(BOOL)canDownload
                        customLongPressActionBlock:(NSArray<UIAlertAction *> *_Nonnull (^)(UIImage *_Nonnull))callBlock
                                        completion:(void (^)(void))completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"fromView"]         = fromView;
    param[@"toContainer"]      = toContainer;
    param[@"items"]            = items;
    param[@"frame"]            = NSStringFromCGRect(frame);
    param[@"animated"]         = @(animated);
    param[@"fromItemIndex"]    = @(fromItemIndex);
    param[@"hiddenPager"]      = @(hiddenPager);
    param[@"canForward"]       = @(canForward);
    param[@"canShare"]         = @(canShare);
    param[@"canDownload"]      = @(canDownload);
    param[@"callBlock"]        = callBlock;
    param[@"completion"]       = completion;
    return [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionPresentPhotoGroupView params:param shouldCacheTarget:NO];
}
- (UIViewController *)mediator_remoteSharePost:(NSDictionary *)params
                                      callback:(nullable void (^)(BOOL))callback {
    NSMutableDictionary *p = [NSMutableDictionary dictionary];
    if (p) {
        [p setValue:params forKey:@"params"];
    }
    if (callback) {
        [p setValue:callback forKey:@"callback"];
    }
    UIViewController *vc = [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionremoteSharePost params:p shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (void)mediator_requestWorkWorldUnreadCountWithDisplayReddot:(BOOL)reddot entId:(NSString *)entId callback:(void (^)(BOOL success, id data))callback {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setValue:@(reddot) forKey:@"reddot"];
    if (entId) {
        [params setValue:entId forKey:@"entId"];
    }
    if (callback) {
        [params setValue:callback forKey:@"callback"];
    }
    [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionrequestWorkWorldUnreadCount params:params shouldCacheTarget:NO];
}

- (UIViewController *)mediator_remoteSharePost:(nullable NSDictionary *)params
                                customPostSend:(void (^)(NSDictionary *params, NSArray *uploadObjects))customPostSend {
    NSMutableDictionary *p = [NSMutableDictionary dictionary];
    if (p) {
        [p setValue:params forKey:@"params"];
    }
    if (customPostSend) {
        [p setValue:customPostSend forKey:@"customPostSend"];
    }
    UIViewController *vc = [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionremoteShareCustomPost params:p shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (UIViewController *)mediator_remoteSharePostWithCustomPostSend_Flutter:(void (^)(NSDictionary *params, NSArray *uploadObjects))customPostSend {
    NSMutableDictionary *p = [NSMutableDictionary dictionary];
    if (customPostSend) {
        [p setValue:customPostSend forKey:@"customPostSend"];
    }
    UIViewController *vc = [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionremoteShareCustomPost_Flutter params:p shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

#pragma mark - ================ WorkCircleHelper =================

- (NSMutableAttributedString *)mediator_parseAttributedString:(NSMutableAttributedString *)text
                                                     withFont:(int)font
                                             CanATLDepartment:(BOOL)canATL
                                               customAtRouter:(BOOL (^)(id _Nonnull))customAtRouter
                                              customURLRouter:(BOOL (^)(id _Nonnull))customURLRouter {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"text"]             = text;
    param[@"font"]             = [NSNumber numberWithInt:font];
    param[@"canATL"]           = [NSNumber numberWithBool:canATL];
    param[@"customAtRouter"]   = customAtRouter;
    param[@"customURLRouter"]  = customURLRouter;
    return [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionWorkCircleHelperParseAttributedString params:param shouldCacheTarget:NO];
}

- (NSMutableAttributedString *)mediator_parseString:(NSString *)text
                                           withFont:(int)font
                                   CanATLDepartment:(BOOL)canATL {
    NSDictionary *params = @{@"text" : text ?: @"",
                             @"font" : [NSNumber numberWithInt:font] ?: @16,
                             @"canATL" : [NSNumber numberWithBool:canATL] ?: @NO};
    return [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionWorkCircleHelperParseString params:params shouldCacheTarget:NO];
}

/// 解析字符串种的URL
/// @param text NSString
/// @param canATL BOOL
/// @param block 回调
- (NSMutableAttributedString *)mediator_parseStringURL:(NSString *)text withFont:(int)font canATL:(BOOL)canATL block:(void (^)(NSString *urlString))block {
    NSDictionary *dic = @{@"text" : text ?: @"",
                          @"font" : [NSNumber numberWithInt:font] ?: @16,
                          @"canATL" : [NSNumber numberWithBool:canATL] ?: @NO};
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:dic];
    if (block) {
        [params setValue:block forKey:@"block"];
    }
    return [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionWorkCircleHelperParseStringURL params:params shouldCacheTarget:NO];
}

- (NSString *)mediator_filterAtAndEmoji:(NSString *)text forWorkcircle:(BOOL)workCircle {
    NSDictionary *params = @{@"text" : text ?: @"",
                             @"forWorkcircle" : [NSNumber numberWithBool:workCircle] ?: @YES};
    return [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionFilterAtAndEmoji params:params shouldCacheTarget:NO];
}
- (UIView *)mediator_EmoticonInputView:(void (^)(NSString *))didTapTextBlock didTapBackspaceBlock:(void (^)(void))didTapBackspaceBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:didTapTextBlock forKey:@"didTapTextBlock"];
    [param setValue:didTapBackspaceBlock forKey:@"didTapBackspaceBlock"];
    return [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionEmoticonInputView params:param shouldCacheTarget:YES];
}

- (NSRegularExpression *)mediator_regexEmoji {
    return [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionRegexEmoji params:@{} shouldCacheTarget:NO];
}

- (NSBundle *)mediator_emoticonBundle {
    return [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionEmoticonBundle params:@{} shouldCacheTarget:NO];
}

- (UIImage *)mediator_WBImageWithPath:(NSString *)path {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:path forKey:@"path"];
    return [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionWBImageFormParam params:param shouldCacheTarget:NO];
}

- (NSRegularExpression *)mediator_regexQYCAt {
    return [self performTarget:kQYCMediatorTargetWorkCircleModule action:kQYCMediatorActionRegexQYCAt params:@{} shouldCacheTarget:NO];
}

@end
