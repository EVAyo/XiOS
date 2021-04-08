//
//  QYCFormH5ViewController.m
//  Qiyeyun
//
//  Created by dong on 2019/10/12.
//  Copyright © 2019 安元. All rights reserved.
//

#import "QYCFormH5ViewController.h"
#import "CMVideoRecordManager.h"
#import "CMVideoRecordView.h"
#import "QYCBleManager.h"
#import "QYCBluetoothConnectVC.h"
#import "QYCH5Config.h"
#import "QYCRecorderView.h" ///< 录音View
//#import "UIViewController+QYCHandleURL.h"
#import "ZLCameraViewController.h"
#import <LocalAuthentication/LocalAuthentication.h> ///< 指纹识别
// QYC Pods
#import <QYCCategory/UIColor+QYCColor.h>
#import <QYCCategory/UIImage+Image.h>
#import <QYCNavigationController/NavigationViewController.h>
#import <QYCNavigationExtension/UIViewController+JZExtension.h>
#import <QYCNetwork/NET.h>
#import <QYCScan/QRViewController.h> ///< 二维码扫描
#import <QYCUI/MBProgressHUD+CZ.h>
#import <QYCUI/QYCToast.h>
// Vendor Pods
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <MJExtension/MJExtension.h>
#import <Masonry/Masonry.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <YYCategories/NSDictionary+YYAdd.h>
#import <YYCategories/NSString+YYAdd.h>
#import <YYCategories/UIColor+YYAdd.h>
#import <YYCategories/UIView+YYAdd.h>
#import <YYCategories/YYCategoriesMacro.h>
// CT
#import "CTMediator+FormDetailModule.h"
#import "CTMediator+OrgAndRoleGroup.h" ///< 应用角色组、组织架构
#import "CTMediator+QYCApplicationCenterModuleActions.h"
#import "CTMediator+QYCBlueToothModuleActions.h"
#import "CTMediator+QYCMap.h"
#import "CTMediator+QYCQRCodeModuleActions.h"
#import "CTMediator+QYCWorkCircleModuleActions.h"
#import "CTMediator+WebBridge.h"
#import "CTMediator+QChat.h"

@interface QYCFormH5ViewController () <BMKLocationManagerDelegate, BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) UIView *attachmentView;
@property (nonatomic, strong) NSString *schemaId;
@property (nonatomic, strong) NSString *tableId;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, strong) UIView *backView;
/** 选择图片回调*/
@property (nonatomic, copy) void (^selectImageBlock)(NSArray *urlArray);
/** 定位服务管理者*/
@property (nonatomic, strong) BMKLocationManager *locationService;
/** 搜索*/
@property (strong, nonatomic) BMKGeoCodeSearch *geoSearch;
/** 存储经纬度*/
@property (nonatomic, strong) NSMutableDictionary *addressValue;
/** 获取定位回调*/
//@property (nonatomic, copy) void (^fetchCurLocationBack)(NSDictionary *locationDict);
@property (nonatomic, copy) NSMutableArray <QYCWebBridgeResponseCallback> *curLocationCallbacks;
/** 成员变量 方便block在方法中传递*/
@property (nonatomic, copy) QYCWebBridgeResponseCallback responseCallback;
/** 当前页面是否隐藏导航条*/
@property (nonatomic, assign) BOOL hiddenTitleBar;
@property (nonatomic, strong) NSLock *arrayLock;
@end

@interface QYCDataSourceFields : NSObject

@property (nonatomic, strong) NSDictionary *schema;
@property (nonatomic, strong) id value;

@end

@implementation QYCFormH5ViewController

#pragma mark - ================ LifeCycle =================
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册js 调用 native
    [self p_registerJSCallNative];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.jz_navigationBarHidden = self.hiddenTitleBar;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.jz_navigationBarHidden = NO;
}

- (void)dealloc {
    [CT() mediator_releaseCacheTarget];
    // 停止定位
    [_locationService stopUpdatingLocation];
    _locationService.delegate = nil;
    _locationService          = nil;
    _geoSearch.delegate       = nil;
}

#pragma mark - ================ Public Methods =================
#pragma mark - ================ Private Methods =================

/**
 注册JSCallNative
 */
- (void)p_registerJSCallNative {
    @weakify(self);
    //图片下载
    [self registerHandler:@"downloadFile"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_downloadFileWithParams:data callBack:responseCallback];
                  }];
    //图片查看
    [self registerHandler:@"previewFile"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_previewFileWithParams:data callBack:responseCallback];
                  }];
    //拍照/图片选择
    [self registerHandler:@"chooseImage"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_chooseImageParams:data callBack:responseCallback];
                  }];
    //获取设备信息
    [self registerHandler:@"getDeviceInfo"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_getDeviceInfoPraram:data callBack:responseCallback];
                  }];
    //经纬度（地图定位）  查看位置
    [self registerHandler:@"openLocation"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_openLocationPraram:data callBack:responseCallback];
                  }];
    //经纬度（地图定位）  获取地理位置
    [self registerHandler:@"getLocation"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_getLocationPraram:data callBack:responseCallback];
                  }];

    //获取当前定位经纬度信息
    [self registerHandler:@"getCurLocation"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self openLocation];
                      [self p_getCurLocationPraram:data callBack:responseCallback];
                  }];
    //组织架构选择器
    [self registerHandler:@"showOrgSelector"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_showOrgParams:data callback:responseCallback];
                  }];
    //数据源选择,放大镜
    [self registerHandler:@"showDataSourceSelector"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_DataSourceParams:data callback:responseCallback];
                  }];
    //文本输入(带语音)
    [self registerHandler:@"showTextEditor"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_TextEditorParams:data callback:responseCallback];
                  }];
    //富文本输入
    [self registerHandler:@"showRichTextEditor"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_RichTextEditorParams:data callBack:responseCallback];
                  }];
    //数据权限
    [self registerHandler:@"showDataAccess"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_showDataAccessParams:data callback:responseCallback];
                  }];
    //扫码
    [self registerHandler:@"scanQRCode"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_scanQRCodeParams:data callback:responseCallback];
                  }];

    //扫码（无忧）
    [self registerHandler:@"scanQRCodeForH5"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_scanQRCodeForH5Params:data callback:responseCallback];
                  }];

    //搜一搜（无忧）
    [self registerHandler:@"theSearch"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_theSearchParams:data callback:responseCallback];
                  }];

    //跳转列表页面  add by linx for 2020.02需求:h5页面中支持点击进入原生应用
    [self registerHandler:@"jumpToAppList"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_jumpToAppListWithParams:data callBack:responseCallback];
                  }];

    //打开webView
    [self registerHandler:@"openWebview"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_openWebviewParams:data callback:responseCallback];
                  }];
    //打开历史记录
    [self registerHandler:@"showDataHistory"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_openHistoryParams:data callBack:responseCallback];
                  }];
    //下一步执行人
    [self registerHandler:@"showNextNodeUser"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_showNextNodeUserParam:data callback:responseCallback];
                  }];

    //数据共享 add by linx for 2020.01新增
    [self registerHandler:@"shareData"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_shareDataParams:data callBack:responseCallback];
                  }];
    //讨论 add by linx for 2020.01新增
    [self registerHandler:@"commentData"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_commentDataParams:data callBack:responseCallback];
                  }];
    //打印 add by linx for 2020.01新增
    [self registerHandler:@"printData"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_printDataParams:data callBack:responseCallback];
                  }];

    //控制底部tabbar显示
    [self registerHandler:@"controllerTabBar"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_controllerTabbar:data callBack:responseCallback];
                  }];

    //获取温振仪数据
    [self registerHandler:@"getDeviceMes"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_getDeviceMessage:data callBack:responseCallback];
                  }];

    //开始视频录制
    [self registerHandler:@"startVideoRecorder"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_startVideoRecorder:data callBack:responseCallback];
                  }];

    //开始录音
    [self registerHandler:@"startVoiceRecorder"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_startVoiceRecorder:data callBack:responseCallback];
                  }];

    //生物认证  指纹识别/人脸识别
    [self registerHandler:@"startSoterAuthentication"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      [self p_startSoterAuthentication:data callBack:responseCallback];
                  }];

    //导航栏
    [self registerHandler:@"isShowTitleBar"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
        @strongify(self);
        //显示或隐藏原生navbar
        BOOL showNativeNavBar = [data[@"isShowTitleBar"] boolValue];
        self.hiddenTitleBar   = !showNativeNavBar;
        if (!showNativeNavBar) {
            self.jz_navigationBarHidden = !showNativeNavBar;
            [self setStatusBarColor:UIColorHex(4680ff)];
        }
        //上个页面刷新
        BOOL isrefresh = [data[@"refresh"] boolValue];
        if (isrefresh) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"workflowRefreshList" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataflowListRefresh" object:nil];
        }
        //原生返回
        BOOL nativeBack = [data[@"isBack"] boolValue];
        if (nativeBack) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    // 是否包含启聊功能
    [self registerHandler:@"isContainsQichat"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
        @strongify(self);
        [self p_isContainsQichatWithParams:data callBack:responseCallback];
    }];
    // shareFile附件转发至启聊
    [self registerHandler:@"shareFile"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
        @strongify(self);;
        [self p_shareFileWithParams:data callBack:responseCallback];
    }];
}
/**  附件转发至启聊 */
- (void)p_shareFileWithParams:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
  
    NSString *fileName = params[@"fileName"] ?: @"";
    @weakify(self);
    UIViewController *contactViewController = [CT() mediator_nearestContacterVCIsGroupSearch:NO
                                                                                 multiSelect:NO
                                                                            maxOfMultiSelect:10
                                                                                       entId:params[@"entId"] ?: self.qyc_entId
                                                                          selectedGroupBlock:^(NSMutableArray *_Nonnull groupOrUser, UIViewController *_Nonnull vc) {
        @strongify(self);
        //转发人名称
        NSString *name = [CT() mediator_forwardManagerTitleWithTargets:groupOrUser];
        NSString *avatar;      ///<多个人传nil，不展示头像
        NSString *placeholder; ///<
        if (groupOrUser.count == 1) {
            NSDictionary *model = [groupOrUser.firstObject mj_keyValues];
            avatar              = model[@"avatar"] ?: @"";
            //特殊处理群里展位图
            if ([model[@"contactsType"] intValue] == 3) {
                placeholder = @"address_icon_department";
            }
        }
        [CT() mediator_messageForwardViewControllerWithContent:[NSString stringWithFormat:@"[文件]%@", fileName ?: @""]
                                                          name:name
                                                        avatar:avatar
                                                   placeholder:placeholder
                                                        fromVC:vc
                                                           row:2
                                              clickActionBlock:^(BOOL isSend, NSString *_Nonnull message) {
            if (isSend) {
                NSMutableArray *userIds  = [NSMutableArray array];
                NSMutableArray *groupIds = [NSMutableArray array];
                [groupOrUser enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
                    [[obj class] mj_referenceReplacedKeyWhenCreatingKeyValues:NO];
                    NSDictionary *m = [obj mj_keyValues];
                    if ([m[@"contactsType"] intValue] == 1) {
                        [userIds addObject:m[@"Id"] ?: @""];
                    }
                    else if ([m[@"contactsType"] intValue] == 3) {
                        [groupIds addObject:m[@"imId"] ?: @""];
                    }
                }];
                NSString *fid = [[fileName lastPathComponent] componentsSeparatedByString:@"_"].firstObject;
                //后10位以后为fid
                if (fid.length < 11) {
                    [QYCToast showToastWithMessage:@"转发失败" type:QYCToastTypeError];
                    [vc.navigationController dismissViewControllerAnimated:YES completion:nil];
                    return;
                }
                [MBProgressHUD showMessage:@"转发中..." toView:self.view];
                [CT() mediator_detailSendFileForChatRequestEntId:params[@"entId"] ?: self.qyc_entId userIds:userIds groupIds:groupIds fid:[fid substringFromIndex:10] from:@"detail" message:message callback:^(BOOL sucess, id  _Nonnull data) {
                                        
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if (sucess) {
                        [QYCToast showToastWithMessage:@"转发成功" type:QYCToastTypeSuccess];
                    }
                    else {
                        [QYCToast showToastWithMessage:@"转发失败" type:QYCToastTypeError];
                    }
                    [vc.navigationController dismissViewControllerAnimated:YES completion:nil];
                                    
                }];
            }
        }];
    }
                                                                                 cancelBlock:nil];
    NavigationViewController *navi          = [[NavigationViewController alloc] initWithRootViewController:contactViewController];
    navi.modalPresentationStyle             = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}

