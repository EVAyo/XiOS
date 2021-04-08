//
//  QYCChartsH5EmptyDataView.m
//  Qiyeyun
//
//  Created by dong on 2018/10/23.
//  Copyright © 2018年 安元. All rights reserved.
//

#import "QYCChartsH5EmptyDataView.h"
#import <Masonry/Masonry.h>
#import <QYCAssets/QYCAssets.h>
#import <QYCCategory/UIColor+QYCColor.h>
#import <YYCategories/UIColor+YYAdd.h>

@interface QYCChartsH5EmptyDataView ()

@property (nonatomic, strong) UIImageView *empty_imageView;
@property (nonatomic, strong) UIButton *reload_btn;

@end

@implementation QYCChartsH5EmptyDataView

#pragma mark - ================ LifeCycle =================

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = KQYCColor(ffffff, 1e1e1e);
        // add subViews
        _empty_imageView = [[UIImageView alloc] init];
        // 公共资源
        _empty_imageView.image = [QYCAssets imageNamed:@"page_loss"];
        [self addSubview:_empty_imageView];
        _reload_btn                    = [UIButton buttonWithType:UIButtonTypeCustom];
        _reload_btn.layer.cornerRadius = 5;
        _reload_btn.layer.borderWidth  = 1;
        _reload_btn.layer.borderColor  = UIColorHex(4680ff).CGColor;
        [_reload_btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [_reload_btn setTitleColor:UIColorHex(4680ff) forState:UIControlStateNormal];
        [_reload_btn addTarget:self action:@selector(reload_btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reload_btn];

        // layout
        [_empty_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(185);
            make.height.mas_equalTo(150);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_reload_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(_empty_imageView.mas_bottom);
            make.width.mas_equalTo(100);
        }];
    }
    return self;
}
#pragma mark - Delegate Method
#pragma mark - EventResponse Method
- (void)reload_btnClick {
    if ([self.delegate respondsToSelector:@selector(chartsH5EmptyDataViewReloadClick:)]) {
        [self.delegate chartsH5EmptyDataViewReloadClick:self];
        if (self.superview) {
            [self removeFromSuperview];
        }
    }
}
#pragma mark - Private Method
#pragma mark - Setter And Getter Method

@end
