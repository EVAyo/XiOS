//
//  LinkWebViewController.m
//  Qiyeyun
//
//  Created by dong on 16/3/10.
//  Copyright © 2016年 钱立新. All rights reserved.
//

#import "LinkWebViewController.h"
#import "QYCLinkShareViewController.h"
#import <WebKit/WebKit.h>
// QYC Pods
#import <QYCCategory/NSBundle+QYCBundle.h>
#import <QYCCategory/UIColor+QYCColor.h>
#import <QYCIconFont/QYCFontImage.h>
#import <QYCNavigationController/NavigationViewController.h>
#import <QYCUI/QYCToast.h>
// Vendor Pods
#import <YYCategories/NSString+YYAdd.h>
#import <YYCategories/UIColor+YYAdd.h>
#import <YYCategories/UIView+YYAdd.h>
// CT
#import "CTMediator+QChat.h"
#import "CTMediator+QYCWorkCircleModuleActions.h"

@interface LinkWebViewController () <WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) WKWebView *linkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *supportLabel;
@property (nonatomic, assign) BOOL allowZoom;

@end

@implementation LinkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor   = KQYCColor(ffffff, 1e1e1e);
    [self configUI];
}

- (void)configUI {
    self.supportLabel.hidden = NO;
    self.progressView.hidden = NO;
    self.allowZoom           = YES;
    [self.view insertSubview:self.linkWebView belowSubview:self.progressView];
    [self.linkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url cachePolicy:0 timeoutInterval:60];
    [self.linkWebView loadRequest:request];
    self.navigationItem.rightBarButtonItem         = [[UIBarButtonItem alloc] initWithImage:[QYCFontImage iconWithName:@"更多竖" fontSize:20 color:KQYCColor(ffffff, c4c4c4)] style:UIBarButtonItemStylePlain target:self action:@selector(moreBtnClick)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidBecomeHidden:) name:UIWindowDidBecomeHiddenNotification object:nil];
}

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

#pragma mark - 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    if (object == self.linkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress < 1.0) {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
        else {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }
    }
}

#pragma mark - ***** dealloc 取消监听
- (void)dealloc {
    [_linkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    _linkWebView.scrollView.delegate = nil;
}

#pragma mark - WKNavigationDelegate 【该代理提供的方法，可以用来追踪加载过程（页面开始加载、加载完成、加载失败）、决定是否执行跳转。】
#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}

#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (!self.title) {
        self.navigationItem.title = [webView.title isNotBlank] ? webView.title : self.url.absoluteString;
    }
    self.allowZoom         = NO;
    self.supportLabel.text = [NSString stringWithFormat:@"网页由 %@ 提供", webView.URL.host];
    [self.supportLabel sizeToFit];
    self.supportLabel.centerX                      = self.view.centerX;
    self.navigationItem.rightBarButtonItem.enabled = YES;

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/*! 页面跳转的代理方法有三种，分为（收到跳转与决定是否跳转两种）*/
#pragma mark 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
}

#pragma mark 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark 在发送请求之前，决定是否跳转，如果不添加这个，那么wkwebview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url          = navigationAction.request.URL;
    NSString *urlString = (url) ? url.absoluteString : @"";

    // iTunes: App Store link
    // 例如，微信的下载链接: https://itunes.apple.com/cn/app/id414478124?mt=8
    // Protocol/URL-Scheme without http(s)
    if ([urlString containsString:@"//itunes.apple.com/"] || (url.scheme && ![url.scheme hasPrefix:@"http"])) {
        UIApplication *application = [UIApplication sharedApplication];
        if ([application canOpenURL:url]) {
            if (@available(iOS 10.0, *)) {
                [application openURL:url
                              options:@{}
                    completionHandler:^(BOOL success){
                    }];
            }
            else {
                [application openURL:url];
            }
        }
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark 创建一个新的WebView
/// WKFrameInfo有一个 mainFrame 的属性，正是这个属性标记着这个frame是在主frame里还是新开一个frame。
/// 如果 targetFrame 的 mainFrame 属性为NO，表明这个 WKNavigationAction 将会新开一个页面。
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    // 接口的作用是打开新窗口委托
    if (!navigationAction.targetFrame.isMainFrame) {
        [self.linkWebView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark 针对于web界面的三种提示框（警告框、确认框、输入框）分别对应三种代理方法。下面只举了警告框的例子。
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    //  js 里面的alert实现，如果不实现，网页的alert函数无效  ,

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(NO);
                                                      }]];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *_Nullable))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *_Nonnull action) {
                                                           completionHandler(alertController.textFields[0].text ?: @"");
                                                       }])];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message ?: @"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *_Nonnull action) {
                                                           completionHandler();
                                                       }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
}

#pragma mark - scrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //下拉隐藏网页提供方
    scrollView.contentOffset.y >= 0 ? (_supportLabel.hidden = YES) : (_supportLabel.hidden = NO);
}

