//
//  CTMediator+QChat.h
//  Qiyeyun
//
//  Created by 启业云 on 2020/10/23.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (QChat)

/// 进入对话列表
- (UIViewController *)mediator_enterConversationListVC;

/// 进入对话详情
/// @param type 会话类型1单聊  3群聊
/// @param targetId 会话对象Id
/// @param title 会话标题
/// @param entId 会话所在的企业Id
- (UIViewController *)mediator_enterConversationVCWithType:(NSInteger)type targetId:(NSString *)targetId title:(NSString *)title entId:(NSString *)entId;

/// 打开个人详情页面
/// @param name 名称
/// @param userId 用户Id
/// @param imUserId 用户融云Id
/// @param url 用户图像链接（不传，默认采用UserId拼接，有时尽量传）
/// @param entId 对应的企业Id
- (UIViewController *)mediator_enterPersonDatailWithName:(NSString *)name userId:(NSString *)userId imUserId:(nullable NSString *)imUserId headPhotoUrl:(nullable NSString *)url entId:(nullable NSString *)entId;

/// 进入收藏页面
- (UIViewController *)mediator_enterFavorVC;

/// 进入二维码展示页面
///  @param entId 企业Id
/// @param name
/// @param identifier 启聊唯一标示/群id
/// @param number 启聊唯一标示/群id
/// @param type 类型：个人 / 群
/// @param headerUrl 头像Url
/// @param groupType 群类型
- (UIViewController *)mediator_enterChatQcodeVCWithEntId:(NSString *)entId name:(NSString *)name identifier:(NSString *)identifier number:(nullable NSString *)number chatQCodeType:(NSInteger)type headerUrl:(NSString *)headerUrl groupType:(NSInteger)groupType;

/// 进入共同企业页面
/// @param entId 企业Id
/// @param userId 用户Id
- (UIViewController *)mediator_enterOtherSpaceVCWithEntId:(NSString *)entId userId:(NSString *)userId;

/// 进入更多信息页面
/// @param entId 企业Id
/// @param userId 用户Id
- (UIViewController *)mediator_enterOtherFieldsVCWithEntId:(NSString *)entId userId:(NSString *)userId;

#pragma mark - 转发消息

/// 转发图片
/// @param imageData 图片内容
/// @param entId 对应的企业Id
- (UIViewController *)mediator_forwardImage:(NSData *)imageData entId:(NSString *)entId;

/// 转发富文本消息（图片链接）
/// @param entId 对应的企业Id
/// @param title 名称
/// @param digest 概要
/// @param imageURL 图片链接
/// @param url 链接地址
/// @param extra 而外信息
- (UIViewController *)mediator_forwardRichContentMessageWithEntId:(NSString *)entId
                                                            title:(NSString *)title
                                                           digest:(NSString *)digest
                                                         imageURL:(NSString *)imageURL
                                                              url:(NSString *)url
                                                            extra:(NSString *)extra;
/// 获取对话列表的Class
- (Class)mediator_conversationListClass;

/// 获取对话详情的Class
- (Class)mediator_conversationClass;

/// 获取个人详情的Class
- (Class)mediator_personDetailClass;

/// 如果会话列表在tabbar上，更新的tabbar的bagdeValue
/// @param vc 对应的控制器
- (void)mediator_updateBadgeValueForTabBarItem:(UIViewController *)vc;

/// 登陆链接融云
- (void)mediator_loginRCServer;

/// 断开融云的链接并移除token（远程推送并没有可以接受到）
- (void)mediator_disconnectAndRemoveToken;

/// 请求是否需求组织架构群
- (void)mediator_needOrgGroup;

/// 文件预览服务文件可以上传的最大上限
- (void)mediator_fetchUploadFileMaxSize;

/// 通过用户Id获取用户信息
/// @param userId 用户Id
/// @param callBack 回调
- (void)mediator_getPersonDataByUserId:(NSString *)userId callBack:(void (^_Nullable)(NSInteger code, NSDictionary *model))callBack;

