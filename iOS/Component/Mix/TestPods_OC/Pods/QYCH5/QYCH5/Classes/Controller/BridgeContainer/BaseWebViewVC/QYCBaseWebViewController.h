//
//  QYCBaseWebViewController.h
//  Qiyeyun
//
//  Created by dong on 2018/10/29.
//  Copyright © 2018年 安元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "NSObject+QYCExtensionEntId.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^QYCWebBridgeResponseCallback)(id responseData);
typedef void (^QYCWebBridgeHandler)(id data, QYCWebBridgeResponseCallback responseCallback);

@interface QYCBaseWebViewController : UIViewController

/// 是否支持刷新
@property (nonatomic, assign) BOOL canRefresh;
/// 关闭webView视图的弹性
@property (nonatomic, assign) BOOL closeBounces;
/// cookie设置
@property (nonatomic, strong) NSArray<NSHTTPCookie *> *cookies;

/// 加载链接
@property (nonatomic, copy, readonly) NSString *urlStr;
/// webView
@property (nonatomic, strong, readonly) WKWebView *wkWebView;

/// 初始化
- (instancetype)initWithURLStr:(NSString *)urlStr;
/// 重新请求
- (void)requestUrlStr:(NSString *)urlStr;

///  手动更新cookie
- (void)updateCookie;

/// 自定义状态栏背景色
- (void)setStatusBarColor:(UIColor *)color;
/// 自定义是否显示进度条，默认：显示
- (void)setShowEstimatedProgress:(BOOL)isShow;

/// 注册JS交互
- (void)registerHandler:(NSString *)handlerName handler:(QYCWebBridgeHandler)handler;
- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(QYCWebBridgeResponseCallback)responseCallback;

#pragma mark 父类调用，子类触发
- (void)willRefresh;
- (void)completedRefresh;

- (void)webViewControllerDidFinishLoad;
- (void)webViewDidFailLoadWithError:(nonnull NSError *)error;
- (void)webViewUpdateTitle:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