/** 是否包含启聊功能 */
- (void)p_isContainsQichatWithParams:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    BOOL isHasQiChat = NO;
    //启聊模块存在可转发
    NSNumber *qiChatMoudle = [[NSUserDefaults standardUserDefaults] objectForKey:@"hasQiChat"];
    if (qiChatMoudle && [qiChatMoudle isEqual:@1]) {
        isHasQiChat = YES;
    }
    callback(@{@"contains":@YES});
}

//控制底部tabbar显示
- (void)p_controllerTabbar:(id)data callBack:(QYCWebBridgeResponseCallback)callback {
    BOOL isShowTabbar = [data[@"isShow"] boolValue];
    if (isShowTabbar) {
        self.tabBarController.tabBar.hidden = NO;
        [self.wkWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }];
    }
    else {
        self.tabBarController.tabBar.hidden = YES;
        [self.wkWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.mas_equalTo(0);
        }];
    }
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

//获取温振仪数据
- (void)p_getDeviceMessage:(id)data callBack:(QYCWebBridgeResponseCallback)callback {
    NSString *device_type = data[@"device_type"];
    if ([QYCBleManager sharedManager].currentPeripheral != nil) {
        CBPeripheral *peripheral = [QYCBleManager sharedManager].currentPeripheral;
        [[QYCBleManager sharedManager] connectPeripheralInfo:peripheral];

        [MBProgressHUD showMessage:@"数据获取中..." toView:self.view];
        [QYCBleManager sharedManager].bluetoothConnectResult = ^(CGFloat sensitive, CGFloat acceleration, CGFloat speed, CGFloat displacement, CGFloat temperature) {
            [MBProgressHUD hideHUDForView:self.view];
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            if ([device_type isEqualToString:@"temperature"]) { //温度
                [params setValue:@(temperature) forKey:@"temperature"];
            }
            else if ([device_type isEqualToString:@"vibration"]) { //振动/位移
                [params setValue:@(displacement) forKey:@"vibration"];
            }
            else if ([device_type isEqualToString:@"acceleration"]) { //加速度
                [params setValue:@(acceleration) forKey:@"acceleration"];
            }
            else if ([device_type isEqualToString:@"speed"]) { //速度
                [params setValue:@(speed) forKey:@"speed"];
            }
            else {
                return;
            }
            callback(params);
        };
    }
    else {
        QYCBluetoothConnectVC *connectVC = [[QYCBluetoothConnectVC alloc] init];
        if ([device_type isEqualToString:@"temperature"]) { //温度
            connectVC.resultType = QYCConnectResultTypeTemperature;
        }
        else if ([device_type isEqualToString:@"vibration"]) { //振动
            connectVC.resultType = QYCConnectResultTypeVibration;
        }
        else if ([device_type isEqualToString:@"acceleration"]) { //加速度
            connectVC.resultType = QYCConnectResultTypeAcceleration;
        }
        else if ([device_type isEqualToString:@"speed"]) { //速度
            connectVC.resultType = QYCConnectResultTypeSpeed;
        }

        //获取结果回调
        connectVC.BluetoothConnectResult = ^(CGFloat resultValue, QYCConnectResultType restltType) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            if (restltType == QYCConnectResultTypeTemperature) {
                [params setValue:@(resultValue) forKey:@"temperature"];
            }
            else if (restltType == QYCConnectResultTypeVibration) {
                [params setValue:@(resultValue) forKey:@"vibration"];
            }
            else if (restltType == QYCConnectResultTypeAcceleration) {
                [params setValue:@(resultValue) forKey:@"temperature"];
            }
            else if (restltType == QYCConnectResultTypeSpeed) {
                [params setValue:@(resultValue) forKey:@"acceleration"];
            }
            else if (restltType == QYCConnectResultTypeSensitive) {
                [params setValue:@(resultValue) forKey:@"speed"];
            }
            else {
                return;
            }
            callback(params);
        };
        [self.navigationController pushViewController:connectVC animated:YES];
    }
}

//开始视屏录制
- (void)p_startVideoRecorder:(id)data callBack:(QYCWebBridgeResponseCallback)callback {
    NSDictionary *dict = (NSDictionary *)data;
    CGFloat duraion    = 10; ///<默认10s
    if (dict[@"duration"]) {
        duraion = [dict[@"duration"] floatValue] / 1000.0; ///<接收值是以毫秒为单位
    }
    CMVideoRecordView *controller = [[CMVideoRecordView alloc] init];
    controller.KMaxRecordTime     = duraion;
    controller.cancelBlock        = ^{
        NSLog(@"CMVideoRecordView 取消录制");
    };
    controller.videoCompletionBlock = ^(NSURL *fileUrl) {
        NSDictionary *result = @{
            @"fileUrl" : fileUrl.absoluteString, ///路径
            @"type" : @"recording",              ///类型
        };
        callback(result);
        NSLog(@"CMVideoRecordView 完成录制：%@", fileUrl);
    };
    controller.photoCompletionBlock = ^(UIImage *_Nonnull image, NSString *_Nonnull fileUrl) {
        NSDictionary *result = @{
            @"fileUrl" : fileUrl,    ///路径
            @"type" : @"take_photo", ///类型
        };
        callback(result);
        NSLog(@"CMVideoRecordView 拍照完成");
    };

    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:controller animated:true completion:NULL];
}

