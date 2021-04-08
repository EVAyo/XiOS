//
//  Target_WebBridge.m
//  Qiyeyun
//
//  Created by 漆家佳 on 2020/10/30.
//  Copyright © 2020 安元. All rights reserved.
//

#import "Target_WebBridge.h"
#import "LinkWebViewController.h"
#import "QYCAppStoreViewController.h"
#import "QYCChartsBoardViewController.h"
#import "QYCChartsH5ViewController.h"
#import "QYCNavigateWebViewController.h"
#import "QYCPayViewController.h"
@implementation Target_WebBridge

/**
 打开网页
 @param param       1  打开QYCAppStoreViewController （应用市场）
                2  打开QYCChartsBoardViewController（tabbar页面的仪表盘，支持手动刷新Session）
                3  打开QYCChartsH5ViewController（图表页）
                4 / 5  打开QYCNavigateWebViewController（乐高交互页）
                其他：打开LinkWebViewController（WebView容器，无交互）
 */
- (UIViewController *)Action_openH5WebViewController:(NSDictionary *)param {
    NSString *url = param[@"url"] ?: @"";
    if (url.length == 0)
        return nil;
    NSInteger type = [param[@"type"] integerValue];
    UIViewController *tempVC;

    switch (type) {
        case 1: {
            QYCAppStoreViewController *h5VC = [[QYCAppStoreViewController alloc] initWithURLStr:url];
            if (param[@"cookie"]) {
                h5VC.cookies = param[@"cookie"];
            }
            else {
                NSURL *tempURL       = [NSURL URLWithString:url];
                NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:@{
                    NSHTTPCookieName : @"isApp",
                    NSHTTPCookieValue : @"1",
                    NSHTTPCookieDomain : tempURL.host,
                    NSHTTPCookiePath : @"/",
                }];
                h5VC.cookies         = @[ cookie ];
            }
            tempVC = h5VC;
        } break;
        case 2: {
            QYCChartsBoardViewController *h5VC = [[QYCChartsBoardViewController alloc] initWithURLStr:url];
            h5VC.canRefresh                    = [param[@"canRefresh"] boolValue];
            tempVC                             = h5VC;
        } break;
        case 3: {
            QYCChartsH5ViewController *h5VC = [[QYCChartsH5ViewController alloc] initWithURLStr:url];
            h5VC.qyc_entId                  = param[@"entId"] ?: @"";
            tempVC                          = h5VC;
        } break;
        case 4: {
            //拼接http前缀
            if (![url hasPrefix:@"http"]) {
                url = [NSString stringWithFormat:@"http://%@", url];
            }
            QYCNavigateWebViewController *h5VC = [[QYCNavigateWebViewController alloc] initWithURLStr:url];
            h5VC.qyc_entId                    = param[@"entId"] ?: @"";
            h5VC.closeBounces                 = [param[@"closeBounces"] boolValue];
            tempVC                            = h5VC;
        } break;
        case 5: {
            //拼接http前缀
            if (![url hasPrefix:@"http"]) {
                url = [NSString stringWithFormat:@"http://%@", url];
            }
            QYCNavigateWebViewController *h5VC = [[QYCNavigateWebViewController alloc] initWithURLStr:url];
            h5VC.closeBounces                  = [param[@"closeBounces"] boolValue];
            h5VC.qyc_entId                     = param[@"entId"] ?: @"";
            tempVC                             = h5VC;
        } break;
        default: {
            LinkWebViewController *vc = [[LinkWebViewController alloc] init];
            //拼接http前缀
            if (![url hasPrefix:@"http"]) {
                url = [NSString stringWithFormat:@"http://%@", url];
            }
            vc.url = [NSURL URLWithString:url];
            tempVC = vc;
        } break;
    }
    return tempVC;
}

/**
 key  value
 
 vc   控制器
 其他  控制需要被赋的值
 */
- (void)Action_setValueForH5ViewController:(NSDictionary *)param {
    UIViewController *vc = param[@"vc"];
    if ([vc isKindOfClass:QYCBaseWebViewController.class]) {
        QYCBaseWebViewController *tempVC = (QYCBaseWebViewController *)vc;
        [tempVC setValuesForKeysWithDictionary:param];
    }
}

- (UIViewController *)Action_openPayViewController:(NSDictionary *)param {
    NSDictionary *payParams = @{tradeNumberKey : param[@"orderId"] ?: @"",
                                tradeAmountKey : param[@"priceValue"] ?: @"",
                                tradeMerchantIdKey : param[@"merchant"] ?: @"",
                                tradeNotifyUrlKey : param[@"notifyUrl"] ?: @"",
                                tradeMerchantNameKey : param[@"merchantName"] ?: @""};

    QYCPayViewController *pay = [[QYCPayViewController alloc] initWithPayUrlSting:param[@"url"] ?: @"" payParams:payParams];
    pay.cookies               = param[@"cookies"] ?: [self cookies];
    if (param[@"callBack"]) {
        //生命一个block接收入参
        void (^callBack)(id)  = param[@"callBack"];
        pay.PayResultCallback = ^(id _Nonnull data) {
            callBack(data);
        };
        pay.backClickCallback = ^{
            callBack(nil);
        };
    }
    return pay;
}
- (NSArray *)cookies {
    // cookie
    NSHTTPCookieStorage *cookieStorage             = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSMutableArray<NSHTTPCookie *> *sessionCookies = [NSMutableArray array];
    [cookieStorage.cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj.name isEqualToString:@"PHPSESSID"] || [obj.name isEqualToString:@"CURRENT_ENT"]) {
            [sessionCookies addObject:obj];
        }
    }];
    return sessionCookies;
}
@end
