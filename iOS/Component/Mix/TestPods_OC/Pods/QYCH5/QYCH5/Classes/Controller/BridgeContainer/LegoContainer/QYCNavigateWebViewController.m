//
//  QYCNavigateWebViewController.m
//  Qiyeyun
//
//  Created by 钱立新 on 2018/11/12.
//  Copyright © 2018 安元. All rights reserved.
//

#import "QYCNavigateWebViewController.h"
#import "QYCChartsH5EmptyDataView.h"
#import "QYCLinkShareViewController.h"
// QYC Pods
#import <QYCCategory/NSBundle+QYCBundle.h>
#import <QYCCategory/UIColor+QYCColor.h>
#import <QYCIconFont/QYCFontImage.h>
#import <QYCNavigationController/NavigationViewController.h>
#import <QYCNavigationExtension/UIViewController+JZExtension.h>
#import <QYCUI/QYCToast.h>
// Vendor Pods
#import <Masonry/Masonry.h>
#import <YYCategories/UIColor+YYAdd.h>
#import <YYCategories/YYCategoriesMacro.h>
// CT
#import "CTMediator+QChat.h"
#import "CTMediator+QYCWorkCircleModuleActions.h"

@interface QYCNavigateWebViewController () <QYCChartsH5EmptyDataViewDelegate>
@property (nonatomic, strong) UIBarButtonItem *goBackItem;
@property (nonatomic, strong) UIBarButtonItem *closeBarButtonItem;
@end

@implementation QYCNavigateWebViewController

#pragma mark - ================ LifeCycle =================

