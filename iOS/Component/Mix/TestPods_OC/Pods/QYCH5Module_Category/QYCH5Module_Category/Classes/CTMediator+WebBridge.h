//
//  CTMediator+WebBridge.h
//  Qiyeyun
//
//  Created by 漆家佳 on 2020/10/30.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (WebBridge)

/**
 打开网页
 @param type 默认打开LinkWebViewController
          1  打开QYCAppStoreViewController
          2  打开QYCChartsBoardViewController
          3  打开QYCChartsH5ViewController
          4  打开QYCLinkAppWebViewController
          5  打开QYCNavigateWebViewController
 */
- (UIViewController *)mediator_openWebType:(NSInteger)type
                                       url:(NSString *)url
                                     entId:(nullable NSString *)entId
                                canRefresh:(BOOL)canRefresh
                              closeBounces:(BOOL)closeBounces
                                   cookies:(nullable NSArray<NSHTTPCookie *> *)cookies;

/**
 展示全局搜索结果页
 @param entId
 @param keywords
 @param categoryType
 @param cookies
 */
/*
- (UIViewController *)mediator_showGlobalSearchResultWithEntId:(NSString *)entId
                                                      keywords:(NSString *)keywords
                                                  categoryType:(NSString *)categoryType
                                                       cookies:(nullable NSArray<NSHTTPCookie *> *)cookies;
*/

/**
 打开支付页面
 @param url
 @param orderId
 @param priceValue
 @param merchant
 @param notifyUrl
 @param merchantName
 @param cookies
 @param callBack
 */
- (UIViewController *)mediator_openPayViewControllerWithUrl:(NSString *)url
                                                    orderId:(NSString *)orderId
                                                 priceValue:(NSString *)priceValue
                                                   merchant:(NSString *)merchant
                                                  notifyUrl:(NSString *)notifyUrl
                                               merchantName:(NSString *)merchantName
                                                    cookies:(nullable NSArray<NSHTTPCookie *> *)cookies
                                                   callBack:(void (^)(id data))callBack;

/**
 vc  控制器
 其他 控制被赋予的值
 */
- (void)mediator_setValueForH5ViewController:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
