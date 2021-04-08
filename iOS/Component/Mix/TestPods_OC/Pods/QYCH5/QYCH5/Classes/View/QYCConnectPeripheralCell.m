//
//  QYCBlePeripheralCell.m
//  Qiyeyun
//
//  Created by AYKJ on 2020/8/12.
//  Copyright © 2020 安元. All rights reserved.
//

#import "QYCConnectPeripheralCell.h"
#import "QYCH5Config.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <Masonry/Masonry.h>
#import <QYCCategory/UIColor+QYCColor.h>
#import <QYCCategory/UIImage+Image.h>
#import <YYCategories/UIColor+YYAdd.h>

@interface QYCConnectPeripheralCell ()

/// 名称
@property (nonatomic, strong) UILabel *nameLabel;

/// 资料信息
@property (nonatomic, strong) UILabel *infoLabel;

/// 连接按钮
@property (nonatomic, strong) UIButton *operationBtn;

@end

@implementation QYCConnectPeripheralCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self setupSubViews];
    }
    return self;
}

- (void)loadConfigureData:(NSDictionary *)dict {
    CBPeripheral *peripheral        = [dict objectForKey:@"peripheral"];
    NSDictionary *advertisementData = [dict objectForKey:@"advertisementData"];
    NSNumber *RSSI                  = [dict objectForKey:@"RSSI"];

    //peripheral的显示名称,优先用kCBAdvDataLocalName的定义，若没有再使用peripheral name
    NSString *peripheralName;
    if ([advertisementData objectForKey:@"kCBAdvDataLocalName"]) {
        peripheralName = [NSString stringWithFormat:@"%@", [advertisementData objectForKey:@"kCBAdvDataLocalName"]];
    }
    else if (!([peripheral.name isEqualToString:@""] || peripheral.name == nil)) {
        peripheralName = peripheral.name;
    }
    else {
        peripheralName = [peripheral.identifier UUIDString];
    }

    self.nameLabel.text = peripheralName;
    self.infoLabel.text = [NSString stringWithFormat:@"RSSI:%@", RSSI];
}

- (void)setupSubViews {
    UIImageView *iconImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"H5_shebei" aClass:self.class bundle:QYCH5]];
    [self.contentView addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.centerY.mas_equalTo(self.contentView);
    }];

    self.operationBtn                 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.operationBtn.backgroundColor = KQYCColor(f6f7f8, 121212);
    [self.operationBtn setTitle:@"连接" forState:UIControlStateNormal];
    [self.operationBtn setTitleColor:UIColorHex(#4680ff) forState:UIControlStateNormal];
    self.operationBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.operationBtn addTarget:self action:@selector(connectBluetoothClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.operationBtn];
    [self.operationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(70, 32));
    }];
    self.operationBtn.layer.masksToBounds = YES;
    self.operationBtn.layer.cornerRadius  = 5.0f;

    self.nameLabel               = [[UILabel alloc] init];
    self.nameLabel.font          = [UIFont systemFontOfSize:15.0f];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.text          = @"";
    self.nameLabel.textColor     = KQYCColor(333333, c4c4c4);
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImageV.mas_right).offset(8);
        make.right.mas_equalTo(self.operationBtn.mas_left).offset(-10);
        make.top.mas_equalTo(iconImageV);
        make.height.offset(20);
    }];

    self.infoLabel               = [[UILabel alloc] init];
    self.infoLabel.font          = [UIFont systemFontOfSize:13.0f];
    self.infoLabel.numberOfLines = 0;
    self.infoLabel.text          = @"";
    self.infoLabel.textColor     = KQYCColor(666666, a0a0a0);
    [self.contentView addSubview:self.infoLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImageV.mas_right).offset(8);
        make.right.mas_equalTo(self.operationBtn.mas_left).offset(-10);
        make.bottom.mas_equalTo(iconImageV);
        make.height.offset(18);
    }];
}

- (void)connectBluetoothClick {
    if (self.connectBluetoothBlock) {
        self.connectBluetoothBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
