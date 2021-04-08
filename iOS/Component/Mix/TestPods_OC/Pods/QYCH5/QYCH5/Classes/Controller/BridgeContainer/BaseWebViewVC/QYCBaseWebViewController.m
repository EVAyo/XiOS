//
//  QYCBaseWebViewController.m
//  Qiyeyun
//
//  Created by dong on 2018/10/29.
//  Copyright © 2018年 安元. All rights reserved.
//

#import "QYCBaseWebViewController.h"
#import "QYCH5Config.h"
// QYC Pods
#import <QYCCategory/UIColor+QYCColor.h>
#import "WKWebViewJavascriptBridge.h"
// Vendor Pods
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategoriesMacro.h>
#import <YYCategories/UIColor+YYAdd.h>

@interface QYCBaseWebViewController ()<WKNavigationDelegate>

@property (nonatomic, copy, readwrite) NSString *urlStr;
@property (nonatomic, strong) UIView *statusBarView;

@property (nonatomic, strong, readwrite) WKWebView *wkWebView;
@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) BOOL isShowEstimatedProgress;

@end

@implementation QYCBaseWebViewController

/// 空实现该方法，防止因为setValuesForKeysWithDictionary引起crash
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

#pragma mark - ================ LifeCycle =================

- (instancetype)initWithURLStr:(NSString *)urlStr {
    self = [super init];
    if (self) {
        _urlStr = urlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add by linx at 2020.08.13 ：解决灰度测试H5加载失效的问题，新增CURRENT_ENT区分是否灰度。
    // 在调用[super viewDidLoad];之前，底层直接获取Cookie，并重置。
    NSHTTPCookieStorage *cookieStorage             = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSMutableArray<NSHTTPCookie *> *sessionCookies = [NSMutableArray array];
    [cookieStorage.cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj.name isEqualToString:@"PHPSESSID"] || [obj.name isEqualToString:@"CURRENT_ENT"]) {
            [sessionCookies addObject:obj];
        }
    }];
    self.cookies = sessionCookies.copy;
    
    // 初始化页面
    [self p_setupUI];
    // Request
    [self requestUrlStr:_urlStr];
    // add refresh
    if (_canRefresh) {
        @weakify(self);
        self.wkWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self willRefresh];
            [self reload];
        }];
        self.wkWebView.scrollView.mj_header.beginRefreshingCompletionBlock = ^{
            @strongify(self);
            [self completedRefresh];
        };
    }
}

- (void)dealloc {
    [_wkWebView stopLoading];
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_wkWebView removeObserver:self forKeyPath:@"title"];
}

#pragma mark - ================ Delegate =================

#pragma mark ===== WKNavigation Delegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"] || [webView.URL.absoluteString hasPrefix:@"itms-appss://"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

/// 这个代理方法表示当客户端收到服务器的响应头，根据response相关信息，可以决定这次跳转是否可以继续进行。在收到响应后，决定是否跳转的代理。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/// 准备加载页面。等同于UIWebViewDelegate: - webView:shouldStartLoadWithRequest:navigationType
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    webView.hidden = YES;
    // 唤起 原生百度地图/高德/腾讯地图
    if ([webView.URL.absoluteString hasPrefix:@"baidumap://map"] || [webView.URL.absoluteString hasPrefix:@"iosamap://map"] || [webView.URL.absoluteString hasPrefix:@"qqmap://map"]) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:webView.URL.absoluteString]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webView.URL.absoluteString]];
        }
    }
}

/// 内容开始加载. 等同于UIWebViewDelegate: - webViewDidStartLoad:
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}

/// 页面加载完成。 等同于UIWebViewDelegate: - webViewDidFinishLoad:
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        webView.hidden = NO;
    });
    
    [self webViewControllerDidFinishLoad];
}

/// 页面加载失败。等同于UIWebViewDelegate: - didFailLoadWithError:
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if (!error) {
        return;
    }
    [self webViewDidFailLoadWithError:error];
}

#pragma mark 创建一个新的WebView

