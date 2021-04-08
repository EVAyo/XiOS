//
//  QYCBleConnectVC.m
//  Qiyeyun
//
//  Created by AYKJ on 2020/7/31.
//  Copyright © 2020 安元. All rights reserved.
//

#import "QYCBluetoothConnectVC.h"
#import "QYCBleManager.h"
#import "QYCConnectPeripheralCell.h"
#import "QYCH5Config.h"
// QYC Pods
#import <QYCCategory/UIColor+QYCColor.h>
#import <QYCUI/MBProgressHUD+CZ.h>
#import <QYCUI/QYCToast.h>
// Vendor Pods
#import <Masonry/Masonry.h>

@interface QYCBluetoothConnectVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSources;

@end

@implementation QYCBluetoothConnectVC

#pragma mark - 生命周期
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //设置导航栏点击返回的代理

    if ([QYCBleManager sharedManager].currentPeripheral != nil) {
        CBPeripheral *peripheral = [QYCBleManager sharedManager].currentPeripheral;
        [[QYCBleManager sharedManager] connectPeripheralInfo:peripheral];
    }
    else {
        //开始扫描蓝牙设备
        [[QYCBleManager sharedManager] startBLEScan];
    }

    //蓝牙管理代理
    [self bleManagerBlocks];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.navigationItem.title = @"传感器设备列表";
    self.view.backgroundColor = KQYCColor(ffffff, 1e1e1e);

    [self.view addSubview:self.tableView];
}

#pragma mark 蓝牙管理代理
- (void)bleManagerBlocks {
    __weak typeof(self) weakSelf = self;
    //蓝牙状态block
    [QYCBleManager sharedManager].centralManagerStateBlock = ^(NSInteger state) {
        if (state == CBCentralManagerStatePoweredOn) {
        }
        else if (state == CBCentralManagerStatePoweredOff) {
            //提示用户打开蓝牙
            [QYCToast showToastWithMessage:@"请打开你的手机蓝牙功能" type:QYCToastTypeWarning];
        }
        else if (state == CBCentralManagerStateUnsupported) {
            //您的手机暂时不支持蓝牙功能
            [QYCToast showToastWithMessage:@"您的手机不支持蓝牙功能" type:QYCToastTypeWarning];
        }
    };

    [QYCBleManager sharedManager].discoverPeripheralBlock = ^(CBCentralManager *_Nonnull central, CBPeripheral *_Nonnull peripheral, NSDictionary *_Nonnull advertisementData, NSNumber *_Nonnull RSSI) {
        [weakSelf insertBluetoothPeripheral:peripheral advertisementData:advertisementData RSSI:RSSI];
    };

    //连接设备状态block
    [QYCBleManager sharedManager].connectPeripheralStateBlock = ^(ConnectPeripheralState state) {
        if (state == ConnectPeripheralStateSuccess) {
        }
        else if (state == ConnectPeripheralStateFailed) {
        }
        [MBProgressHUD hideHUDForView:self.view];
    };
    //设备断开连接block
    [QYCBleManager sharedManager].disconnectPeripheralBlock = ^{
        //返回到连接页面中
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };

    [QYCBleManager sharedManager].bluetoothConnectResult = ^(CGFloat sensitive, CGFloat acceleration, CGFloat speed, CGFloat displacement, CGFloat temperature) {
        CGFloat resultValue = 0;
        if (self.resultType == QYCConnectResultTypeTemperature) {
            resultValue = temperature;
        }
        else if (self.resultType == QYCConnectResultTypeVibration) {
            resultValue = displacement;
        }
        else if (self.resultType == QYCConnectResultTypeAcceleration) {
            resultValue = acceleration;
        }
        else if (self.resultType == QYCConnectResultTypeSpeed) {
            resultValue = speed;
        }
        else if (self.resultType == QYCConnectResultTypeSensitive) {
            resultValue = sensitive;
        }
        else {
            return;
        }
        if (self.BluetoothConnectResult) {
            self.BluetoothConnectResult(resultValue, self.resultType);
        }
        [self.navigationController popViewControllerAnimated:YES];
    };
}

#pragma mark -UIViewController 方法
//插入table数据
- (void)insertBluetoothPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSArray *peripherals = [self.dataSources valueForKey:@"peripheral"];
    if (![peripherals containsObject:peripheral]) {
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *indexPath     = [NSIndexPath indexPathForRow:peripherals.count inSection:0];
        [indexPaths addObject:indexPath];

        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:peripheral forKey:@"peripheral"];
        [dict setValue:RSSI forKey:@"RSSI"];
        [dict setValue:advertisementData forKey:@"advertisementData"];
        [self.dataSources addObject:dict];

        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark -table委托 table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYCConnectPeripheralCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"QYCConnectPeripheralCell"];
    NSDictionary *dict             = [self.dataSources objectAtIndex:indexPath.row];
    [cell loadConfigureData:dict];
    cell.connectBluetoothBlock = ^{
        [MBProgressHUD showMessage:@"正在连接中..." toView:self.view];
        CBPeripheral *peripheral = [dict objectForKey:@"peripheral"];
        [[QYCBleManager sharedManager] connectPeripheralInfo:peripheral];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma mark--------------------------- Getter And Setter -----------------------------------
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, getNavBarHeight_H5(), WIDTH_H5, HEIGHT_H5 - getNavBarHeight_H5()) style:UITableViewStylePlain];
        _tableView.backgroundColor = KQYCColor(f6f7f8, 121212);
        // delegate
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        // 解决tableview上按钮点击效果的延迟现象
        _tableView.delaysContentTouches = NO;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; ///< 不计算内边距
        }
        else {
            // UIViewController.automaticallyAdjustsScrollViewInsets iOS11过期
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView registerClass:[QYCConnectPeripheralCell class] forCellReuseIdentifier:@"QYCConnectPeripheralCell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataSources {
    if (_dataSources == nil) {
        _dataSources = [[NSMutableArray alloc] init];
    }
    return _dataSources;
}

@end
