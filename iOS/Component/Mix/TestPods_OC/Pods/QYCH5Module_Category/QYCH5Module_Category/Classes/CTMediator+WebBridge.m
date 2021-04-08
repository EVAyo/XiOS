//
//  CTMediator+WebBridge.m
//  Qiyeyun
//
//  Created by 漆家佳 on 2020/10/30.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator+WebBridge.h"
///Target源
NSString *const kMediatorTargetWebBridge = @"WebBridge";

/////执行方法名

NSString *const kMediatorActionOpenH5WebViewController = @"openH5WebViewController";

NSString *const kMediatorActionShowGlobalSearchResult = @"showGlobalSearchResult";

NSString *const kMediatorActionSetValueForH5ViewController = @"setValueForH5ViewController";

@implementation CTMediator (WebBridge)
/**
 @param type 默认打开LinkWebViewController(1-5以外的数字)
          1  打开QYCAppStoreViewController
          2  打开QYCChartsBoardViewController
          3  打开QYCChartsH5ViewController
          4  打开QYCLinkAppWebViewController
          5  打开QYCNavigateWebViewController
 */
- (UIViewController *)mediator_openWebType:(NSInteger)type
                                       url:(NSString *)url
                                     entId:(NSString *)entId
                                canRefresh:(BOOL)canRefresh
                              closeBounces:(BOOL)closeBounces
                                   cookies:(NSArray<NSHTTPCookie *> *)cookies {
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{@"url" : url ?: @"",
                                                                                   @"entId" : entId ?: @"",
                                                                                   @"canRefresh" : [NSNumber numberWithBool:canRefresh],
                                                                                   @"closeBounces" : [NSNumber numberWithBool:closeBounces],
                                                                                   @"type" : [NSNumber numberWithInteger:type]}];
    if (cookies.count)
        param[@"cookies"] = cookies;

    UIViewController *viewController = [self performTarget:kMediatorTargetWebBridge
                                                    action:kMediatorActionOpenH5WebViewController
                                                    params:param
                                         shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        //返回生成目标控制器，由外部调用
        return viewController;
    }
    else {
        //处理异常场景
        NSLog(@"======CTMediator+WebBridge.h======执行返回结果有误======");
        return [self unifiedExceptionVC];
    }
}

/*
- (UIViewController *)mediator_showGlobalSearchResultWithEntId:(NSString *)entId
                                                      keywords:(NSString *)keywords
                                                  categoryType:(NSString *)categoryType
                                                       cookies:(NSArray<NSHTTPCookie *> *)cookies {
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{@"entId" : entId ?: @"",
                                                                                   @"keywords" : keywords ?: @"",
                                                                                   @"categoryType" : categoryType ?: @""}];
    if (cookies.count)
        param[@"cookies"] = cookies;

    UIViewController *viewController = [self performTarget:kMediatorTargetWebBridge
                                                    action:kMediatorActionShowGlobalSearchResult
                                                    params:param
                                         shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        //返回生成目标控制器，由外部调用
        return viewController;
    }
    else {
        //处理异常场景
        NSLog(@"======CTMediator+WebBridge.h======执行返回结果有误======");
        return nil;
    }
}
 */

- (UIViewController *)mediator_openPayViewControllerWithUrl:(NSString *)url
                                                    orderId:(NSString *)orderId
                                                 priceValue:(NSString *)priceValue
                                                   merchant:(NSString *)merchant
                                                  notifyUrl:(NSString *)notifyUrl
                                               merchantName:(NSString *)merchantName
                                                    cookies:(NSArray<NSHTTPCookie *> *)cookies
                                                   callBack:(void (^)(id _Nonnull))callBack {
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{
        @"url" : url ?: @"",
        @"orderId" : orderId ?: @"",
        @"priceValue" : priceValue ?: @"",
        @"merchant" : merchant ?: @"",
        @"notifyUrl" : notifyUrl ?: @"",
        @"merchantName" : merchantName ?: @"",
    }];
    if (cookies.count)
        param[@"cookies"] = cookies;
    if (callBack)
        param[@"callBack"] = callBack;

    UIViewController *viewController = [self performTarget:kMediatorTargetWebBridge
                                                    action:kMediatorActionShowGlobalSearchResult
                                                    params:param
                                         shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        //返回生成目标控制器，由外部调用
        return viewController;
    }
    else {
        //处理异常场景
        NSLog(@"======CTMediator+WebBridge.h======执行返回结果有误======");
        return [self unifiedExceptionVC];
    }
}
- (void)mediator_setValueForH5ViewController:(NSDictionary *)params {
    [self performTarget:kMediatorTargetWebBridge
                   action:kMediatorActionSetValueForH5ViewController
                   params:params
        shouldCacheTarget:NO];
}

@end
