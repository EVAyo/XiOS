//
//  QYAlterViewItemInfo.m
//  Qiyeyun
//
//  Created by dong on 2017/3/6.
//  Copyright © 2017年 安元. All rights reserved.
//

#import "QYAlterViewItemInfo.h"

@implementation QYAlterViewItemInfo

- (instancetype)initWithRect:(CGRect)rect totleH:(CGFloat)totleH{
    if (self = [super init]) {
        _rect = rect;
        _AlterViewH = totleH;
    }
    return self;
}
@end