- (void)viewDidLoad {
    [super viewDidLoad];

    self.jz_navigationInteractivePopGestureEnabled = NO;
    self.navigationItem.rightBarButtonItem         = [[UIBarButtonItem alloc] initWithImage:[QYCFontImage iconWithName:@"更多竖" fontSize:20 color:KQYCColor(ffffff, c4c4c4)] style:UIBarButtonItemStylePlain target:self action:@selector(moreBtnClick)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateNavigationItems];
    if ([self.urlStr containsString:@"/microapp/h5/"]) {
        self.jz_navigationBarHidden = YES;
        [self setStatusBarColor:UIColorHex(4680ff)];
    }
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - ================ Delegate =================

#pragma mark QYCChartsH5EmptyDataViewDelegate

- (void)chartsH5EmptyDataViewReloadClick:(QYCChartsH5EmptyDataView *)emptyDataView {
    if (self.wkWebView) {
        [self.wkWebView reload];
    }
}

#pragma mark QYCWebViewDelegate 父类触发子类

- (void)webViewControllerDidFinishLoad {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // self.title = webView.title;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    });
}

- (void)webViewDidFailLoadWithError:(nonnull NSError *)error {
    [QYCToast showToastWithMessage:@"加载失败" type:QYCToastTypeError];
}

- (void)webViewUpdateTitle:(NSString *)title {
    self.title = title;
}

// 转发
- (void)relay {
    NSDictionary *shareParams = @{QYCWCSendTypeKey : @(QYCWCSendTypeLink),
                                  QYCWCSendLinkUrl : [self.wkWebView.URL absoluteString] ?: @"",
                                  QYCWCSendLinkTitle : self.wkWebView.title ?: @""};
    UIViewController *vc      = [CT() mediator_remoteSharePost:shareParams callback:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

//转发
- (void)forwardMsg {
    id richMsg = [CT() mediator_createRichContentMessageWithTitle:self.wkWebView.title
                                                           digest:self.wkWebView.URL.absoluteString ?: @""
                                                         imageURL:nil
                                                              url:self.wkWebView.URL.absoluteString ?: @""
                                                            extra:nil];
    id tempModel = [CT() mediator_creteMessageModelWithMsgContent:richMsg objectName:@"RC:ImgTextMsg" sentStatus:30];
    UIViewController *contactViewController = [CT() mediator_forwardMessageModel:tempModel selectedCancelBlock:nil forwardCancelBlock:nil];

    NavigationViewController *navi = [[NavigationViewController alloc] initWithRootViewController:contactViewController];
    navi.modalPresentationStyle    = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:nil];
}

//复制链接
- (void)copyLinkUrl {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string        = [NSString stringWithFormat:@"%@", self.wkWebView.URL];
}

//浏览器打开链接
- (void)openLinkUrl {
    [[UIApplication sharedApplication] openURL:self.wkWebView.URL];
}

#pragma mark - ================ Actions =================

- (void)moreBtnClick {
    UITabBarController *tab             = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tab.tabBar.hidden                   = YES;
    QYCLinkShareViewController *shareVC = [[QYCLinkShareViewController alloc] initWithNibName:@"QYCLinkShareViewController" bundle:[NSBundle bundleWithaClass:self.class aBundle:@"QYCH5"]];
    self.definesPresentationContext     = YES;
    shareVC.view.backgroundColor        = KQYCColorAlpha(000000, .4, 000000, .4);
    shareVC.modalPresentationStyle      = UIModalPresentationOverCurrentContext;
    @weakify(self)
        shareVC.operationClick = ^(OperationType operationType) {
        @strongify(self) switch (operationType) {
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
                [self.wkWebView reload];
                break;
            default:
                break;
        }
    };
    shareVC.dissMissAction = ^{
        // 若在tabbar首页，则及时显示tabBar
        if ([self.navigationController.viewControllers.firstObject isKindOfClass:[self class]]) {
            UITabBarController *tab2 = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            tab2.tabBar.hidden       = NO;
        }
    };
    [self.navigationController presentViewController:shareVC animated:nil completion:nil];
}

- (void)goBackItemClick {
    if ([self.wkWebView isLoading]) {
        [self.wkWebView stopLoading];
    }
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    }
    else {
        self.jz_navigationInteractivePopGestureEnabled = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)navigationIemHandleClose {
    self.jz_navigationInteractivePopGestureEnabled = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ================ Private Methods =================

- (void)showEmptyDataView {
    QYCChartsH5EmptyDataView *emptyView = [[QYCChartsH5EmptyDataView alloc] init];
    emptyView.delegate                  = self;
    [self.view addSubview:emptyView];
    [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}

- (void)updateNavigationItems {
    UIBarButtonItem *spaceButtonItem   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButtonItem.width              = 0;
    NSMutableArray *leftBarButtonItems = [NSMutableArray arrayWithArray:@[ spaceButtonItem, self.goBackItem, spaceButtonItem, self.closeBarButtonItem ]];
    [self.navigationItem setLeftBarButtonItems:leftBarButtonItems animated:NO];
}

#pragma mark - ================ Getter and Setter =================

- (UIBarButtonItem *)goBackItem {
    if (!_goBackItem) {
        _goBackItem    = [[UIBarButtonItem alloc] init];
        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [QYCFontImage iconWithName:@"返回" fontSize:20 color:KQYCColor(ffffff, c4c4c4)];
        [btn setImage:image forState:UIControlStateNormal];
        //左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让返回按钮内容继续向左边偏移5，如果不设置的话，就会发现返回按钮离屏幕的左边的距离有点儿大，不美观
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        btn.frame             = CGRectMake(0, 0, 25, 40);
        [btn addTarget:self action:@selector(goBackItemClick) forControlEvents:UIControlEventTouchUpInside];
        _goBackItem.customView = btn;
    }
    return _goBackItem;
}

- (UIBarButtonItem *)closeBarButtonItem {
    if (_closeBarButtonItem)
        return _closeBarButtonItem;
    _closeBarButtonItem = [[UIBarButtonItem alloc] init];
    UIButton *btn       = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image      = [QYCFontImage iconWithName:@"关闭" fontSize:20 color:KQYCColor(ffffff, c4c4c4)];
    [btn setImage:image forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentEdgeInsets          = UIEdgeInsetsMake(0, -5, 0, 0);
    btn.frame                      = CGRectMake(0, 0, 25, 40);
    [btn addTarget:self action:@selector(navigationIemHandleClose) forControlEvents:UIControlEventTouchUpInside];
    _closeBarButtonItem.customView = btn;
    return _closeBarButtonItem;
}
@end
