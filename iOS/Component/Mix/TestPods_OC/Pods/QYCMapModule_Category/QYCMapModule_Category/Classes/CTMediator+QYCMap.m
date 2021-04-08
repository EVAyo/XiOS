//
//  CTMediator+QYCMap.m
//  Qiyeyun
//
//  Created by 漆家佳 on 2020/11/18.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator+QYCMap.h"
NSString *const QYCMediatorTargetQYCMap                      = @"QYCMap";
NSString *const kMediatorActionOpenPreViewLocationVC         = @"openPreViewLocationVC";
NSString *const kMediatorActionOpenMapLocationViewController = @"openMapLocationViewController";
NSString *const kMediatorActionStartBaiDuEngine              = @"startBaiDuEngine";
NSString *const kMediatorActionLocationInfo                  = @"locationInfo";

@implementation CTMediator (QYCMap)
/**
 打开地图详情
 */
- (UIViewController *)mediator_openPreViewLocationVCWithAddess:(NSString *)addess
                                                      latitude:(NSString *)latitude
                                                     longitude:(NSString *)longitude {
    NSDictionary *param              = @{@"name" : addess ?: @"",
                            @"longitude" : longitude ?: @"",
                            @"latitude" : latitude ?: @""};
    UIViewController *viewController = [self performTarget:QYCMediatorTargetQYCMap
                                                    action:kMediatorActionOpenPreViewLocationVC
                                                    params:param
                                         shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        //返回生成目标控制器，由外部调用
        return viewController;
    }
    else {
        //处理异常场景
        NSLog(@"======CTMediator+QYCMap.h======执行返回结果有误======");
        return nil;
    }
}
/**
 选择定位位置信息
 */
- (UIViewController *)mediator_openMapLocationViewControllerType:(NSInteger)type
                                                        latitude:(NSString *)latitude
                                                       longitude:(NSString *)longitude
                                                        callBack:(void (^)(NSDictionary *_Nonnull))callBack {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"mapType"]          = [NSNumber numberWithInteger:type];
    param[@"latitude"]         = latitude;
    param[@"longitude"]        = longitude;
    if (callBack) {
        param[@"callBack"] = callBack;
    }
    UIViewController *viewController = [self performTarget:QYCMediatorTargetQYCMap
                                                    action:kMediatorActionOpenMapLocationViewController
                                                    params:param
                                         shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        //返回生成目标控制器，由外部调用
        return viewController;
    }
    else {
        //处理异常场景
        NSLog(@"======CTMediator+QYCMap.h======执行返回结果有误======");
        return nil;
    }
}

- (void)mediator_startBaiDuEngine {
    [self performTarget:QYCMediatorTargetQYCMap
                   action:kMediatorActionStartBaiDuEngine
                   params:nil
        shouldCacheTarget:NO];
}

- (void)mediator_locationInfo:(void (^)(NSString *address, NSUInteger error))locationInfo {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    if (locationInfo) {
        [params setValue:locationInfo forKey:@"locationInfo"];
    }
    [self performTarget:QYCMediatorTargetQYCMap
                   action:kMediatorActionLocationInfo
                   params:params
        shouldCacheTarget:NO];
}
@end
