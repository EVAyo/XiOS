//
//  QYCH5Config.h
//  Qiyeyun
//
//  Created by 启业云03 on 2020/12/2.
//  Copyright © 2020 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

#define QYCH5 @"QYCH5"

//屏幕的大小
#define HEIGHT_H5 [UIScreen mainScreen].bounds.size.height
#define WIDTH_H5 [UIScreen mainScreen].bounds.size.width

//判断是否是iPhone X系列
static inline BOOL iphoneX_H5() {
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return NO;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            return YES;
        }
    }
    return NO;
}

//状态栏加导航栏的高度
static inline CGFloat getNavBarHeight_H5() {
    if (iphoneX_H5()) {
        return 88;
    }
    return 64;
}

//相比其他机型，iPhoneX底部tabbar增加的高度
static inline CGFloat stateIncrement_H5() {
    if (iphoneX_H5()) {
        return 34;
    }
    return 0;
}

#pragma mark - ================ URL =================

/**
 * 根据长域名转换成短域名
 *
 * POST :  根据长链接生成并保存短链接
 * GET   :  根据短链接获取长链接
 */
UIKIT_EXTERN NSString *const API_H5_QYC_QRShortToLongURL;
UIKIT_EXTERN NSString *const API_H5_QYC_QRShortToLongURL_New;

// 获取数据源信息
UIKIT_EXTERN NSString *const API_H5_GetDataSource;

// “@我的”中的讨论内容
UIKIT_EXTERN NSString *const API_H5_InfoCentre_discussPosts;