/// 通过ImId获取信息
/// @param imId     会话Id
/// @param callBack 回调
- (void)mediator_getPersonDataByImId:(NSString *)imId callBack:(void (^_Nullable)(NSInteger code, NSDictionary *model))callBack;

///更新ImId缓存中的用户信息
/// @param imId     会话Id
/// @param callBack 回调
- (void)mediator_updataPersonCacheDataByImId:(NSString *)imId callBack:(void (^_Nullable)(NSInteger code, NSDictionary *model))callBack;

/// 更新融云中userId的信息
/// @param userId 对应的企业Id
- (void)mediator_updataPersonCacheDataByUserId:(NSString *)userId;

/// 获取通讯录
- (UIViewController *)mediator_contactsVC;

/// 创建群组
- (void)mediator_createGroupWithVC:(UIViewController *)vc;

/// 邀请加入群聊
/// @param url
/// @param presentStyle
- (UIViewController *)mediator_inviteJoinGroupChatVCWithLinkUrl:(NSString *)url presentStyle:(BOOL)presentStyle;

/// 申请加入页面
/// @param entId
/// @param name
/// @param discussId
/// @param discussUserId
- (UIViewController *)mediator_enterChatAddVCWithEntId:(NSString *)entId name:(NSString *)name discussId:(NSString *)discussId discussUserId:(NSString *)discussUserId;

/// <#Description#>
/// @param url <#url description#>
- (BOOL)mediator_judgeAcrossSpaceGroupLink:(NSString *)url;

/// 转发消息
/// @param messageModel <#messageModel description#>
- (UIViewController *)mediator_forwardMessageModel:(id)messageModel
                               selectedCancelBlock:(nullable void (^)(void))selectedCancelBlock
                                forwardCancelBlock:(nullable void (^)(void))forwardCancelBlock;

/// 融云文件图标
/// @param type <#type description#>
- (UIImage *)mediator_rcFileIconType:(NSString *)type;

/// 获取融云文件大小字符串
/// @param byteSize <#byteSize description#>
- (NSString *)mediator_getReadableStringForFileSize:(long long)byteSize;

/// 发送消息
/// @param msg <#msg description#>
/// @param conversationType <#conversationType description#>
/// @param targetId <#targetId description#>
- (void)mediator_sendMsg:(id)msg conversationType:(NSInteger)conversationType targetId:(NSString *)targetId;

#pragma mark - Message

- (id)mediator_creteMessageModelWithMsgContent:(id)msgContent objectName:(NSString *)objectName sentStatus:(NSUInteger)sentStatus;

- (id)mediator_createFileMsgWithName:(NSString *)name fileUrl:(NSString *)fileUrl size:(long long)size type:(NSString *)type localPath:(nullable NSString *)localPath;

- (id)mediator_createRichContentMessageWithTitle:(NSString *)title digest:(NSString *)digest imageURL:(NSString *)imageURL url:(NSString *)url extra:(NSString *)extra;

- (id)mediator_createGIFMessageWithRemoteUrl:(NSString *)remoteUrl gifDataSize:(long long)gifDataSize width:(long)width height:(long)height name:(NSString *)name;

- (id)mediator_createImageMessageWithImage:(UIImage *)image imageUrl:(nullable NSString *)imageUrl;

- (id)mediator_createTextMessageWithText:(NSString *)text;

/**
  @param row; ///<输入文本框最多展示行数，默认2行，最多5行
  @param isSend  是否发送
  @param message 留言信息
  @param void (^clickActionBlock)(BOOL isSend, NSString *message);
  展示转发弹框
  @param vc           弹起来源控制器
  @param name         转发给 xxx
  @param avatar       为nil时不展示用户图像
  @param placeholder  用户头像占位符，不传时内置默认占位图
  @param content      展示内容，类型为UIImage和NSURL时，展示图片，为NSString时展示文本
 */
