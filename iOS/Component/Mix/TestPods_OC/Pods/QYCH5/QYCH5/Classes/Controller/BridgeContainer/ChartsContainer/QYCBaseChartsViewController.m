//
//  QYCBaseChartsViewController.m
//  QYCH5
//
//  Created by 启业云03 on 2021/3/29.
//

#import "QYCBaseChartsViewController.h"
#import <QYCIconFont/QYCFontImage.h>
#import <QYCNavigationExtension/UIViewController+JZExtension.h>
#import <YYCategories/UIColor+YYAdd.h>

@interface QYCBaseChartsViewController ()

@end

@implementation QYCBaseChartsViewController

#pragma mark - ================ LifeCycle =================

- (void)viewDidLoad {
    [super viewDidLoad];
    // 关闭全屏侧滑
    self.jz_navigationInteractivePopGestureEnabled = NO;
    // 导航栏按钮
    if (![self isKindOfClass:NSClassFromString(@"QYCChartsBoardViewController")]) { // 一级界面的仪表盘不要返回按钮
        [self.navigationItem setLeftBarButtonItem:self.goBackItem];
    }
}

#pragma mark - ================ Delegate =================

#pragma mark ===== 父类调用，子类触发
- (void)webViewControllerDidFinishLoad {
    
}

- (void)webViewDidFailLoadWithError:(nonnull NSError *)error {
    
}

- (void)webViewUpdateTitle:(NSString*)title {
    
}

#pragma mark - ================ Actions =================

- (void)goBackItemClick {
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    }
    else {
        self.jz_navigationInteractivePopGestureEnabled = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)shareItemClick {
    // 子类实现
}

#pragma mark - ================ Getter and Setter =================

- (UIBarButtonItem *)goBackItem {
    if (!_goBackItem) {
        _goBackItem = [[UIBarButtonItem alloc] initWithImage:[QYCFontImage iconWithName:@"返回" fontSize:20 color:UIColorHex(ffffff)] style:UIBarButtonItemStylePlain target:self action:@selector(goBackItemClick)];
    }
    return _goBackItem;
}

- (UIBarButtonItem *)shareItem {
    if (!_shareItem) {
        _shareItem = [[UIBarButtonItem alloc] initWithImage:[QYCFontImage iconWithName:@"分享" fontSize:15 color:UIColorHex(ffffff)] style:UIBarButtonItemStylePlain target:self action:@selector(shareItemClick)];
    }
    return _shareItem;
}

@end
