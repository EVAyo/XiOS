//
//  CTMediator+FormDetailModule.h
//  Qiyeyun
//
//  Created by 安元科技 on 2020/10/26.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (FormDetailModule)

/*
 *DF 入参
        NSString *appId; ///< 应用ID
        NSString *Id;    ///< 记录ID recordId
        BOOL notEdit; ///< 编辑状态 yes：不在编辑状态， no：在编辑状态
        BOOL isRevise; ///< 设置 yes：表示不是新建数据 no：表示新建
        BOOL isNew;///是否为新建数据（用户感知的新建，非业务新建）默认为NO，非新建。
        BOOL formQRCode; ///< 是否来自二维码扫描
        BOOL nonRoot;    ///< 借助二维码扫描页面处理业务时，不需要直接返回rooVC,设置为YES
        NSDictionary *defaultValue;/// 如果默认值时，请传该值,该值类型同dataDic类型
        NSArray<NSString *> *disabledFiledsFormQRC; ///< 打开form不可编辑的字段
        NSDictionary *associatedData; ///< 父子应用关联数据
        BOOL isSubApp; ///< 是否是子应用
        void (^subAppCallBack)(); ///< 子应用保存回调
        qyc_entId ///企业id
        title///标题
 */

- (UIViewController *)mediator_openDataflowVC:(NSDictionary *)param;

/*
 *WF 入参
        NSString *app_id; ///流程应用id
        BOOL newCreateNode;///是否新建一个流程
        BOOL isNew; ///是否是用户感受到的新建 不参与具体业务数据,只有标记作用，大多时候与newCreateNode值一致，只有在DataFlow跨应用调用WorkFlow时，newCreateNode与该值不一样；(for 2019.11月需求迭代：取消按钮功能优化) newCreateNode为YES时无需为该值赋值
        NSString *instanceId; ///已有流程实例id
        NSArray<NSDictionary *> *currentNodes;///当前流程待办节点,必传参数，此参数用于计算待办节点下一步 字典结构:{node_key:value,node_title:value,chaoshi_status:value}
        NSArray<NSDictionary *> *mySteps;///我处理的节点 必传参数，此参数用于计算回退 或者 取回 操作 字典结构:{step_id:value,label:value}
        NSString *labelId;///所属标签
        NSString *sc_Id;///抄送id   请求时附带上
        BOOL isPerview;///是否设置为预览模式：预览模式不可编辑， 不可提交
        NSString *creatTime;
        NSString *creat_by;
        NSString *creat_by_id;
        BOOL formQRCode;//是否来自二维码扫描
        BOOL nonRoot;///< 借助二维码扫描页面处理业务时，不需要直接返回rooVC,设置为YES
        NSMutableDictionary *valueFormQRC; //扫码后得到 字段的特定值
        NSArray<NSString *> *disabledFiledsFormQRC;///打开form不可编辑的字段
        NSDictionary *associatedData;///父子应用关联数据源
        void (^subAppCallBack)();///子应用保存回调
        void (^subWorkFlowCallBack)();///子流程保存回调
        BOOL isSubApp;///是否是子应用
        NSString *real_handler;///代理人
        BOOL isFromViewList;///只有提交列表进入数据后才发送通知
 */

- (UIViewController *)mediator_openWorkflowVC:(NSDictionary *)param;

/**
 获取用户签名
 */
- (void)mediator_userSigntureRequest;

- (void)mediator_attachmentDownloadWithURL:(NSString *)url progress:(void (^_Nullable)(NSProgress *downProgress))downProgress callback:(void (^)(BOOL success, NSString *_Nullable filePath))callback;

/**
 上传文件
 @param tableId tableId
 @param fieldId fieldId
 @param recordId recordId
 @param uploadParams 需要上传的文件
 @param callback
 
 */
- (void)mediator_attachmentUploadFileWithTableId:(NSString *)tableId fieldId:(NSString *)fieldId recordId:(NSString *)recordId uploadParams:(NSArray *)uploadParams callback:(void (^)(BOOL success, NSArray *_Nullable fileNames))callback;

- (NSString *)mediator_attachmentDownlaodBaseURL;

- (UIView *)mediator_AttachmentInputViewCameraBlock:(dispatch_block_t)cameraBlock photoAblum:(dispatch_block_t)photoAblumBlock file:(void (^)(id file))fileBlock cancle:(dispatch_block_t)cancleBlock;

///df增加一条记录调用接口
- (void)mediator_DFAddRecordWithTableId:(NSString *)tableId entId:(NSString *)entId recordId:(NSString *)recordId params:(NSDictionary *)params isShowAlter:(BOOL)showAlert callback:(void (^)(BOOL succ, id data))callback;

- (UIViewController *)mediator_openTextEditViewController:(NSString *)title text:(NSString *)disPlayText edit:(BOOL)isEdit textBlock:(void (^)(NSString *text))textBlock;

- (UIViewController *)mediator_openHistoryVcWithAppId:(NSString *)appId tableId:(NSString *)tableId recordId:(NSString *)recordId entId:(NSString *)entId;

