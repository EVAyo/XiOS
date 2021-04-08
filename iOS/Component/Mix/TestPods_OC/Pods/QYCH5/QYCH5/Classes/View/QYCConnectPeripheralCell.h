//
//  QYCBlePeripheralCell.h
//  Qiyeyun
//
//  Created by AYKJ on 2020/8/12.
//  Copyright © 2020 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYCConnectPeripheralCell : UITableViewCell

- (void)loadConfigureData:(NSDictionary *)dict;

@property (nonatomic, copy) void (^connectBluetoothBlock)(void);

@end
