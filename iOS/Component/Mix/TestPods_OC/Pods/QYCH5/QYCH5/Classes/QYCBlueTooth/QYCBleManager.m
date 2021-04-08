//
//  QYCBleManager.m
//  Qiyeyun
//
//  Created by AYKJ on 2020/7/31.
//  Copyright © 2020 安元. All rights reserved.
//

#import "QYCBleManager.h"
#import <YYCategories/NSString+YYAdd.h>

static NSString *const KUUID_SERVICE          = @"FFF0";
static NSString *const KCharacter_WRITE_UUID  = @"FFF2";
static NSString *const KCharacter_NOTIFY_UUID = @"FFF1";

//扫描连接设备超时时间
static const NSInteger ConnectDeviceTimeout = 30;

@interface QYCBleManager () <CBCentralManagerDelegate, CBPeripheralDelegate> {
    //扫描连接设备定时器
    NSTimer *_connectDeviceTimer;
    //计时秒数
    NSInteger _connectDeviceCount;
}

//蓝牙管理
@property (nonatomic, strong) CBCentralManager *centralManager;

@end

@implementation QYCBleManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static QYCBleManager *bleManager;
    dispatch_once(&onceToken, ^{
        bleManager = [[QYCBleManager alloc] init];
    });
    return bleManager;
}

#pragma mark - 蓝牙操作

/**
 开始蓝牙扫描
 */
- (void)startBLEScan {
    //先取消扫描和连接
    [self stopBleConnect];
    //设置蓝牙中心代理，扫描设备
    self.centralManager          = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    self.centralManager.delegate = self;
}

/**
 取消蓝牙扫描和连接
 */
- (void)stopBleConnect {
    //取消蓝牙连接
    if (self.centralManager) {
        [self.centralManager stopScan];
        if (self.currentPeripheral) {
            [self cancelNotifyValue:self.centralManager peripheral:self.currentPeripheral];
            [self.centralManager cancelPeripheralConnection:self.currentPeripheral];

            self.currentPeripheral.delegate = nil;
            self.currentPeripheral          = nil;
        }
        self.centralManager.delegate = nil;
        self.centralManager          = nil;
    }
    //关闭定时器
    [self stopConnectDeviceTimer];
}

/**
 重连设备
 */
- (void)reconnectPeriphrral {
    _connectDeviceCount = 0;
    [self startBLEScan];
}

#pragma mark - 蓝牙连接代理  搜索扫描外围设备
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    //判断蓝牙状态
    if (central.state == CBCentralManagerStatePoweredOn) {
        if (self.currentPeripheral == nil && _connectDeviceCount != ConnectDeviceTimeout) {
            //开始扫描所有的设备 （Services为空）
            [self.centralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @NO}];
            //开始连接定时器
            [self startConnectDeviceTimer];
            if (self.centralManagerStateBlock) {
                self.centralManagerStateBlock(central.state);
            }
        }
    }
    else if (central.state == CBCentralManagerStatePoweredOff) {
        //蓝牙关闭状态
        [self.centralManager stopScan];
        if (self.centralManagerStateBlock) {
            self.centralManagerStateBlock(central.state);
        }
    }
    else if (central.state == CBCentralManagerStateUnauthorized) {
        //未经用户授权 调用scan方法会请求用户权限
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
        if (self.centralManagerStateBlock) {
            self.centralManagerStateBlock(central.state);
        }
    }
    else if (central.state == CBCentralManagerStateUnsupported) {
        //资源释放
        [self.centralManager stopScan];
        self.centralManager.delegate = nil;
        self.centralManager          = nil;
        if (self.centralManagerStateBlock) {
            self.centralManagerStateBlock(central.state);
        }
    }
    else if (central.state == CBCentralManagerStateResetting) {
        NSLog(@"蓝牙连接超时");
    }
}

#pragma mark 发现外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSString *peripheralName = peripheral.name;
    NSLog(@"扫描到设备peripheralName : %@", peripheralName);

    if (self.discoverPeripheralBlock && [peripheralName isNotBlank]) {
        if ([peripheralName isEqualToString:@"VS2T3"] || [peripheralName isEqualToString:@"VS2T4"]) {
            //            self.currentPeripheral = peripheral;
            self.discoverPeripheralBlock(central, peripheral, advertisementData, RSSI);
        }
    }
}