//开始录音
- (void)p_startVoiceRecorder:(id)data callBack:(QYCWebBridgeResponseCallback)callback {
    QYCRecorderView *recordView      = [[QYCRecorderView alloc] initWithRecorderViewWithFrame:CGRectMake(0, 0, WIDTH_H5, HEIGHT_H5)];
    recordView.startVoiceRecordBlock = ^(NSString *fileUrl) {
        NSDictionary *result = @{
            @"fileUrl" : fileUrl, ///路径
        };
        //        NSLog(@"录音且提交成功:%@", fileUrl)
        callback(result);
    };
    [self.view addSubview:recordView];
}

//生物认证
- (void)p_startSoterAuthentication:(id)data callBack:(QYCWebBridgeResponseCallback)callback {
    NSDictionary *dict  = (NSDictionary *)data;
    NSString *authModes = dict[@"requestAuthModes"];
    if ([authModes isEqualToString:@"fingerPrint"]) { //指纹识别
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"qyc_openTouchID"]) {
            [QYCToast showToastWithMessage:@"当前设备不支持或未开启指纹解锁" type:QYCToastTypeInfo];
            return;
        }

        LAContext *context             = [[LAContext alloc] init];
        context.localizedFallbackTitle = @"输入密码";

        NSError *error = nil;
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                    localizedReason:@"通过Home键验证已有手机指纹"
                              reply:^(BOOL success, NSError *_Nullable error) {
                                  NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
                                  [results setValue:authModes forKey:@"authMode"];
                                  if (success) { //验证成功
                                      [results setObject:@"success" forKey:@"result"];
                                      [results setObject:@"指纹识别成功" forKey:@"result_message"];
                                      callback(results);
                                  }
                                  else if (error) {
                                      [results setObject:@"fail" forKey:@"result"];
                                      switch (error.code) {
                                          case LAErrorAuthenticationFailed: {
                                              [results setObject:@"指纹识别验证失败" forKey:@"result_message"];
                                              callback(results);
                                          } break;
                                          case LAErrorUserCancel: {
                                              [results setObject:@"指纹识别被用户手动取消" forKey:@"result_message"];
                                              callback(results);
                                          } break;
                                          case LAErrorUserFallback: {
                                              [results setObject:@"用户不使用指纹识别,选择手动输入密码" forKey:@"result_message"];
                                              callback(results);
                                          } break;
                                          case LAErrorSystemCancel: {
                                              [results setObject:@"指纹识别被系统取消 (如遇到来电,锁屏,按了Home键等)" forKey:@"result_message"];
                                              callback(results);
                                          } break;
                                          case LAErrorPasscodeNotSet: {
                                              [results setObject:@"指纹识别无法启动,因为用户没有设置密码" forKey:@"result_message"];
                                              callback(results);
                                          } break;
                                          case LAErrorTouchIDNotEnrolled: {
                                              [results setObject:@"指纹识别无法启动,因为用户没有设置TouchID" forKey:@"result_message"];
                                              callback(results);

                                          } break;
                                          case LAErrorTouchIDNotAvailable: {
                                              [results setObject:@"指纹识别无效" forKey:@"result_message"];
                                              callback(results);
                                          } break;
                                          case LAErrorTouchIDLockout: {
                                              [results setObject:@"指纹识别被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)" forKey:@"result_message"];
                                              callback(results);
                                          } break;
                                          case LAErrorAppCancel: {
                                              [results setObject:@"当前软件被挂起并取消了授权 (如App进入了后台等)" forKey:@"result_message"];
                                              callback(results);
                                          } break;
                                          case LAErrorInvalidContext: {
                                              [results setObject:@"当前软件被挂起并取消了授权 (LAContext对象无效)" forKey:@"result_message"];
                                              callback(results);
                                          } break;
                                          default:
                                              break;
                                      }
                                  }
                              }];
        }
        else {
            [QYCToast showToastWithMessage:@"当前设备不支持或未开启指纹解锁" type:QYCToastTypeInfo];
        }
    }
    else { //人脸识别
    }
}

- (void)openLocation {
    // 判断的手机的定位功能是否开启
    // 开启定位:设置 > 隐私 > 位置 > 定位服务
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        self.locationService = [[BMKLocationManager alloc] init];
        //设置返回位置的坐标系类型（默认值影响定位精度，故需设置）
        self.locationService.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        self.locationService.delegate       = self;
        self.locationService.distanceFilter = 100;
        [self.locationService startUpdatingLocation];
    }
    else {
        [QYCToast showToastWithMessage:@"请开启定位功能,设置 > 隐私 > 位置 > 定位服务" type:QYCToastTypeDefault];
    }
    [CT() mediator_startBaiDuEngine];
}

#pragma mark 定位更新方法

//处理位置坐标更新
#pragma mark----------------  BMKLocationServiceDelegate ------------
/**
 *  @brief 连续定位回调函数。
 *  @param manager 定位 BMKLocationManager 类。
 *  @param location 定位结果，参考BMKLocation。
 *  @param error 错误信息。
 */
- (void)BMKLocationManager:(BMKLocationManager *_Nonnull)manager didUpdateLocation:(BMKLocation *_Nullable)location orError:(NSError *_Nullable)error {
    //- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    BMKReverseGeoCodeSearchOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeSearchOption alloc] init];
    CLLocationCoordinate2D geoPoint                           = location.location.coordinate;
    reverseGeoCodeSearchOption.location                       = geoPoint;

    [self.geoSearch reverseGeoCode:reverseGeoCodeSearchOption];
    self.addressValue[@"x"] = @(geoPoint.longitude); // 经度，浮点数，范围为180 ~ -180。
    self.addressValue[@"y"] = @(geoPoint.latitude);  // 纬度，浮点数，范围为90 ~ -90
    [self.locationService stopUpdatingLocation];
}

//接收反向地理编码结果
#pragma mark----------------  BMKGeoCodeSearchDelegate ------------

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        if (self.curLocationCallbacks.count) {
            BMKPoiInfo *poInfo = [result.poiList firstObject];
            [self.addressValue setValue:poInfo.name forKey:@"mark"];       // 显示名称
            [self.addressValue setValue:poInfo.address forKey:@"address"]; // 详细地址信息

            BMKAddressComponent *addressDetail = result.addressDetail;
            [self.addressValue setValue:addressDetail.province forKey:@"province"];         // 省份
            [self.addressValue setValue:addressDetail.city forKey:@"city"];                 // 城市
            [self.addressValue setValue:addressDetail.district forKey:@"district"];         // 区
            [self.addressValue setValue:addressDetail.streetName forKey:@"street"];         // 街道
            [self.addressValue setValue:addressDetail.streetNumber forKey:@"streetNumber"]; // 门牌号
            for (QYCWebBridgeResponseCallback callBack  in self.curLocationCallbacks.mutableCopy) {
                callBack(@{@"status":@"success",@"message":@"success",@"result":self.addressValue});
            }
            [self.arrayLock lock];
            [self.curLocationCallbacks removeAllObjects];
            [self.arrayLock unlock];
//            self.fetchCurLocationBack(@{@"status":@"success",@"message":@"success",@"result":self.addressValue});
        }
    }
}

/**
 图片下载

 @param params 入参
 @param callback 回传js的数据
 */
- (void)p_downloadFileWithParams:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    NSString *imageUrl = params[@"file"]; ///< 文件url路径
    // 下载
    [CT() mediator_attachmentDownloadWithURL:imageUrl
        progress:^(NSProgress *_Nonnull downProgress) {
            NSString *progressStr      = [NSString stringWithFormat:@"%.0f%@", downProgress.fractionCompleted * 100, @"%"];
            NSDictionary *responseDict = @{
                @"type" : @"progress", ///< 不同回调通过type区分： 下载success成功回调， progress上传进度回调， fail下载失败回调
                @"data" : progressStr  ///< 回调返回信息
            };
            callback(responseDict);
        }
        callback:^(BOOL success, NSString *_Nullable filePath) {
            NSDictionary *responseDict = @{@"type" : success ? @"success" : @"fail",
                                           @"data" : success ? filePath : @""};
            callback(responseDict);
            if (success) {
                UIViewController *showAttachVC = [CT() mediator_showAttachVcWithEntID:nil sourcePath:filePath title:@"附件查看"];
                [self.navigationController pushViewController:showAttachVC animated:YES];
            }
        }];
}