- (UIViewController *)mediator_messageForwardViewControllerWithContent:(id)content name:(NSString *)name avatar:(NSString *)avatar placeholder:(NSString *)placeholder fromVC:(UIViewController *)vc row:(NSInteger)row clickActionBlock:(nullable void (^)(BOOL isSend, NSString *message))clickActionBlock;

/**
  是否只显示群。 默认NO，显示全部 BOOL groupSearch;
  是否是多选 默认是NO BOOL multiSelect;
  多选时，最大可以选择多少个,默认是 0 表示不限制个数.仅多选时有效即‘multiSelect’ 为YES有效.
  NSUInteger maxOfMultiSelect;
  选择数据后的回调
  void(^selectedGroupOrUser)(NSMutableArray <QYCContactModel*>*groupOrUser);
  取消按钮的回调dispatch_block_t  cancelBlock;
 */
- (UIViewController *)mediator_nearestContacterVCIsGroupSearch:(BOOL)groupSearch multiSelect:(BOOL)multiSelect maxOfMultiSelect:(NSUInteger)maxOfMultiSelect entId:(NSString *)entId selectedGroupBlock:(void (^)(NSMutableArray *groupOrUser, UIViewController *vc))selectedGroupBlock cancelBlock:(nullable dispatch_block_t)cancelBlock;

- (NSString *)mediator_forwardManagerTitleWithTargets:(NSMutableArray *)targets;

/**
 // 转发，默认NO
 @property (nonatomic, assign) BOOL forward;
 // 是否是多选 默认是NO
 BOOL multiSelect;
   多选时，最大可以选择多少个 默认是 0 表示不限制个数.仅多选时有效即‘multiSelect’ 为YES有效.
 NSUInteger maxOfMultiSelect;
 // 已选的数据(multiSelect为YES时会使用)
 NSMutableArray <QYCContactModel *> *selectedData;

 void(^selectedGroupOrUser)(NSMutableArray <QYCContactModel*>*groupOrUser);
 */

- (UIViewController *)mediator_contactsGroupVCEntId:(NSString *)entId forward:(BOOL)forward multiSelect:(BOOL)multiSelect maxOfMultiSelect:(NSUInteger)maxOfMultiSelect selectedData:(nullable NSMutableArray *)selectedData selectedBlock:(nullable void (^)(NSMutableArray *groupOrUser))selectedBlock;

/**
 @param dataEntId       应用来源企业Id
 @param vc              吊起页面控制器(传空值则使用keywindow的rootVc弹出)
 @param appId           应用Id
 @param appType         应用类型（DF:information、WF:workflow;）
 @param formId          详情页存在实例Id
 @param open            与列表页做区分,新建（设置值为"add"）
 @param nodeKey         WF传节点Id
 @param label           labelId
 */
- (void)mediator_shareAppDetailsWidthEndId:(NSString *)dataEntId fromVC:(UIViewController *)vc appId:(NSString *)appId appType:(NSString *)appType formId:(nullable NSString *)formId  open:(nullable NSString *)open  nodeKey:(nullable NSString *)nodeKey label:(nullable NSString *)label;



#pragma mark - 融云消息操作

///  获取当前用户登录的融云信息
/// @return 当前的用户信息 { userId:用户Id, name:用户名称, avatar:用户图像链接 }
- (NSDictionary *)mediator_currentUserInfo;

///  获取当前用户登录的融云Id
- (NSString *)mediator_currentUserImId;

/// 获取某些类型的会话中所有的未读消息数（聊天室会话除外）
/// @param conversationTypes 会话类型的数组
/// @param isContain 是否包含免打扰消息的未读数
/// @return 该类型的会话中所有的未读消息数
- (int)mediator_getUnreadCount:(NSArray *)conversationTypes containBlocked:(bool)isContain;

/// 刷新当前融云用户信息
/// @param userImId 用户的I吗Id
/// @param userName 用户名称
/// @param avatar 用户图像链接
- (void)mediator_refreshUserInfoCache:(NSString *)userImId name:(NSString *)userName avatar:(NSString *)avatar;

/// 清理所有群组融云缓存
/// @param groupId 群组Id
- (void)mediator_clearGroupInfoCache;

