//
//  QYCAppStoreViewController.m
//  Qiyeyun
//
//  Created by dong on 2018/11/2.
//  Copyright © 2018年 安元. All rights reserved.
//

#import "QYCAppStoreViewController.h"
// QYC Pods
#import <QYCCategory/UIColor+QYCColor.h>
#import <QYCUI/QYCToast.h>
// Vendor Pods
#import <UShareUI/UMSocialUIManager.h>
#import <YYCategories/YYCategoriesMacro.h>

@interface QYCAppStoreViewController ()

@end

@implementation QYCAppStoreViewController

#pragma mark - ================ LifeCycle =================

- (void)viewDidLoad {
    [super viewDidLoad];
    [self native_jsWithCallBack];
}

#pragma mark - ================ Delegate =================

#pragma mark EventResponse Method

- (void)shareItemClick {
    // native call js
    @weakify(self);
    [self callHandler:@"shareOptions" data:nil responseCallback:^(id _Nonnull responseData) {
        @strongify(self);
        [self showShareMenuViewWithData:responseData];
    }];
}

#pragma mark - ================ Private Methods =================

- (void)native_jsWithCallBack {
    // js call native
    @weakify(self);
    //获取设备信息
    [self registerHandler:@"getDeviceInfo"
                  handler:^(id _Nonnull data, QYCWebBridgeResponseCallback _Nonnull responseCallback) {
        NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString *deviceVersion = [UIDevice currentDevice].systemVersion;
        responseCallback(@{@"platform" : @"iOS",
                                         @"deviceVersion" : deviceVersion,
                                         @"appVersion" : appVersion,
                                         @"isApp" : [NSNumber numberWithBool:YES]});
    }];
    //show shareBtn
    [self registerHandler:@"isShowShareBtn"
                  handler:^(id _Nonnull data, QYCWebBridgeResponseCallback _Nonnull responseCallback) {
        @strongify(self);
        BOOL isShowShareBtn = [[data valueForKey:@"isShowShareBtn"] boolValue];
        //share item
        self.navigationItem.rightBarButtonItem = isShowShareBtn ? self.shareItem : nil;
    }];
    // get navigation bar
    [self registerHandler:@"setPageTitle"
                  handler:^(id _Nonnull data, QYCWebBridgeResponseCallback _Nonnull responseCallback) {
        @strongify(self);
        NSDictionary *response = data;
        NSString *title            = response[@"title"];
        if (title) {
            self.navigationItem.title = title;
        }
    }];
}

- (void)showShareMenuViewWithData:(NSDictionary *)data {
    UMSocialShareUIConfig *config                                = [UMSocialShareUIConfig shareInstance];
    config.shareContainerConfig.shareContainerBackgroundColor    = KQYCColor(ffffff, 2f2f2f);
    config.shareContainerConfig.shareContainerGradientStartColor = KQYCColor(ffffff, 2f2f2f);
    config.shareContainerConfig.shareContainerGradientEndColor   = KQYCColor(ffffff, 2f2f2f);

    config.sharePageScrollViewConfig.shareScrollViewBackgroundColor = KQYCColor(ffffff, 2f2f2f);
    config.sharePageScrollViewConfig.shareScrollViewPageBGColor     = KQYCColor(ffffff, 2f2f2f);

    config.shareTitleViewConfig.shareTitleViewBackgroundColor = KQYCColor(ffffff, 2f2f2f);
    config.shareTitleViewConfig.shareTitleViewTitleColor      = KQYCColor(333333, c4c4c4);

    config.shareCancelControlConfig.shareCancelControlBackgroundColor = KQYCColor(ffffff, 2f2f2f);
    config.shareCancelControlConfig.shareCancelControlTextColor       = KQYCColor(333333, c4c4c4);

    config.sharePlatformItemViewConfig.sharePlatformItemViewPlatformNameColor = KQYCColor(333333, c4c4c4);

    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self getUserInfoForPlatform:platformType withModel:data];
    }];
}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType withModel:(NSDictionary *)model {
    //responseData格式： { url: String, title: String, desc: String, imageUrl: String }
    NSString *url      = model[@"url"];
    NSString *title    = model[@"title"];
    NSString *desc     = model[@"desc"];
    NSString *imageUrl = model[@"imageUrl"];

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    //设置文本
    messageObject.text  = desc;
    messageObject.title = title;

    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:imageUrl];
    shareObject.webpageUrl            = url;
    messageObject.shareObject         = shareObject;

    [self shareToPlatformType:platformType messageObject:messageObject];
}

- (void)shareToPlatformType:(UMSocialPlatformType)platformType messageObject:messageObject {
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType
                                        messageObject:messageObject
                                currentViewController:self
                                           completion:^(id data, NSError *error) {
                                               NSString *message = nil;
                                               if (!error) {
                                                   message = [NSString stringWithFormat:@"分享成功"];
                                               }
                                               else {
                                                   if ((int)error.code == UMSocialPlatformErrorType_Cancel) {
                                                       message = [NSString stringWithFormat:@"取消分享"];
                                                   }
                                                   else {
                                                       message = [NSString stringWithFormat:@"分享失败"];
                                                   }
                                               }
                                               [QYCToast showToastWithMessage:message type:QYCToastTypeDefault];
                                           }];
}

@end