/**
 查看数据权限
 
 @param params 入参
 @param callback 回传js的数据
 */
- (void)p_showDataAccessParams:(id)params callback:(QYCWebBridgeResponseCallback)callback {
    UIViewController *permissionVC = [CT() mediator_openPermissionsViewControllerWithEntId:params[@"spaceId"]
                                                                                   tableId:params[@"tableId"]
                                                                                  recordId:params[@"recordId"]];
    [self.navigationController pushViewController:permissionVC animated:YES];
}

/**
 判断附件文件类型
 */
- (int)fileType:(NSString *)filePath {
    if (filePath.length == 0) {
        return 0;
    }
    if ([filePath hasSuffix:@".mp3"] || [filePath hasSuffix:@".mp4"]) {
        return 1;
    }

    else if ([filePath hasSuffix:@".jpg"] || [filePath hasSuffix:@".jpeg"] || [filePath hasSuffix:@".png"]) {
        return 2;
    }

    return 3; //未知文件类型
}
/**
 图片查看
 
 @param params 入参 allowDown:图片是否允许下载（不允许下载时只支持预览）、fileName：文件名称（区分视频、音频和其他文件）、fileUrl:文件路径
 
 @param callback 回传js的数据
 */
- (void)p_previewFileWithParams:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    NSString *fileName = params[@"fileName"]; ///< 当前显示文件的http链接
    NSString *fileUrl  = params[@"fileUrl"];  ///< 需要预览的文件http链接列表

    // 不支持格式过滤
    if ([fileName containsString:@".zip"] || [fileName containsString:@".rar"] || [fileName containsString:@".tar"]) {
        [QYCToast showToastWithMessage:@"暂不支持压缩包阅览" type:QYCToastTypeDefault];
        return;
    }

    int type = [self fileType:fileName];

    if (type == 0) {
        return;
    }
    else if (type == 2) {
        // 图片游览器
        UIWindow *window        = [UIApplication sharedApplication].delegate.window;
        UITabBarController *tab = (UITabBarController *)window.rootViewController;
        NSString *url           = [fileUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [CT() mediator_presentPhotoGroupViewFromView:nil toContainer:tab.view items:url.length > 0 ? @[ url ] : @[] frame:CGRectNull animated:YES fromItemIndex:0 hiddenPager:YES canForward:NO canShare:NO canDownload:YES customLongPressActionBlock:nil completion:nil];
    }
    else {
        // 先下载，后预览
        [MBProgressHUD showMessage:@""];
        [CT() mediator_attachmentDownloadWithURL:fileUrl
                                        progress:nil
                                        callback:^(BOOL success, NSString *_Nullable filePath) {
                                            [MBProgressHUD hideHUD];
                                            if (success) {
                                                UIViewController *showAttachVC = [CT() mediator_showAttachVcWithEntID:nil sourcePath:filePath title:@"附件查看"];
                                                [self.navigationController pushViewController:showAttachVC animated:YES];
                                            }
                                            else {
                                                [QYCToast showToastWithMessage:@"下载失败" type:QYCToastTypeError];
                                            }
                                        }];
    }
}

/**
手写签名

@param params 入参
@param callback 回传js的数据
*/
- (void)attachmentAddSigntureSignType:(NSString *)signType {
    NSDictionary *signParams = @{
        @"appId" : @"",
        @"tableId" : self.tableId ?: @"",
        @"fieldId" : self.schemaId ?: @"",
        @"recordId" : @"-1",
        @"signType" : signType ?: @"",
    };
    __weak __typeof(self) weakSelf = self;
    UIViewController *signatureVC  = [CT() mediator_attachmentSignatureVCWithParams:signParams
                                                                        upLoadType:@"App"
                                                                          callBack:^(id _Nonnull params) {
                                                                              NSArray *signatures         = params[@"signatures"];
                                                                              NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
                                                                              for (int i = 0; i < signatures.count; i++) {
                                                                                  NSMutableDictionary *params = [NSMutableDictionary dictionary];
                                                                                  NSString *name              = signatures[i];
                                                                                  NSString *urlStr            = [NSString stringWithFormat:@"%@%@/%@/%@/%@", [CT() mediator_attachmentDownlaodBaseURL], weakSelf.tableId, weakSelf.schemaId, @"chooseImage", name];
                                                                                  [params setValue:urlStr forKey:@"fileUrl"];
                                                                                  [params setValue:name forKey:@"fileName"];
                                                                                  [imagesArray addObject:params];
                                                                              }
                                                                              if (weakSelf.selectImageBlock) {
                                                                                  weakSelf.selectImageBlock(imagesArray);
                                                                              }
                                                                          }];
    [self.navigationController presentViewController:signatureVC animated:YES completion:nil];
}
/**
 拍照/图片选择
 
 @param params 入参
 @param callback 回传js的数据
 */
- (void)p_chooseImageParams:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    NSArray *sourceType = params[@"sourceType"];
    self.schemaId       = params[@"schemaId"];
    self.tableId        = params[@"tableId"];

    self.maxCount = [params[@"count"] integerValue] > 0 ? [params[@"count"] integerValue] : 9;

    BOOL signIn = [params[@"signIn"] boolValue]; ///<是否支持签到

    if (signIn) {
        //签到调用相机
        [self formCamera];
    }
    else {
        BOOL autograph = [params[@"autograph"] boolValue]; ///<是否支持手写签名

        if (autograph) {
            NSString *signType = params[@"signType"];

            //执行手写签名
            [self attachmentAddSigntureSignType:signType];
        }
        else {
            if (sourceType.count > 1) { // 默认  拍照/图片
                [self initAttachmentView];
                UIWindow *window = [[UIApplication sharedApplication] windows].firstObject;
                [window addSubview:self.backView];
                [window addSubview:self.attachmentView];
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.attachmentView.top = HEIGHT_H5 - 140 - stateIncrement_H5();
                                 }];
            }
            else if ([sourceType containsObject:@"camera"]) { //拍照
                [self formCamera];
            }
            else if ([sourceType containsObject:@"album"]) { //相册
                [self formPhotoAblum];
            }
        }
    }
    self.selectImageBlock = ^(NSArray *urlArray) {
        callback(@{@"localIds" : urlArray});
    };
}

/**
 扫码
 
 @param params 入参
 @param callback 回传js的数据
 */
- (void)p_scanQRCodeParams:(id)params callback:(QYCWebBridgeResponseCallback)callback {
    if (![AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo]) {
        [QYCToast showToastWithMessage:@"设备不支持" type:QYCToastTypeError];
        return;
    }
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        [QYCToast showToastWithMessage:@"你没有相机的访问权限!\n前往 设置->隐私->相机 打开权限" type:QYCToastTypeWarning];
        return;
    }
    QRViewController *qrVC = [[QRViewController alloc] init];
    qrVC.qrUrlBlock        = ^(NSString *stringValue, QRViewController *vc) {
        // 1.返回结果给H5
        if ([params[@"needResult"] isKindOfClass:[NSString class]] && [params[@"needResult"] isEqualToString:@"1"]) {
            // 1.1.短链接
            if ([stringValue hasPrefix:@"$QY:"] || [stringValue hasPrefix:@"$AY:"]) {
                // 短链接优化，可能是一个请求参数，也可能是长地址
                NSString *url = @"";
                if ([stringValue hasPrefix:@"$QY:"]) {
                    // 旧版短链接解析
                    url = [self URLPath:API_H5_QYC_QRShortToLongURL];
                }
                else {
                    // 新版短链接解析
                    url = [self URLPath:API_H5_QYC_QRShortToLongURL_New];
                }

                [MBProgressHUD showMessage:@""];
                // HTTP
                [NET GET:url
                    parameters:@{@"short" : stringValue}
                    success:^(id responseObject) {
                        [MBProgressHUD hideHUD];
                        NSDictionary *originalDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                        if ([originalDic[@"status"] isEqual:@200] && [originalDic[@"code"] isEqual:@200]) {
                            NSString *jsonStr = originalDic[@"result"];
                            callback(@{@"resultStr" : jsonStr ?: @""});
                        }
                        else {
                            [QYCToast showToastWithMessage:@"请求错误" type:QYCToastTypeError];
                        }
                    }
                    failure:^(NSError *error) {
                        [MBProgressHUD hideHUD];
                        [QYCToast showToastWithMessage:@"请求失败" type:QYCToastTypeError];
                    }];
            }
            // 1.2.长数据
            else {
                callback(@{@"resultStr" : stringValue ?: @""});
            }
        }
        // 2.原生处理
        else {
            [CT() mediator_handleURL:stringValue ?: @"" vc:self];
        }
    };
    [self.navigationController pushViewController:qrVC animated:YES];
}

