//
//  QYCChartsH5ViewController.m
//  Qiyeyun
//
//  Created by dong on 2018/10/31.
//  Copyright © 2018年 安元. All rights reserved.
//

#import "QYCChartsH5ViewController.h"
#import "QYCChartsH5EmptyDataView.h"
// QYC Pods
#import <QYAlterView/QYAlterView.h>
#import <QYCNavigationController/NavigationViewController.h>
#import <QYCUI/QYCToast.h>
// Vendor Pods
#import <Masonry/Masonry.h>
#import <YYCategories/NSString+YYAdd.h>
#import <YYCategories/YYCategoriesMacro.h>
// CT
#import "CTMediator+QChat.h"

@interface QYCChartsH5ViewController () <QYCChartsH5EmptyDataViewDelegate>

@end

@implementation QYCChartsH5ViewController {
    UIImage *_shareImage;
}

#pragma mark - ================ LifeCycle =================

- (void)viewDidLoad {
    [super viewDidLoad];
    [self native_jsWithCallBack];
}

#pragma mark - ================ Delegate =================

#pragma mark QYCChartsH5EmptyDataViewDelegate

- (void)chartsH5EmptyDataViewReloadClick:(QYCChartsH5EmptyDataView *)emptyDataView {
    if (self.wkWebView) {
        [self.wkWebView reload];
    }
}

#pragma mark 父类调用，子类触发

- (void)webViewDidFailLoadWithError:(nonnull NSError *)error {
    if (error) {
        [self showEmptyDataView];
    }
}

#pragma mark - EventResponse Method

- (void)shareItemClick {
    // native call js
    @weakify(self);
    [self callHandler:@"getShareOptions"
                    data:nil
        responseCallback:^(id _Nonnull responseData) {
            @strongify(self);
            NSString *imageBase64 = responseData[@"imageUrl"];
            if ([imageBase64 isKindOfClass:NSNull.class]) {
                return;
            }
            NSURL *imageUrl = [NSURL URLWithString:imageBase64];
            [self shareImageToChat:[NSData dataWithContentsOfURL:imageUrl]];
        }];
}

#pragma mark - ================ Private Methods =================

/// JS Call Native
- (void)native_jsWithCallBack {
    // update title
    @weakify(self);
    [self registerHandler:@"setPageTitle"
                  handler:^(id _Nonnull data, QYCWebBridgeResponseCallback _Nonnull responseCallback) {
                      @strongify(self);
                      if ([data isKindOfClass:[NSDictionary class]]) {
                          self.navigationItem.title = data[@"title"] ?: @"";
                      }
                  }];
    // isShowShare
    [self registerHandler:@"isShowShareBtn"
                  handler:^(id _Nonnull data, QYCWebBridgeResponseCallback _Nonnull responseCallback) {
                      @strongify(self);
                      BOOL isShowShareBtn = [[data valueForKey:@"isShowShareBtn"] boolValue];
                      // share item
                      // 启聊模块存在可转发
                      NSNumber *qiChatMoudle                 = [[NSUserDefaults standardUserDefaults] objectForKey:@"hasQiChat"];
                      BOOL hasQiChat                         = qiChatMoudle && [qiChatMoudle isEqual:@1];
                      self.navigationItem.rightBarButtonItem = (isShowShareBtn && hasQiChat) ? self.shareItem : nil;
                  }];
    // item share click
    [self registerHandler:@"shareOptions"
                  handler:^(id _Nonnull data, QYCWebBridgeResponseCallback _Nonnull responseCallback) {
                      @strongify(self);
                      NSURL *imageUrl = [NSURL URLWithString:data[@"imageUrl"]];
                      [self shareImageToChat:[NSData dataWithContentsOfURL:imageUrl]];
                  }];
    // add by linx for 2019.12需求：仪表盘根据是否有启聊进行分享
    [self registerHandler:@"isContainsQichat" handler:^(id  _Nonnull data, QYCWebBridgeResponseCallback  _Nonnull responseCallback) {
        BOOL isHasQiChat = NO;
        // 启聊模块存在可转发
        NSNumber *qiChatMoudle = [[NSUserDefaults standardUserDefaults] objectForKey:@"hasQiChat"];
        if (qiChatMoudle && [qiChatMoudle isEqual:@1]) {
            isHasQiChat = YES;
        }
        responseCallback([NSNumber numberWithBool:isHasQiChat]);
    }];
}

- (void)shareImageToChat:(NSData *)imageData {
    if (!imageData) {
        return;
    }
    UIViewController *contactViewController = [CT() mediator_forwardImage:imageData entId:self.qyc_entId];
    NavigationViewController *navi          = [[NavigationViewController alloc] initWithRootViewController:contactViewController];
    navi.modalPresentationStyle             = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:nil];
}

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

@end