/// WKFrameInfo有一个 mainFrame 的属性，正是这个属性标记着这个frame是在主frame里还是新开一个frame。
/// 如果 targetFrame 的 mainFrame 属性为NO，表明这个 WKNavigationAction 将会新开一个页面。
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    // 接口的作用是打开新窗口委托
    if (!navigationAction.targetFrame.isMainFrame) {
        [self.wkWebView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark ===== 计算wkWebView进度条

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        if (!_isShowEstimatedProgress) { // 设置不显示，则隐藏
            return;
        }
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress < 1.0) {
            [self.progressView setProgress:newprogress animated:YES];
            self.progressView.hidden = NO;
        }
        else {
            [self.progressView setProgress:0 animated:NO];
            self.progressView.hidden = YES;
        }
    }
    else if (object == self.wkWebView && [keyPath isEqualToString:@"title"]) {
        [self webViewUpdateTitle:self.wkWebView.title];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - ================ Public Method =================

- (void)reload {
    [self.wkWebView reload];
    // 结束刷新
    if (self.wkWebView.scrollView.mj_header) {
        [self.wkWebView.scrollView.mj_header endRefreshing];
    }
}

- (void)stopLoading {
    return [self.wkWebView stopLoading];
}

- (void)requestUrlStr:(NSString *)urlStr {
    NSString *urlStrT = [urlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (!urlStrT) {
        return;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStrT] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [self.wkWebView loadRequest:request];
}

- (void)updateCookie {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    WKWebsiteDataStore *dataStore      = [WKWebsiteDataStore nonPersistentDataStore];
    [cookieStorage.cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj.name isEqualToString:@"PHPSESSID"] || [obj.name isEqualToString:@"CURRENT_ENT"]) {
            if (@available(iOS 11.0, *)) {
                [dataStore.httpCookieStore setCookie:obj completionHandler:nil];
            }
            else {
                // Fallback on earlier versions
            }
        }
    }];

    self.wkWebView.configuration.websiteDataStore          = dataStore;
    self.wkWebView.configuration.allowsInlineMediaPlayback = YES;
}

- (void)setStatusBarColor:(UIColor *)color {
    self.statusBarView.backgroundColor = color;
}

- (void)setCloseBounces:(BOOL)closeBounces {
    _closeBounces = closeBounces;
    self.wkWebView.scrollView.bounces = !closeBounces;
}

- (void)setShowEstimatedProgress:(BOOL)isShow {
    _isShowEstimatedProgress = isShow;
}

- (BOOL)canGoBack {
    if (![self.wkWebView canGoBack]) {
        return NO;
    }
    else {
        return self.wkWebView.backForwardList.backList.count > 0;
    }
}

- (void)goBack {
    WKNavigation *navigation = [self.wkWebView goBack];
    NSInteger offset = 1;
    while (!navigation) {
        offset++;
        if (self.wkWebView.backForwardList.backList.count >= offset) {
            WKBackForwardListItem *item1 = [self.wkWebView.backForwardList itemAtIndex:-offset];
            navigation                   = [self.wkWebView goToBackForwardListItem:item1];
        }
        else {
            break;
        }
    }
}

#pragma mark ===== Bridge

- (void)registerHandler:(NSString *)handlerName handler:(QYCWebBridgeHandler)handler {
    [self.bridge registerHandler:handlerName handler:handler];
}

- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(QYCWebBridgeResponseCallback)responseCallback {
    [self.bridge callHandler:handlerName data:data responseCallback:responseCallback];
}

#pragma mark - ================ Private Method =================

- (void)p_setupUI {
    self.view.backgroundColor = KQYCColor(ffffff, 1e1e1e);
    _isShowEstimatedProgress = YES; // 默认显示进度条
    // add subViews
    [self.view addSubview:self.statusBarView];
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progressView];
    // layouts
    [self.statusBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.5);
        make.height.mas_equalTo([self p_statusBarHeight]);
    }];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.mas_equalTo(0);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.height.mas_equalTo(2);
    }];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidBecomeHidden:) name:UIWindowDidBecomeHiddenNotification object:nil];
}

- (CGFloat)p_statusBarHeight {
    CGFloat statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        statusBarHeight = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

#pragma mark - ================ Actions =================

- (void)windowDidBecomeHidden:(NSNotification *)noti {
    UIWindow *win = (UIWindow *)noti.object;

    if (win) {
        UIViewController *rootVC = win.rootViewController;

        NSArray<__kindof UIViewController *> *vcs = rootVC.childViewControllers;

        if ([vcs.firstObject isKindOfClass:NSClassFromString(@"AVPlayerViewController")]) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        }
    }
}

#pragma mark - ================ settter and getter =================

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:[self p_updateCookie]];
        _wkWebView.navigationDelegate = self;
        _wkWebView.scrollView.bounces = !self.closeBounces;
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return _wkWebView;
}

- (WKWebViewConfiguration *)p_updateCookie {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    if (_cookies.count) {
        WKWebsiteDataStore *dataStore = [WKWebsiteDataStore nonPersistentDataStore];
        if (@available(iOS 11.0, *)) {
            [_cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
                [dataStore.httpCookieStore setCookie:obj completionHandler:nil];
            }];
        }
        else {
        }
        config.websiteDataStore = dataStore;
    }
    return config;
}

- (WKWebViewJavascriptBridge *)bridge {
    if (!_bridge) {
        _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
        [_bridge setWebViewDelegate:self];
    }
    return _bridge;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView                = [[UIProgressView alloc] init];
        _progressView.hidden         = YES;
        _progressView.tintColor      = UIColorHex(B89062);
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

- (UIView *)statusBarView {
    if (!_statusBarView) {
        _statusBarView                 = [[UIView alloc] init];
        _statusBarView.backgroundColor = KQYCColor(ffffff, 1e1e1e);
    }
    return _statusBarView;
}

@end