- (void)connectPeripheralInfo:(CBPeripheral *)peripheral {
    //连接设备
    [self.centralManager connectPeripheral:peripheral options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
    //停止扫描
    [self.centralManager stopScan];
}

#pragma mark 连接外设--成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    //关闭定时器
    [self stopConnectDeviceTimer];
    //连接设备成功
    if (self.connectPeripheralStateBlock) {
        [QYCBleManager sharedManager].currentPeripheral = peripheral;
        self.connectPeripheralStateBlock(ConnectPeripheralStateSuccess);
    }
    //设置设备代理
    peripheral.delegate = self;
    //搜索服务
    CBUUID *serviceID = [CBUUID UUIDWithString:KUUID_SERVICE];
    [peripheral discoverServices:@[ serviceID ]];
    //    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"连接失败");
    //取消订阅
    [self cancelNotifyValue:central peripheral:peripheral];
    //取消扫面和连接
    [self stopBleConnect];
    //关闭定时器
    [self stopConnectDeviceTimer];
    //UI显示 蓝牙连接失败
    if (self.connectPeripheralStateBlock) {
        self.connectPeripheralStateBlock(ConnectPeripheralStateFailed);
    }
}

/**
 取消特征订阅
 
 @param centralManager 中心管理器
 @param peripheral 外部设备
 */
- (void)cancelNotifyValue:(CBCentralManager *)centralManager peripheral:(CBPeripheral *)peripheral {
    if (peripheral.state != CBPeripheralStateConnected) {
        return;
    }
    if (peripheral.services != nil) {
        for (CBService *service in peripheral.services) {
            if (service.characteristics != nil) {
                for (CBCharacteristic *characteristic in service.characteristics) {
                    if (characteristic.isNotifying) {
                        [peripheral setNotifyValue:NO forCharacteristic:characteristic];
                    }
                }
            }
        }
    }
    [centralManager cancelPeripheralConnection:peripheral];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"断开蓝牙连接");
    if (self.disconnectPeripheralBlock) {
        self.disconnectPeripheralBlock();
    }
}

#pragma mark - 蓝牙数据获取 CBPeripheralDelegate
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (error) {
        NSLog(@"获取服务失败");
        NSString *noticeStr = [NSString stringWithFormat:@"读取service失败 : %@", error.localizedDescription];
        //取消订阅
        [self cancelNotifyValue:self.centralManager peripheral:peripheral];
        return;
    }

    //扫描到了服务,且服务只有一个 FFF0
    for (CBService *service in peripheral.services) {
        NSArray *characterArray = @[ [CBUUID UUIDWithString:KCharacter_WRITE_UUID], [CBUUID UUIDWithString:KCharacter_NOTIFY_UUID] ];
        [peripheral discoverCharacteristics:characterArray forService:service];
        NSLog(@"获取service==%@", service.UUID);
    }
}

/**
发现特征后，可以根据特征的properties进行：读readValueForCharacteristic、写writeValue、订阅通知setNotifyValue、扫描特征的描述discoverDescriptorsForCharacteristic。
 **/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        NSLog(@"扫描特征值失败");
        NSLog(@"error : %@", error.description);
        //取消订阅
        [self cancelNotifyValue:self.centralManager peripheral:peripheral];
        //释放资源
        [self.centralManager stopScan];
        self.centralManager.delegate = nil;
        self.centralManager          = nil;
    }

    for (CBCharacteristic *character in service.characteristics) {
        if ([character.UUID.UUIDString isEqualToString:KCharacter_NOTIFY_UUID]) {
            [peripheral setNotifyValue:YES forCharacteristic:character];
        }
        else if ([character.UUID.UUIDString isEqualToString:KCharacter_WRITE_UUID]) {
            NSData *sendData = [self getSendData];
            [peripheral writeValue:sendData forCharacteristic:character type:CBCharacteristicWriteWithResponse];
        }
    }

    //扫描特征值成功
    //    for (CBCharacteristic *characteristic in service.characteristics) {
    //        NSLog(@"service:%@ ----characteristic:%@", service.UUID, characteristic.UUID);
    //
    //        //        if ([characteristic.UUID.UUIDString isEqualToString:KCharacter_WRITE]) {
    //        //            NSData *sendData = [self getSendData];
    //        //            [self.currentPeripheral writeValue:sendData forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    //        //        }
    //
    //        //扫描描述
    //        [peripheral discoverDescriptorsForCharacteristic:characteristic];
    //        //读取特征的内容 value
    //        [peripheral readValueForCharacteristic:characteristic];
    //        //开启特征的订阅
    //        [peripheral setNotifyValue:true forCharacteristic:characteristic];
    //    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"扫描描述失败");
    }
    for (CBDescriptor *descriptor in characteristic.descriptors) {
        //读取描述内容
        NSLog(@"描述 : %@", descriptor.description);
        [peripheral readValueForDescriptor:descriptor];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    //显示CBDescriptor 的UUID和value
    NSLog(@"描述内容:uuid:%@,value:%@", descriptor.UUID, descriptor.value);
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (peripheral == self.currentPeripheral && characteristic.value.length > 0) {
        //        NSData *data = characteristic.value;
        //        NSLog(@"characteristic内容:%@,value:%@", characteristic.value);
        // 0xbb000da1f201ee0001000000023ac84d

        [self readCharacteristicValue:characteristic.value];
    }
}