/**
 扫码（无忧）
 
 @param params 入参
 @param callback 回传js的数据
 */
- (void)p_scanQRCodeForH5Params:(id)params callback:(QYCWebBridgeResponseCallback)callback {
    if (![AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo]) {
        [QYCToast showToastWithMessage:@"设备不支持" type:QYCToastTypeError];
        return;
    }
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        [QYCToast showToastWithMessage:@"你没有相机的访问权限!\n前往 设置->隐私->相机 打开权限" type:QYCToastTypeWarning];
        return;
    }
    QRViewController *qrVC = [[QRViewController alloc] init];
    qrVC.qrUrlBlock        = ^(NSString *stringValue, QRViewController *vc) {
        // URL解码
        NSString *valueStr = stringValue ? [stringValue stringByURLDecode] : @"";

        // 1.短链接
        if ([valueStr hasPrefix:@"$QY:"] || [valueStr hasPrefix:@"$AY:"]) {
            // 短链接优化，可能是一个请求参数，也可能是长地址
            NSString *url = @"";
            if ([valueStr hasPrefix:@"$QY:"]) {
                // 旧版短链接解析
                url = [self URLPath:API_H5_QYC_QRShortToLongURL];
            }
            else {
                // 新版短链接解析
                url = [self URLPath:API_H5_QYC_QRShortToLongURL_New];
            }

            [MBProgressHUD showMessage:@""];
            // HTTP
            [NET GET:url
                parameters:@{@"short" : valueStr}
                success:^(id responseObject) {
                    [MBProgressHUD hideHUD];
                    NSDictionary *originalDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    if ([originalDic[@"status"] isEqual:@200] && [originalDic[@"code"] isEqual:@200]) {
                        NSString *jsonStr = originalDic[@"result"];
                        // URL解码
                        callback(@{@"resultStr" : [jsonStr stringByURLDecode] ?: @""});
                    }
                    else {
                        [QYCToast showToastWithMessage:@"请求错误" type:QYCToastTypeError];
                    }
                }
                failure:^(NSError *error) {
                    [MBProgressHUD hideHUD];
                    [QYCToast showToastWithMessage:@"请求失败" type:QYCToastTypeError];
                }];
        }
        // 2. 长数据
        else {
            callback(@{@"resultStr" : valueStr});
        }
    };
    [self.navigationController pushViewController:qrVC animated:YES];
}
/**
 搜一搜蓝牙设备（无忧）
 
 @param params 入参
 @param callback 回传js的数据
 */
- (void)p_theSearchParams:(id)params callback:(QYCWebBridgeResponseCallback)callback {
    if (![CT() mediator_bluetoothIsOpen]) {
        [QYCToast showToastWithMessage:@"请先打开蓝牙！" type:QYCToastTypeWarning];
        return;
    }

    UIViewController *bluetoothVC      = [CT() mediator_bluetoothVCFromH5:YES
                                                            callBack:^(id _Nonnull result) {
                                                                callback(result);
                                                                [self dismissViewControllerAnimated:YES completion:nil];
                                                            }];
    NavigationViewController *blutooth = [[NavigationViewController alloc] initWithRootViewController:bluetoothVC];
    blutooth.modalPresentationStyle    = UIModalPresentationFullScreen;
    [self presentViewController:blutooth animated:YES completion:nil];
}
/**
 打开webView

 @param params 入参
 @param callback 回传js的数据
 */
- (void)p_openWebviewParams:(id)params callback:(QYCWebBridgeResponseCallback)callback {
    if (!params[@"url"]) {
        return;
    }
    UIViewController *h5VC = [CT() mediator_openWebType:4 url:params[@"url"] entId:self.qyc_entId canRefresh:NO closeBounces:YES cookies:nil];
    [self.navigationController pushViewController:h5VC animated:YES];
}

- (void)p_getDeviceInfoPraram:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
}

/**
 经纬度（地图定位）  查看位置
 
 @param params 入参
 @param callback 回传js的数据
 */
- (void)p_openLocationPraram:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    UIViewController *locVC = [CT() mediator_openCoordinateViewControllerWithEntId:params[@"spaceId"] locDict:params];
    [self.navigationController pushViewController:locVC animated:YES];
}

/**
 经纬度（地图定位） 获取地理位置

 @param params 入参
 @param callback 回传js的数据
 */
- (void)p_getLocationPraram:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    UIViewController *mapLocation = [CT() mediator_openMapLocationViewControllerType:1
                                                                            latitude:params[@"y"]
                                                                           longitude:params[@"x"]
                                                                            callBack:^(NSDictionary *_Nonnull result) {
                                                                                double lat                          = [result[@"latitude"] doubleValue];
                                                                                double lon                          = [result[@"longitude"] doubleValue];
                                                                                NSString *name                      = result[@"name"];
                                                                                NSMutableDictionary *callBackParams = [[NSMutableDictionary alloc] init];
                                                                                [callBackParams setValue:@(lat) forKey:@"y"];                             // 纬度，浮点数，范围为90 ~ -90
                                                                                [callBackParams setValue:@(lon) forKey:@"x"];                             // 经度，浮点数，范围为180 ~ -180。
                                                                                [callBackParams setObject:name?:@"" forKey:@"mark"];
                                                                                // 显示名称
                                                                                [callBackParams setObject:result[@"address"]?:@"" forKey:@"address"];           // 详细地址信息
                                                                                [callBackParams setObject:result[@"province"]?:@"" forKey:@"province"];         // 省份
                                                                                [callBackParams setObject:result[@"city"]?:@"" forKey:@"city"];                 // 城市
                                                                                [callBackParams setObject:result[@"district"]?:@"" forKey:@"district"];         // 区
                                                                                [callBackParams setObject:result[@"streetName"]?:@"" forKey:@"street"];             // 街道
                                                                                [callBackParams setObject:result[@"streetNumber"]?:@"" forKey:@"streetNumber"]; // 门牌号

                                                                                callback(callBackParams);
                                                                            }];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:mapLocation];
    nav.modalPresentationStyle    = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

/**
 经纬度（地图定位） 获取地理位置

 @param params 入参
 @param callback 回传js的数据
 */
- (void)p_getCurLocationPraram:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    [self.arrayLock lock];
    [self.curLocationCallbacks addObject:callback];
    [self.arrayLock unlock];
}

/**
调用本地组织架构选择器（下一步执行人）

@param params 入参
@param callback 回传js数据
*/
- (void)p_showNextNodeUserParam:(id)param callback:(QYCWebBridgeResponseCallback)callback {
    NSString *assembly = param[@"assembly"];

    if (assembly.length == 0 && param[@"config"]) {
        assembly = param[@"config"][@"assembly"];
    }
    if ([assembly isEqualToString:@"1"]) {
        [self showNextNodeUser:param callback:callback]; ///<下一步执行人选择为组织架构
    }
    else {
        //下一步执行人选择应用角色组选择
        self.responseCallback = callback;
        NSMutableArray *temp  = [[NSMutableArray alloc] init];
        NSArray *ids          = param[@"assignto"][@"appGroupShow"];
        [ids enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            [temp addObject:obj[@"group_id"] ?: @""];
        }];

        NSArray *seleted = param[@"assignto"][@"selected"];

        NSMutableArray *seletedArr = [[NSMutableArray alloc] init];
        [seleted enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            NSDictionary *dic = obj;
            if ([dic.allKeys containsObject:@"group_id"]) {
                [seletedArr addObject:dic];
            }
            else if ([dic.allKeys containsObject:@"userId"]) {
                [seletedArr addObject:dic];
            }
        }];

        UIViewController *rolesCtr = [CT() mediator_entetRoleGroupVCWithGroupIds:temp
                                                                      selecteArr:seletedArr
                                                                        callback:^(NSArray *_Nullable selectedFinish) {
                                                                            if (self.responseCallback) {
                                                                                self.responseCallback(selectedFinish);
                                                                            }
                                                                        }];
        [self.navigationController pushViewController:rolesCtr animated:YES];
    }
}

