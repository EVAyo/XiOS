//
//  QYCBleConnectVC.h
//  Qiyeyun
//
//  Created by AYKJ on 2020/7/31.
//  Copyright © 2020 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QYCConnectResultType) {
    QYCConnectResultTypeTemperature  = 1, /**< 温度 */
    QYCConnectResultTypeVibration    = 2, /**< 振动/位移 */
    QYCConnectResultTypeAcceleration = 3, /**< 加速度*/
    QYCConnectResultTypeSpeed        = 4, /**< 速度 */
    QYCConnectResultTypeSensitive    = 5  /**< 灵敏度 */
};

@interface QYCBluetoothConnectVC : UIViewController

@property (nonatomic, assign) QYCConnectResultType resultType;

@property (nonatomic, copy) void (^BluetoothConnectResult)(CGFloat resultValue, QYCConnectResultType restltType);

@end