#pragma mark - 连接设备定时器
//开启扫描连接设备定时器
- (void)startConnectDeviceTimer {
    if (!_connectDeviceTimer) {
        _connectDeviceCount = 0;
        _connectDeviceTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(connectDeviceTimerTask) userInfo:nil repeats:YES];
    }
}

//扫描连接设备定时器任务
- (void)connectDeviceTimerTask {
    _connectDeviceCount++;
    if (_connectDeviceCount >= ConnectDeviceTimeout) {
        //停止扫描
        [self.centralManager stopScan];
        //关闭定时器
        [self stopConnectDeviceTimer];
        //连接设备失败
        if (self.connectPeripheralStateBlock) {
            self.connectPeripheralStateBlock(ConnectPeripheralStateFailed);
        }
    }
}

//停止扫描连接设备定时器
- (void)stopConnectDeviceTimer {
    if (_connectDeviceTimer && [_connectDeviceTimer isValid]) {
        [_connectDeviceTimer invalidate];
        _connectDeviceTimer = nil;
    }
}

#pragma mark - 蓝牙数据发送
- (NSData *)getSendData {
    //前导码
    Byte lead = 0xbb;
    //长度码
    Byte length1 = 0x00;
    Byte length2 = 0x02;
    //命令码
    Byte command = 0xa1;
    //校验码
    Byte check = 0xa1;

    NSMutableData *mutableData = [NSMutableData data];
    [mutableData appendBytes:&lead length:1];
    [mutableData appendBytes:&length1 length:1];
    [mutableData appendBytes:&length2 length:1];
    [mutableData appendBytes:&command length:1];
    [mutableData appendBytes:&check length:1];

    return mutableData;
}

#pragma mark - 蓝牙数据解析
/**
 读取解析蓝牙通讯接收到的数据
 
 @param value 通讯数据
 */
- (void)readCharacteristicValue:(NSData *)value {
    NSLog(@"==value== : %@", value);
    Byte *byteArray = (Byte *)[value bytes];

    //    bb 00 0d a1 f1 01 ee 00 00 00 00 00 01 3a db 5f
    //校验数据有效性
    if (byteArray[0] == 0xbb && byteArray[3] == 0xa1) {
        //灵敏度值
        CGFloat sensitive = [self obtainParamesMCUResponse:byteArray[5] withEnd:byteArray[6]] * 100;

        //加速度值
        CGFloat acceleration = [self obtainParamesMCUResponse:byteArray[7] withEnd:byteArray[8]] * 10;

        //速度值
        CGFloat speed = [self obtainParamesMCUResponse:byteArray[9] withEnd:byteArray[10]] * 10;

        //位移值/震动
        CGFloat displacement = [self obtainParamesMCUResponse:byteArray[11] withEnd:byteArray[12]] * 10;

        //温度值
        CGFloat temperature = [self obtainParamesMCUResponse:byteArray[13] withEnd:byteArray[14]] * 0.02 - 273.15;

        if (self.bluetoothConnectResult) {
            self.bluetoothConnectResult(sensitive, acceleration, speed, displacement, temperature);
        }
    }
}

- (NSInteger)obtainParamesMCUResponse:(Byte)start withEnd:(Byte)end {
    NSInteger startValue = (start)&0xff;
    NSInteger endValue   = (end)&0xff;
    NSString *response   = [NSString stringWithFormat:@"%ld%ld", startValue, endValue];
    return [response integerValue];
}

//- (NSString *)convertDataToHexStr:(NSData *)data {
//    if (!data || [data length] == 0) {
//        return @"";
//    }
//    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
//
//    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
//        unsigned char *dataBytes = (unsigned char *)bytes;
//        for (NSInteger i = 0; i < byteRange.length; i++) {
//            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
//            if ([hexStr length] == 2) {
//                [string appendString:hexStr];
//            }
//            else {
//                [string appendFormat:@"0%@", hexStr];
//            }
//        }
//    }];
//
//    return string;
//}

@end