///<下一步执行人选择为组织架构
- (void)showNextNodeUser:(id)params callback:(QYCWebBridgeResponseCallback)callback {
    NSArray *fixed = params[@"assignto"][@"fixed"]; ///<　可选范围

    NSDictionary *fix;

    if ([(NSArray *)fixed count] > 0) {
        fix = [CT() mediator_standardDataFormNextStepWithArray:fixed isRange:YES];
    }
    NSArray *selected = params[@"assignto"][@"selected"]; ///<　已选执行人
    NSDictionary *select;
    if ([(NSArray *)selected count] > 0) {
        select = [CT() mediator_standardDataFormNextStepWithArray:selected isRange:NO];
    }

    BOOL isRadio = YES;
    if (![params[@"type"] isEqualToString:@"subworkflow"]) {
        isRadio = NO;
    }
    else {
        isRadio = YES;
    }
    NSString *entId = params[@"entId"] ?: self.qyc_entId;

    __block BOOL isFirst    = YES; ///<防止第一次进入选择页面时就进行回调，选择确认后回调失败的问题，否则web端数据不会刷新,(多次回调，只第一次生效）
    UIViewController *orgVC = [CT() mediator_enterOrgVCGetHandNextStopDataWithAppType:KOrgNextStep
                                                                              isRadio:isRadio
                                                                           selectType:7
                                                                       andSelectedOrg:select
                                                                          selectRange:fix
                                                                                entId:entId
                                                                             callBack:^(NSArray *_Nullable data) {
                                                                                 if (isFirst == NO) {
                                                                                     if (callback && data.count) {
                                                                                         callback(data);
                                                                                     }
                                                                                     else {
                                                                                         //为空时传空字典
                                                                                         callback(@{});
                                                                                     }
                                                                                 }
                                                                                 else {
                                                                                     isFirst = NO;
                                                                                 }
                                                                             }];
    [self.navigationController pushViewController:orgVC animated:YES];
}
/**
 调用本地组织架构选择器

 @param params 入参
 @param callback 回传js数据
 */
- (void)p_showOrgParams:(id)params callback:(QYCWebBridgeResponseCallback)callback {
    KOrgSelectType selectType = KOrgSelectTypeNone;
    NSString *display         = params[@"display"];
    BOOL isRadio = YES;
    if ([params[@"type"] isEqualToString:@"multiple"]) {
        isRadio = NO;
    }
    else {
        isRadio = YES;
    }
    if ([display isEqualToString:@"member"]) {
        if (isRadio) {
            selectType = KOrgSelectTypeMember;
        }
        else {
            selectType = KOrgSelectTypeMember | KOrgSelectTypeRole | KOrgSelectTypeDepartment;
        }
    }
    else if ([display isEqualToString:@"role"]) {
        selectType = KOrgSelectTypeRole | KOrgSelectTypeDepartment;;
    }
    else if ([display isEqualToString:@"name"]) {
        if (isRadio) {
            selectType = KOrgSelectTypeMember;
        }
        else {
            selectType = KOrgSelectTypeMember | KOrgSelectTypeRole | KOrgSelectTypeDepartment;
        }
    }
    NSString *entId          = params[@"spaceId"] ?: self.qyc_entId;
    NSDictionary *standRange = [CT() mediator_standardDataFormOrgFieldWithWhiteList:params[@"whiteList"] isRange:YES];
    NSDictionary *selected   = params[@"selected"];

    __block BOOL isFirst = YES; ///<防止第一次进入选择页面时就进行回调，选择确认后回调失败的问题，否则web端数据不会刷新（多次回调，只第一次生效）

    UIViewController *org = [CT() mediator_enterOrgVCHandNodeDataWithAppType:KOrgDefault
                                                                     isRadio:isRadio
                                                                  selectType:selectType
                                                              andSelectedOrg:selected
                                                                 selectRange:standRange
                                                                       entId:entId
                                                                    callBack:^(NSString *_Nullable data) {
                                                                        if (isFirst == NO) {
                                                                            NSDictionary *orgDic = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                                                                            if (callback && orgDic.count) {
                                                                                callback(orgDic);
                                                                            }
                                                                            else {
                                                                                //为空时传空字典
                                                                                callback(@{});
                                                                            }
                                                                        }
                                                                        else {
                                                                            isFirst = NO;
                                                                        }
                                                                    }];
    [self.navigationController pushViewController:org animated:YES];
}

/**
 调用本地数据源选择,放大镜
 
 @param params 入参
 @param callback 回传js数据
 */
- (void)p_DataSourceParams:(id)params callback:(QYCWebBridgeResponseCallback)callback {
    NSDictionary *fieldSchema = [params[@"fieldSchema"] jsonValueDecoded];

    NSString *recordId   = params[@"recordId"];
    NSString *appId      = params[@"appId"];
    NSString *appType    = params[@"appType"];
    NSString *fieldValue = params[@"fieldValue"];
    //    NSString      *selected  = params[@"selected"];
    NSString *qyc_entId = params[@"spaceId"] ? [NSString stringWithFormat:@"space-%@", params[@"spaceId"]] : self.qyc_entId;
    ;
    //    NSInteger showMagnifier  = [params[@"showMagnifier"] integerValue];
    NSArray *controlFields = [QYCDataSourceFields mj_objectArrayWithKeyValuesArray:params[@"controlFields"]];

    id v_allField = [params[@"allField"]jsonValueDecoded];

    NSArray *allField;

    if ([v_allField isKindOfClass:[NSArray class]]) {
        allField = [v_allField copy];
    }
    else {
        @try {
            NSData *nsData = [v_allField dataUsingEncoding:NSUTF8StringEncoding];
            allField       = [NSJSONSerialization JSONObjectWithData:nsData options:kNilOptions error:nil];
        } @catch (NSException *exception) {
        } @finally {
        }
    }
    NSMutableArray *selectArr;
    if ([fieldValue isKindOfClass:[NSString class]] && [fieldValue isNotBlank]) {
        selectArr = [fieldValue componentsSeparatedByString:@","].mutableCopy;
    }
    else if([fieldValue isKindOfClass:[NSArray class]]) {
        selectArr = [fieldValue mutableCopy];
    }
    //linkParam 参数组装
    NSMutableDictionary *linkParam = [[NSMutableDictionary alloc] initWithDictionary:[self paramsFromAllField:allField]];
    linkParam[@"recordId"]         = recordId;
    linkParam[@"appId"]            = appId;
    linkParam[@"isMobile"]         = @YES;
    linkParam[@"type"]             = appType;
    // add by linx at 2021.03.16 处理H5打开原生数据源参数丢失
    [controlFields enumerateObjectsUsingBlock:^(QYCDataSourceFields * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *keyName = [NSString stringWithFormat:@"map[%@]", obj.schema[@"id"]];
        // 根据#号拆分
        if (obj.value && [obj.value isKindOfClass:NSString.class] && [obj.value containsString:@"#"]) {
            NSString *valueStr = obj.value;
            NSArray *tempArr = [valueStr componentsSeparatedByString:@"#"];
            if (tempArr && tempArr.count) {
                [linkParam setValue:tempArr.firstObject forKey:keyName];
            }
        }
    }];
    
    NSString *url                  = [NSString stringWithFormat:@"%@/%@%@/%@?paging[perPage]=50&paging[start]=0", qyc_entId, API_H5_GetDataSource, fieldSchema[@"belongs"], fieldSchema[@"id"]];
    NSDictionary *metadata         = fieldSchema[@"metadata"];
    if (![metadata isKindOfClass:[NSDictionary class]]) {
        metadata = @{};
    }

    UIViewController *selectionVC = [CT() mediator_openDSSelectionViewControllerWithEntId:qyc_entId
                                                                                    title:fieldSchema[@"title"]
                                                                                  canEdit:[metadata[@"canEdit"] isEqual:@"1"]
                                                                                    isOrg:[fieldSchema[@"type"] isEqualToString:@"org"]
                                                                                    raido:[metadata[@"callType"] isEqualToString:@"radio"]
                                                                                  rowType:[CT() mediator_getRowSubTypeWithField:fieldSchema]
                                                                                selectArr:selectArr
                                                                                     link:@{@"base" : url, @"param" : linkParam}
                                                                             controlField:[self zoomParamFormField:fieldSchema]
                                                                                 callBack:^(NSArray *_Nonnull data, NSArray *_Nonnull option) {
                                                                                     if (data.count > 0) {
                                                                                         !callback ?: callback([self dataSourceAssemblyData:data type:metadata[@"callType"]]);
                                                                                     }
                                                                                     if (option.count > 1) {
                                                                                         !callback ?: callback([self mangnifierAssemblyData:option type:metadata[@"callType"] fields:fieldSchema[@"relationSearchFields"]]);
                                                                                     }
                                                                                 }];
    [self.navigationController pushViewController:selectionVC animated:YES];
}

