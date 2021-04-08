//
//  CTMediator+QYCBlueToothModuleActions.m
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/11/2.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator+QYCBlueToothModuleActions.h"

NSString *const kQYCMediatorTargetBlueToothModule = @"BlueToothModule";

NSString *const kQYCMediatorActionbluetoothVC = @"bluetoothVC";

NSString *const kQYCMediatorActionbluetoothIsOpen = @"bluetoothIsOpen";

@implementation CTMediator (QYCBlueToothModuleActions)

- (UIViewController *)mediator_bluetoothVCFromH5:(BOOL)isFromH5 callBack:(void (^)(id _Nonnull))callBack {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"isFromH5"]         = [NSNumber numberWithBool:isFromH5];
    if (callBack) {
        param[@"callBack"] = callBack;
    }
    UIViewController *vc = [self performTarget:kQYCMediatorTargetBlueToothModule action:kQYCMediatorActionbluetoothVC params:param shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (BOOL)mediator_bluetoothIsOpen {
    id result = [self performTarget:kQYCMediatorTargetBlueToothModule action:kQYCMediatorActionbluetoothIsOpen params:nil shouldCacheTarget:NO];
    return [result boolValue];
}

@end