- (UIView *)mediator_radioPresentViewWithRadio:(BOOL)isRadio dataSourceArray:(NSArray *)dataSourceArray selectedArr:(NSMutableArray *)selectedArr selectedData:(void (^)(NSMutableArray *data))selectedData;

- (UIViewController *)mediator_imageEditVCWithImages:(NSMutableArray<UIImage *> *)images isCamera:(BOOL)isCamera callBack:(void (^)(NSArray<UIImage *> *imageList))callBack;
/*
 * 手写签名
 key:
 "appId";
 "tableId";
 "instanceId";
 "recordId";
 "fieldId";
 "signType";
 "upLoadType"
 */
- (UIViewController *)mediator_attachmentSignatureVCWithParams:(NSDictionary *)params upLoadType:(NSString *)upLoadType callBack:(nullable void (^)(id params))callback;

- (UIViewController *)mediator_showAttachVcWithEntID:(NSString *_Nullable)entId sourcePath:(NSString *)sourcePath title:(NSString *)title;
/**
 打开讨论页面
 */
- (UIViewController *)mediator_openAnswerDetaileViewControllerWithEntId:(NSString *)entId
                                                                 appKey:(NSString *)appKey;
/**
 打开数据共享页面
 */
- (UIViewController *)mediator_openFormShareFieldViewControllerWithEntId:(NSString *)entId
                                                                   appId:(NSString *)appId
                                                                 records:(NSArray *)records
                                                                callBack:(void (^)(BOOL success))callBack;

/**
 打开新版历史记录页面
 @param appType      应用类型，默认为workflow（当前服务端仅支持WF，内部已兼容DF,值为dataflow或information均可）
 @param tableId      表Id，使用DF时传
 @param nodeId       节点Id，使用WF时传
 @param real_handler 真实代理人，使用DF时传
 */
- (UIViewController *)mediator_openNewHistoryViewControllerWithEntId:(NSString *)entId
                                                               appId:(NSString *)appId
                                                             tableId:(nullable NSString *)tableId
                                                            recordId:(NSString *)recordId
                                                             appType:(NSString *)appType
                                                              nodeId:(nullable NSString *)nodeId
                                                        real_handler:(nullable NSString *)real_handler;
/**
 打开数据查看权限页面
 */
- (UIViewController *)mediator_openPermissionsViewControllerWithEntId:(NSString *)entId
                                                              tableId:(NSString *)tableId
                                                             recordId:(NSString *)recordId;
/**
 经纬度（地图定位）查看位置
 */
- (UIViewController *)mediator_openCoordinateViewControllerWithEntId:(NSString *)entId
                                                             locDict:(NSDictionary *)locDict;
/**
 调用本地数据源选择,放大镜
 */
- (UIViewController *)mediator_openDSSelectionViewControllerWithEntId:(NSString *)entId
                                                                title:(NSString *)title
                                                              canEdit:(BOOL)canEdit
                                                                isOrg:(BOOL)isOrg
                                                                raido:(BOOL)raido
                                                              rowType:(NSString *)rowType
                                                            selectArr:(NSArray *)selectArr
                                                                 link:(NSDictionary *)link
                                                         controlField:(NSDictionary *)controlField
                                                             callBack:(nullable void (^)(NSArray *data, NSArray *option))callBack;
- (NSString *)mediator_getRowSubTypeWithField:(NSDictionary *)fieldSchema;

- (UIViewController *)mediator_openRichTextVCWithEntId:(NSString *)entId tableId:(NSString *)tableId fieldId:(NSString *)fieldId title:(NSString *)title content:(NSString *)content canEdit:(BOOL)canEdit callBack:(void (^)(NSString *text))callBack;

/**
 param中的参数
 @property (nonatomic,copy)NSString *whiteName;

 @property (nonatomic,strong)NSMutableArray *blackArray;

 @property (nonatomic,copy)NSString *Id;

 @property (nonatomic,copy)NSString *type;

 @property (nonatomic,copy)NSString *parentId;
 @property (nonatomic,copy)NSString *avatar;
 */
- (UICollectionViewCell *)mediator_reusableOrgWhiteCellWithParam:(NSDictionary *)param collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

- (UICollectionViewCell *)mediator_reusableOrgWhiteBlackCellWithParam:(NSDictionary *)param collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

- (NSString *)mediator_stringFromOrgWhiteCell;
- (NSString *)mediator_stringFromOrgWhiteBlackCell;
/**
 form附件分享至启聊请求
 @param userIds       选择用户Id
 @param groupIds      选择群组Id
 @param fid
 @param from          页面来源
 @param message
 */
- (void)mediator_detailSendFileForChatRequestEntId:(NSString *)entId
                                           userIds:(NSArray *)userIds
                                          groupIds:(NSArray *)groupIds
                                               fid:(NSString *)fid
                                              from:(NSString *)from
                                           message:(NSString *)message
                                          callback:(void (^)(BOOL sucess,id data))callback;

@end

NS_ASSUME_NONNULL_END