/**
 组装放大镜回调参数

 @param data 本地选择的数据源值
 @param type 单前字段是何类型（’multiple‘，‘radio’）
 @param fields 参与放大镜的控制字段的字段Id
 @return 组装好的数据 {name:'字段展示值',value:'字段实际值',mangnifier:[field:'字段Id',value:'字段实际值']}
 */
- (NSDictionary *)mangnifierAssemblyData:(NSArray *)data type:(NSString *)type fields:(NSArray<NSDictionary *> *)fields {
    NSMutableArray *magnifier = [NSMutableArray array];
    for (int i = 0; i < data.count; i++) {
        [magnifier addObject:@{@"field" : fields[i][@"fieldId"], @"value" : data[i]}];
    }

    NSMutableArray *temp = [NSMutableArray new];
    NSString *value      = [data.firstObject componentsSeparatedByString:@"#@"].firstObject;
    NSDictionary *dic    = [value jsonValueDecoded];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic containsObjectForKey:@"displayValue"]) {
            [temp addObject:dic[@"displayValue"]];
        }
        else if ([dic containsObjectForKey:@"mark"]) {
            [temp addObject:dic[@"mark"]];
        }
        else {
            [temp addObject:value];
        }
    }
    else {
        [temp addObject:value];
    }

    if ([type isEqual:@"multiple"]) {
        return @{@"name" : [temp componentsJoinedByString:@","], @"value" : data, @"magnifier" : magnifier};
    }
    else {
        return @{@"name" : temp.firstObject ?: @"", @"value" : data.firstObject ?: @"", @"magnifier" : magnifier};
    }
}

/**
 组装数据源回调参数

 @param data 本地选择的数据源值
 @param type 单前字段是何类型（’multiple‘，‘radio’）
 @return 组装好的数据{name:'字段展示值',value:'字段实际值'}
 */
- (NSDictionary *)dataSourceAssemblyData:(NSArray *)data type:(NSString *)type {
    NSMutableArray *temp = [NSMutableArray new];
    for (NSString *str in data) {
        NSString *value   = [str componentsSeparatedByString:@"#@"].firstObject;
        NSDictionary *dic = [value jsonValueDecoded];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            if ([dic containsObjectForKey:@"displayValue"]) {
                [temp addObject:dic[@"displayValue"]];
            }
            else if ([dic containsObjectForKey:@"mark"]) {
                [temp addObject:dic[@"mark"]];
            }
            else {
                [temp addObject:value];
            }
        }
        else {
            [temp addObject:value];
        }
    }
    if ([type isEqual:@"multiple"]) {
        return @{@"name" : [temp componentsJoinedByString:@","], @"value" : data};
    }
    else {
        return @{@"name" : temp.firstObject ?: @"", @"value" : data.firstObject ?: @""};
    }
}

/**
 获取allField中的value
 @param allField 当前页面的所有字段， 包括字段值、字段schema, 格式：[{schema:?,value:?}]
 @return {schemaId:value}
 */
- (NSDictionary *)paramsFromAllField:(NSArray *)allField {
    if (allField.count == 0) {
        return @{};
    }
    NSMutableDictionary *paramDic          = [[NSMutableDictionary alloc] init];
    NSArray<QYCDataSourceFields *> *fields = [QYCDataSourceFields mj_objectArrayWithKeyValuesArray:allField];
    [fields enumerateObjectsUsingBlock:^(QYCDataSourceFields *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (obj.schema[@"id"]) {
            NSString *keyName = [NSString stringWithFormat:@"conditionValue[%@]", obj.schema[@"id"]];
            paramDic[keyName] = obj.value;
        }
    }];
    return [paramDic copy];
}

//数据源放大镜配置
- (NSDictionary *)zoomParamFormField:(NSDictionary *)field {
    if (![field isKindOfClass:[NSDictionary class]])
        return @{};
    NSArray *relationMapFields = field[@"relationMapFields"];
    if (relationMapFields && relationMapFields.count) {
        // 存在放大镜功能,配置参数
        NSMutableDictionary *zoom  = @{@"tableId" : field[@"belongs"], @"fieldId" : field[@"id"]}.mutableCopy;
        NSMutableArray *zoomFields = [NSMutableArray new];
        for (NSDictionary *dic in field[@"relationSearchFields"]) {
            [zoomFields addObject:dic[@"fieldId"]];
        }
        zoom[@"fields"] = zoomFields;
        zoom[@"titles"] = field[@"relationSearchFields"];
        return [zoom copy];
    }
    return @{};
}

/**
 调用本地文本输入(带语音)
 
 @param params 入参
 @param callback 回传js数据
 */
- (void)p_TextEditorParams:(id)params callback:(QYCWebBridgeResponseCallback)callback {
    UIViewController *editVC = [CT() mediator_openTextEditViewController:params[@"name"] ?: @""
                                                                    text:params[@"content"] ?: @""
                                                                    edit:[params[@"editable"] boolValue]
                                                               textBlock:^(NSString *_Nonnull text) {
                                                                   !callback ?: callback(@{@"text" : text ?: @""});
                                                               }];
    [self.navigationController pushViewController:editVC animated:YES];
}

/**
 调用本地富文本输入
 
 @param params 入参
 @param callback 回传js数据
 */
- (void)p_RichTextEditorParams:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    UIViewController *richEdit = [CT() mediator_openRichTextVCWithEntId:params[@"entId"]?:self.qyc_entId
                                                                tableId:params[@"tableId"]
                                                                fieldId:params[@"fieldId"]
                                                                  title:params[@"name"] ?: @""
                                                                content:params[@"content"] ?: @""
                                                                canEdit:[params[@"editable"] boolValue]
                                                               callBack:^(NSString *_Nonnull text) {
                                                                   !callback ?: callback(@{@"text" : text ?: @""});
                                                               }];
    [self.navigationController pushViewController:richEdit animated:YES];
}

/**
 历史记录

 @param params 入参
 @param callback 回传js数据
 */
- (void)p_openHistoryParams:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    NSString *appType = params[@"appType"];
    if ([appType isEqual:@"workflow"]) {
        UIViewController *historyVC = [CT() mediator_openNewHistoryViewControllerWithEntId:params[@"spaceId"] ?: self.qyc_entId appId:params[@"appId"] tableId:nil recordId:params[@"recordId"] appType:@"workflow" nodeId:params[@"nodeId"] real_handler:params[@"real_handler"]];
        [self.navigationController pushViewController:historyVC animated:YES];
    }
    else if ([appType isEqual:@"information"]) {
        //
        UIViewController *historyVC = [CT() mediator_openHistoryVcWithAppId:params[@"appId"] tableId:params[@"tableId"] recordId:params[@"recordId"] entId:params[@"spaceId"]];
        [self.navigationController pushViewController:historyVC animated:YES];
    }
}

/**
 数据共享

 @param params 入参
 @param callback 回传js数据
 */
- (void)p_shareDataParams:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    // 页面跳转
    UIViewController *vc = [CT() mediator_openFormShareFieldViewControllerWithEntId:params[@"spaceId"] appId:params[@"appId"] records:params[@"recordId"] callBack:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 讨论 / 评论

 @param params 入参
 @param callback 回传js数据
 */
- (void)p_commentDataParams:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    /** params：
 {
     appId = FuJianZhuanFaQiLiaoD;
     appType = information;
     instanceId = 3;
     spaceId = APICeShiQiYe;
     tableId = fujianzhuanfaqiliaod;
 }
 */
    NSString *spaceEntId = params[@"spaceId"]; // 企业id
    NSString *appId      = params[@"appId"];
    NSString *appType    = params[@"appType"];
    NSString *instanceId = params[@"instanceId"]; // 实例ID/记录ID
    NSString *tableId    = params[@"tableId"];    // 应用是DF时必传
    // entId
    if (![spaceEntId containsString:@"space-"]) {
        spaceEntId = [NSString stringWithFormat:@"space-%@", spaceEntId];
    }

    NSString *appKey = [NSString stringWithFormat:@"workflow_%@_instance_%@", appId, instanceId];
    if ([appType isEqualToString:@"information"]) { // DF
        appKey = [NSString stringWithFormat:@"information_%@_%@_%@", appId, tableId, instanceId];
    }
    [NET Delete:[NSString stringWithFormat:@"%@/%@/%@", spaceEntId, API_H5_InfoCentre_discussPosts, appKey]
        parameter:nil
          success:^(id responseObject) {
          }
          failure:^(NSError *error){
          }];
    UIViewController *answerDetailVC = [CT() mediator_openAnswerDetaileViewControllerWithEntId:spaceEntId.length > 0 ? spaceEntId : self.qyc_entId appKey:appKey];
    [self.navigationController pushViewController:answerDetailVC animated:YES];
}

