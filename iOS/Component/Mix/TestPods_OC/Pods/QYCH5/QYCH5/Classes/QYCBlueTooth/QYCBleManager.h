//
//  QYCBleManager.h
//  Qiyeyun
//
//  Created by AYKJ on 2020/7/31.
//  Copyright © 2020 安元. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIKit.h>

/**
 连接设备状态
 */
typedef NS_ENUM(NSUInteger, ConnectPeripheralState) {
    ConnectPeripheralStateSuccess, /**< 连接设备成功 */
    ConnectPeripheralStateFailed,  /**< 连接设备失败 */
};

typedef void (^FilterOnDiscoverToPeripheralBlock)(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI);

typedef void (^BluetoothConnectResults)(CGFloat sensitive, CGFloat acceleration, CGFloat speed, CGFloat displacement, CGFloat temperature);

@interface QYCBleManager : NSObject

/**
当前连接的外设

@return 单例对象
*/
@property (nonatomic, strong) CBPeripheral *currentPeripheral;

/**
 单例管理对象

 @return 单例对象
 */
+ (instancetype)sharedManager;

/**
 蓝牙状态block
 */
@property (nonatomic, copy) void (^centralManagerStateBlock)(NSInteger state);

/**
 连接设备状态block
 */
@property (nonatomic, copy) void (^connectPeripheralStateBlock)(ConnectPeripheralState state);

/**
 设备断开连接block
 */
@property (nonatomic, copy) void (^disconnectPeripheralBlock)(void);

/**
 发现蓝牙外设block
 */
@property (nonatomic, copy) FilterOnDiscoverToPeripheralBlock discoverPeripheralBlock;

/**
 蓝牙获取结果数据block
 */
@property (nonatomic, copy) BluetoothConnectResults bluetoothConnectResult;

/**
 连接蓝牙外设蓝牙外设block
 */
- (void)connectPeripheralInfo:(CBPeripheral *)peripheral;

/**
 开始蓝牙扫描
 */
- (void)startBLEScan;

/**
 取消蓝牙扫描和连接
 */
- (void)stopBleConnect;

/**
 重连设备
 */
- (void)reconnectPeriphrral;

@end