//禁止webivew放大缩小
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (self.allowZoom) {
        return nil;
    }
    else {
        return self.linkWebView.scrollView.subviews.firstObject;
    }
}
//转发
- (void)relay {
    NSDictionary *shareParams = @{QYCWCSendTypeKey : @(QYCWCSendTypeLink),
                                  QYCWCSendLinkUrl : [self.linkWebView.URL absoluteString] ?: @"",
                                  QYCWCSendLinkTitle : self.linkWebView.title ?: @""};
    UIViewController *vc      = [CT() mediator_remoteSharePost:shareParams callback:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

//转发
- (void)forwardMsg {
    UIViewController *contactViewController = [CT() mediator_forwardRichContentMessageWithEntId:self.qyc_entId title:self.linkWebView.title digest:self.linkWebView.URL.absoluteString imageURL:nil url:self.linkWebView.URL.absoluteString extra:nil];
    NavigationViewController *navi          = [[NavigationViewController alloc] initWithRootViewController:contactViewController];
    navi.modalPresentationStyle             = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:nil];
}

//复制链接
- (void)copyLinkUrl {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string        = [NSString stringWithFormat:@"%@", self.linkWebView.URL];
}
//浏览器打开链接
- (void)openLinkUrl {
    [[UIApplication sharedApplication] openURL:self.linkWebView.URL];
}
#pragma mark button click method
- (void)moreBtnClick {
    QYCLinkShareViewController *shareVC = [[QYCLinkShareViewController alloc] initWithNibName:@"QYCLinkShareViewController" bundle:[NSBundle bundleWithaClass:self.class aBundle:@"QYCH5"]];
    self.definesPresentationContext     = YES;
    shareVC.view.backgroundColor        = KQYCColorAlpha(000000, .4, 000000, .4);
    shareVC.modalPresentationStyle      = UIModalPresentationOverCurrentContext;
    shareVC.operationClick              = ^(OperationType operationType) {
        switch (operationType) {
            case 0:
                [self forwardMsg];
                break;
            case 1:
                [self relay];
                break;
            case 2:
                [self copyLinkUrl];
                break;
            case 3:
                [self openLinkUrl];
                break;
            case 4:
                [self.linkWebView reload];
                break;

            default:
                break;
        }
    };
    [self.navigationController presentViewController:shareVC animated:nil completion:nil];
}
#pragma mark setter and getter
- (WKWebView *)linkWebView {
    if (!_linkWebView) {
        WKWebViewConfiguration *wkWebConfig                           = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.preferences                                       = [[WKPreferences alloc] init];
        wkWebConfig.preferences.javaScriptEnabled                     = YES;
        wkWebConfig.preferences.javaScriptCanOpenWindowsAutomatically = false;
        // 视频页面播放支持
        wkWebConfig.allowsInlineMediaPlayback = YES;

        WKWebsiteDataStore *dataStore = [WKWebsiteDataStore nonPersistentDataStore];
        if (@available(iOS 11.0, *)) {
            NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            [cookieStorage.cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
                if ([obj.name isEqualToString:@"PHPSESSID"] || [obj.name isEqualToString:@"CURRENT_ENT"]) {
                    [dataStore.httpCookieStore setCookie:obj completionHandler:nil];
                }
            }];
        }
        wkWebConfig.websiteDataStore = dataStore;

        NSString *jSString         = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no');";
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [wkWebConfig.userContentController addUserScript:wkUserScript];
        _linkWebView                      = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:wkWebConfig];
        _linkWebView.autoresizingMask     = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _linkWebView.backgroundColor      = [UIColor clearColor];
        _linkWebView.navigationDelegate   = self;
        _linkWebView.UIDelegate           = self;
        _linkWebView.scrollView.delegate  = self;
        _linkWebView.opaque               = NO;
        _linkWebView.multipleTouchEnabled = YES;
        [_linkWebView sizeToFit];
    }
    return _linkWebView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView                = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
        _progressView.tintColor      = UIColorHex(4680ff);
        _progressView.trackTintColor = [UIColor clearColor];
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

- (UILabel *)supportLabel {
    if (_supportLabel == nil) {
        _supportLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.view.bounds.size.width - 2 * 20, 50)];
        //网页来源提示居中
        CGPoint center              = _supportLabel.center;
        center.x                    = self.view.frame.size.width / 2;
        _supportLabel.center        = center;
        _supportLabel.font          = [UIFont systemFontOfSize:11];
        _supportLabel.textAlignment = NSTextAlignmentCenter;
        _supportLabel.textColor     = KQYCColor(D3D3D3, 333333);
        _supportLabel.numberOfLines = 0;
        [self.view sendSubviewToBack:_supportLabel];
        [self.view addSubview:_supportLabel];
    }
    return _supportLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