/// 清理所有用户融云缓存
/// @param userImId 用户ImId
- (void)mediator_clearUserInfoCache;

/// 全局屏蔽某个时间段的消息提醒
/// @param startTime 开始消息免打扰时间，格式为 HH:MM:SS
/// @param spanMins  需要消息免打扰分钟数，0 < spanMins < 1440（ 比如，您设置的起始时间是 00：00， 结束时间为23：59，则 spanMins 为 23 * 60 + 59 = 1339 分钟。）
/// @param successBlock  屏蔽成功的回调
/// @param errorBlock 屏蔽失败的回调 [status:屏蔽失败的错误码]
- (void)mediator_setNotificationQuietHours:(NSString *)startTime
                                  spanMins:(int)spanMins
                                   success:(void (^)(void))successBlock
                                     error:(void (^)(NSInteger status))errorBlock;

/// 删除已设置的全局时间段消息提醒屏蔽
/// @param successBlock 删除屏蔽成功的回调
/// @param errorBlock  删除屏蔽失败的回调 [status:失败的错误码]
- (void)mediator_removeNotificationQuietHours:(void (^)(void))successBlock error:(void (^)(NSInteger status))errorBlock;

/// 查询已设置的全局时间段消息提醒屏蔽
/// @param successBlock  屏蔽成功的回调 [startTime:已设置的屏蔽开始时间, spansMin:已设置的屏蔽时间分钟数，0 < spansMin < 1440]
/// @param errorBlock 查询失败的回调 [status:查询失败的错误码]
- (void)mediator_getNotificationQuietHours:(void (^)(NSString *startTime, int spansMin))successBlock
                                     error:(void (^)(NSInteger status))errorBlock;

/// 清除消息未读数
/// @param conversationType 会话类型，单聊: 1, 群组: 3, 系统会话: 6
/// @param targetId  会话 ID
- (void)mediator_clearMessagesUnreadStatus:(int)conversationType targetId:(NSString *)targetId;

///  设置消息是否置顶
/// @param conversationType 会话类型，单聊: 1, 群组: 3, 系统会话: 6
/// @param targetId  会话 ID
/// @param isTop 是否置顶
/// @return  设置是否成功
- (BOOL)mediator_setConversionToTop:(int)conversationType targetId:(NSString *)targetId isTop:(BOOL)isTop;

/// 获取单个会话是否置顶
/// @param conversationType 会话类型，单聊: 1, 群组: 3, 系统会话: 6
/// @param targetId 会话 ID
/// @return   是否置顶
- (BOOL)mediator_getConversionToTop:(int)conversationType targetId:(NSString *)targetId;

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
                                            error:(void (^)(NSInteger status))errorBlock;


///  查询会话的消息提醒状态
/// @param conversationType  会话类型，单聊: 1, 群组: 3, 系统会话: 6
/// @param targetId 会话 ID
/// @param successBlock 查询成功的回调 [nStatus:会话设置的消息提醒状态]
/// @param errorBlock 查询失败的回调 [status:设置失败的错误码]
- (void)mediator_getConversationNotificationStatus:(int)conversationType
                                          targetId:(NSString *)targetId
                                           success:(void (^)(int nStatus))successBlock
                                             error:(void (^)(NSInteger status))errorBlock;

/// 断开与融云服务器的连接，并不再接收远程推送
- (void)mediator_logout;


#pragma mark - 融云通知的变量
/*!
  收到消息的Notification

 @discussion 接收到消息后，SDK会分发此通知。

 Notification的object为RCMessage消息对象。
 userInfo为NSDictionary对象，其中key值为@"left"，value为还剩余未接收的消息数的NSNumber对象。

 与RCIMReceiveMessageDelegate的区别:
 RCKitDispatchMessageNotification只要注册都可以收到通知；RCIMReceiveMessageDelegate需要设置监听，并同时只能存在一个监听。
 */
- (NSString *)mediator_DispatchMessageNotification;
@end

NS_ASSUME_NONNULL_END
