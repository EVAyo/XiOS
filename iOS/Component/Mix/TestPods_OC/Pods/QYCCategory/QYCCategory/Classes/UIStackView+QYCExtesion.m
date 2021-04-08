//
//  UIStackView+QYCExtesion.m
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2019/12/18.
//  Copyright © 2019 安元. All rights reserved.
//

#import "UIStackView+QYCExtesion.h"

@implementation UIStackView (QYCExtesion)

- (void)qyc_addBackground:(UIColor *)color{
    UIView *subView = [[UIView alloc] init];
    subView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self insertSubview:subView atIndex:0];
    subView.backgroundColor = color;
}

- (void)qyc_addCorner:(CGFloat)corner{
    UIView *subView = [[UIView alloc] init];
    subView.layer.cornerRadius = corner;
    subView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self insertSubview:subView atIndex:0];
}

@end
