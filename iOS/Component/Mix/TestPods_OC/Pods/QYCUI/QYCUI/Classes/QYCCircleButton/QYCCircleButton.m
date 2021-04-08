//
//  QYCCircleButton.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/10/17.
//  Copyright © 2019 安元. All rights reserved.
//

#import "QYCCircleButton.h"

@implementation QYCCircleButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //首先调用父类的方法确定点击的区域确实在按钮的区域中
    BOOL res = [super pointInside:point withEvent:event];
    if (res) {
        // 绘制一个圆形path
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        if ([path containsPoint:point]) {
            //如果在path区域内，返回YES
            return YES;
        }
        return NO;
    }
    return NO;
}

@end
