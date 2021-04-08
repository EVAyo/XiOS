//
//  CTMediator+QYCBlueToothModuleActions.h
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/11/2.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (QYCBlueToothModuleActions)

/// 进入蓝牙主页
/// @param isFromH5
/// @param callBack
- (UIViewController *)mediator_bluetoothVCFromH5:(BOOL)isFromH5 callBack:(nullable void (^)(id result))callBack;

/// 获取当前蓝牙状态
/// @return 状态
- (BOOL)mediator_bluetoothIsOpen;

@end

NS_ASSUME_NONNULL_END
