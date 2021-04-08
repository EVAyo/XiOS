//
//  CTMediator+QYCWorkCircleModuleActions.h
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/10/30.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

//外部分享的类型key
FOUNDATION_EXTERN NSString *const QYCWCSendTypeKey;

//外部分享的链接内容key
FOUNDATION_EXTERN NSString *const QYCWCSendLinkUrl;
FOUNDATION_EXTERN NSString *const QYCWCSendLinkTitle;

//外部分享的文件内容key(array)
FOUNDATION_EXTERN NSString *const QYCWCSendFileName;
FOUNDATION_EXTERN NSString *const QYCWCSendFileSize;
FOUNDATION_EXTERN NSString *const QYCWCSendFileObject;
FOUNDATION_EXTERN NSString *const QYCWCSendFileUrl;
FOUNDATION_EXTERN NSString *const QYCWCSendFileLocalPath;

//外部分享的图片内容key（array）
FOUNDATION_EXTERN NSString *const QYCWCSendPic;

//外部分享的文本内容key
FOUNDATION_EXTERN NSString *const QYCWCSendText;

//外部分享至工作圈类型
typedef NS_ENUM(NSInteger, QYCWCSendType) {
    QYCWCSendTypeText = 0,
    QYCWCSendTypePic,
    QYCWCSendTypeFile,
    QYCWCSendTypeLink,
    QYCWCSendTypeUnknow,
};

@interface CTMediator (QYCWorkCircleModuleActions)

/// 进入个人动态页
/// @param userId 用户Id
- (UIViewController *)mediator_enterPersonalTrendsVCWithUserId:(NSString *)userId;

/// 进入工作圈页
/// @param entId 企业Id
/// @param title 标题
- (UIViewController *)mediator_enterWorkCircleVCWithEntId:(NSString *)entId title:(nullable NSString *)title;

/// <#Description#>
- (Class)mediator_discoverViewControllerClass;

/// <#Description#>
- (Class)mediator_workCicleViewControllerClass;

/// <#Description#>
/// @param entId <#entId description#>
/// @param vc <#vc description#>
- (void)mediator_updateTabNumberForWorkCircleWithEntId:(NSString *)entId vc:(UIViewController *)vc;

/**
 @param items NSString或者NSDictionary(可键值：thumbView（UIImage）、url、width、height、gifDataSize或dataSize)
 */
- (UIView *)mediator_presentPhotoGroupViewFromView:(nullable UIView *)fromView
                                       toContainer:(nullable UIView *)toContainer
                                             items:(nullable NSArray *)items
                                             frame:(CGRect)frame
                                          animated:(BOOL)animated
                                     fromItemIndex:(NSInteger)fromItemIndex
                                       hiddenPager:(BOOL)hiddenPager
                                        canForward:(BOOL)canForward
                                          canShare:(BOOL)canShare
                                       canDownload:(BOOL)canDownload
                        customLongPressActionBlock:(nullable NSArray<UIAlertAction *> * (^)(UIImage *image))callBlock
                                        completion:(nullable void (^)(void))completion;

/// 接口调用发帖
/// @param params <#params description#>
/// @param callback <#callback description#>
- (UIViewController *)mediator_remoteSharePost:(NSDictionary *)params
                                      callback:(nullable void (^)(BOOL success))callback;

/// 自定义发送（只拿取发送数据回调）
/// @param params 参数
/// @param customPostSend 发送数据的回调
- (UIViewController *)mediator_remoteSharePost:(nullable NSDictionary *)params
                                customPostSend:(void (^)(NSDictionary *params, NSArray *uploadObjects))customPostSend;

/// Just for FlutterViewController
- (UIViewController *)mediator_remoteSharePostWithCustomPostSend_Flutter:(void (^)(NSDictionary *params, NSArray *uploadObjects))customPostSend;

#pragma mark - ================ WorkCircleHelper =================

/// 解析属性字符串中的 at,表情，链接
/// @param text NSMutableAttributedString
/// @param font int
/// @param canATL BOOL
/// @param customAtRouter  自定义at的点击路由  (BOOL (^)(id data))
/// @param customURLRouter 自定义链接的点击路由 (BOOL (^)(id data))
- (NSMutableAttributedString *)mediator_parseAttributedString:(NSMutableAttributedString *)text
                                                     withFont:(int)font
                                             CanATLDepartment:(BOOL)canATL
                                               customAtRouter:(nullable BOOL (^)(id data))customAtRouter
                                              customURLRouter:(nullable BOOL (^)(id data))customURLRouter;

/// 解析属性字符串中的 at,表情，链接
/// @param text NSString
/// @param font int
/// @param canATL BOOL
- (NSMutableAttributedString *)mediator_parseString:(NSString *)text
                                           withFont:(int)font
                                   CanATLDepartment:(BOOL)canATL;

/// 解析字符串种的URL
/// @param text NSString
/// @param font int
/// @param canATL BOOL
/// @param block 回调
- (NSMutableAttributedString *)mediator_parseStringURL:(NSString *)text
                                              withFont:(int)font
                                                canATL:(BOOL)canATL
                                                 block:(void (^)(NSString *urlString))block;

/// 过滤字符串中@和emoji表情
/// @param text 需要过滤的字符串
/// @param workCircle workCircle 是否是工作圈中的（其他地方的@解析不一致，有个（type：member））
/// @return 过来后的字符串
- (NSString *)mediator_filterAtAndEmoji:(NSString *)text forWorkcircle:(BOOL)workCircle;

/// 请求工作圈未读数
/// @param reddot <#reddot description#>
/// @param callback <#callback description#>
- (void)mediator_requestWorkWorldUnreadCountWithDisplayReddot:(BOOL)reddot entId:(NSString *)entId callback:(void (^)(BOOL success, id data))callback;

- (UIView *)mediator_EmoticonInputView:(void (^)(NSString *))didTapTextBlock didTapBackspaceBlock:(void (^)(void))didTapBackspaceBlock;

- (NSRegularExpression *)mediator_regexEmoji;

- (NSBundle *)mediator_emoticonBundle;

- (UIImage *)mediator_WBImageWithPath:(NSString *)path;

- (NSRegularExpression *)mediator_regexQYCAt;
@end

NS_ASSUME_NONNULL_END