/**
 打印

 @param params 入参
 @param callback 回传js数据
 */
- (void)p_printDataParams:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    // iOS 不支持打印，过滤掉打印操作
    [QYCToast showToastWithMessage:@"iOS 暂不支持打印" type:QYCToastTypeWarning];
}

- (void)p_jumpToAppListWithParams:(id)params callBack:(QYCWebBridgeResponseCallback)callback {
    /**
 params =
     {
        link = "https://www.51safety.com.cn/safetymapp/integral/home";
        title = "\U6211\U7684\U79ef\U5206";
     }
 */
    [CT() mediator_openApplicationFromVC:self entId:self.qyc_entId app_type:@"link" link:params[@"link"] appName:params[@"title"] ?: @""];
}

#pragma mark - ================ Delegate =================
- (void)initAttachmentView {
    @weakify(self);
    self.attachmentView       = [CT()
        mediator_AttachmentInputViewCameraBlock:^{
            @strongify(self);
            [self formCamera];
        }
        photoAblum:^{
            @strongify(self);
            [self formPhotoAblum];
        }
        file:^(id _Nonnull file) {
        }
        cancle:^{
            @strongify(self);
            [self cancleClick];
        }];
    self.attachmentView.frame = CGRectMake(0, HEIGHT_H5, WIDTH_H5, 140 + stateIncrement_H5());
}

#pragma mark ===== 父类调用，子类触发
- (void)webViewControllerDidFinishLoad {
    
}
- (void)webViewDidFailLoadWithError:(nonnull NSError *)error {
    
}
- (void)webViewUpdateTitle:(NSString*)title {

}

#pragma mark - ================ Actions =================
- (void)formCamera {
    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
    cameraVc.maxCount                = 1;
    @weakify(self);
    cameraVc.callback = ^(NSMutableArray *cameras) {
        @strongify(self);
        NSMutableArray *images = [NSMutableArray array];
        for (ZLCamera *tempImg in cameras) {
            [images addObject:tempImg.photoImage];
        }
        UIViewController *imageEditVC = [CT() mediator_imageEditVCWithImages:images
                                                                    isCamera:YES
                                                                    callBack:^(NSArray<UIImage *> *_Nonnull imageList) {
                                                                        NSDictionary *upload = @{@"data" : UIImageJPEGRepresentation(imageList.firstObject, 0.8),
                                                                                                 @"name" : @"Filedata[]",
                                                                                                 @"fileName" : [NSString stringWithFormat:@"%@.jpg", [self getCurrentTime]],
                                                                                                 @"uploadType" : @"image/jpeg"};

                                                                        [self updateTheAttach:@[ upload ]];
                                                                    }];
        [self.navigationController pushViewController:imageEditVC animated:YES];
    };
    [cameraVc showPickerVc:self];
    //退键盘
    [self cancleClick];
}

- (void)formPhotoAblum {
    TZImagePickerController *imagePickerVc   = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    imagePickerVc.navigationBar.barTintColor = [UIColor colorWithHexString:@"#296cff"];
    imagePickerVc.allowTakePicture           = NO;
    imagePickerVc.allowTakeVideo             = NO;
    imagePickerVc.allowPickingOriginalPhoto  = YES;
    imagePickerVc.maxImagesCount             = self.maxCount;
    imagePickerVc.photoWidth                 = WIDTH_H5 * [UIScreen mainScreen].scale;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        UIViewController *imageEditVC = [CT() mediator_imageEditVCWithImages:[photos mutableCopy]
                                                                    isCamera:NO
                                                                    callBack:^(NSArray<UIImage *> *_Nonnull imageList) {
                                                                        NSMutableArray *uploads = [NSMutableArray array];
                                                                        for (UIImage *iamge in imageList) {
                                                                            NSData *data         = UIImageJPEGRepresentation(iamge, 0.8);
                                                                            NSString *imageName  = [UIImage imageMIMETypeByImageData:data];
                                                                            NSDictionary *upload = @{@"data" : data,
                                                                                                     @"name" : @"Filedata[]",
                                                                                                     @"fileName" : [NSString stringWithFormat:@"%@.%@", [self getCurrentTime], [imageName substringFromIndex:6]],
                                                                                                     @"uploadType" : imageName};
                                                                            [uploads addObject:upload];
                                                                        }
                                                                        [self updateTheAttach:uploads];
                                                                    }];
        [self.navigationController pushViewController:imageEditVC animated:YES];
    }];
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
        NSMutableArray *uploads = [NSMutableArray array];
        
        [[TZImageManager manager] getVideoOutputPathWithAsset:asset
            success:^(NSString *outputPath) {
                if (outputPath) {
                    NSArray *resources = [PHAssetResource assetResourcesForAsset:asset];
                     NSString *orgFilename = ((PHAssetResource*)resources[0]).originalFilename;
//                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        //文件信息上传
                        NSDictionary *upload = @{@"data" : [NSData dataWithContentsOfFile:outputPath],
                                                 @"name" : @"Filedata[]",
                                                 @"fileName" : orgFilename ? : @"",
                                                 @"uploadType" : @"video/mp4"};

                        [self updateTheAttach:@[ upload ]];
//                    });
                }
                else {
                    [QYCToast showToastWithMessage:@"视频选择失败" type:QYCToastTypeError];
                }
            }
        failure:^(NSString *errorMessage, NSError *error) {
            [QYCToast showToastWithMessage:@"视频选择失败" type:QYCToastTypeError];
        }];
        
        
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    //退键盘
    [self cancleClick];
}

- (void)updateTheAttach:(NSArray *)uploadParams {
    [MBProgressHUD showMessage:nil toView:self.view];
    @weakify(self);
    [CT() mediator_attachmentUploadFileWithTableId:self.tableId
                                           fieldId:self.schemaId
                                          recordId:@"chooseImage"
                                      uploadParams:uploadParams
                                          callback:^(BOOL success, NSArray *_Nullable fileNames) {
                                              @strongify(self);
                                              [MBProgressHUD hideHUDForView:self.view];
                                              NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
                                              for (int i = 0; i < fileNames.count; i++) {
                                                  NSMutableDictionary *params = [NSMutableDictionary dictionary];
                                                  NSString *name              = fileNames[i];
                                                  [self saveContent:uploadParams[i][@"data"] WithName:name];
                                                  NSString *urlStr = [NSString stringWithFormat:@"%@%@/%@/%@/%@", [CT() mediator_attachmentDownlaodBaseURL], self.tableId, self.schemaId, @"chooseImage", name];
                                                  [params setValue:urlStr forKey:@"fileUrl"];
                                                  [params setValue:name forKey:@"fileName"];
                                                  [imagesArray addObject:params];
                                              }
                                              self.selectImageBlock(imagesArray);
                                          }];
}

- (void)cancleClick {
    [self.backView removeFromSuperview];
    [self.attachmentView removeFromSuperview];
}

- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat       = @"yyyyMMddHHmmss";
    return [formatter stringFromDate:[NSDate date]];
}

- (void)saveContent:(NSData *)data WithName:(NSString *)name {
    NSString *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES).firstObject;
    if ([name containsString:@"_"]) {
        name = [name substringFromIndex:[name rangeOfString:@"_"].location + 1];
    }
    NSString *filePath = [paths stringByAppendingPathComponent:[NSString stringWithFormat:@"MyFile/%@", name]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) { //如果不存在文件，写入
        [data writeToFile:filePath atomically:YES];
    }
}

#pragma mark - ================ Getter and Setter =================
- (UIView *)backView {
    if (!_backView) {
        _backView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_H5, HEIGHT_H5)];
        _backView.backgroundColor = KQYCColorAlpha(000000, .3, 000000, .3);
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleClick)]];
    }
    return _backView;
}

- (BMKGeoCodeSearch *)geoSearch {
    if (!_geoSearch) {
        _geoSearch          = [[BMKGeoCodeSearch alloc] init];
        _geoSearch.delegate = self;
    }
    return _geoSearch;
}
- (NSMutableDictionary *)addressValue {
    if (!_addressValue) {
        _addressValue = [NSMutableDictionary new];
    }
    return _addressValue;
}

- (NSMutableArray<QYCWebBridgeResponseCallback> *)curLocationCallbacks {
    if (!_curLocationCallbacks) {
        _curLocationCallbacks = [NSMutableArray array];
    }
    return _curLocationCallbacks;
}
- (NSLock *)arrayLock {
    if (!_arrayLock) {
        _arrayLock = [[NSLock alloc] init];
    }
    return _arrayLock;
}


@end

@implementation QYCDataSourceFields

@end
