//
//  CTMediator+QYCMap.h
//  Qiyeyun
//
//  Created by 漆家佳 on 2020/11/18.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (QYCMap)
/**
 打开地图详情
 */
- (UIViewController *)mediator_openPreViewLocationVCWithAddess:(NSString *)addess
                                                      latitude:(NSString *)latitude
                                                     longitude:(NSString *)longitude;
/**
 选择定位位置信息
 @param type      0表示启聊中使用、1表示工作圈使用、2表示签到使用
 @param callBack  回调
 */
- (UIViewController *)mediator_openMapLocationViewControllerType:(NSInteger)type
                                                        latitude:(nullable NSString *)latitude
                                                       longitude:(nullable NSString *)longitude
                                                        callBack:(nullable void (^)(NSDictionary *result))callBack;

/// 启动百度地图服务和定位引擎
- (void)mediator_startBaiDuEngine;


/// 定位信息
/// @param locationInfo
- (void)mediator_locationInfo:(void(^)(NSString *address, NSUInteger error))locationInfo;


@end

NS_ASSUME_NONNULL_END
