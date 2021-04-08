//
//  UIView+LXShadowPath.m
//  LXViewShadowPath
//
//  Created by chenergou on 2017/11/23.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "UIView+QYCShadowPath.h"

@implementation UIView (QYCShadowPath)
/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 
 * shadowPathWidth 阴影的宽度，
 
 */

- (void)QYC_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(QYCShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth {
    self.layer.masksToBounds = NO;

    self.layer.shadowColor = shadowColor.CGColor;

    self.layer.shadowOpacity = shadowOpacity;

    self.layer.shadowRadius = shadowRadius;

    self.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;

    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat originW = self.bounds.size.width;
    CGFloat originH = self.bounds.size.height;

    switch (shadowPathSide) {
        case QYCShadowPathTop:
            shadowRect = CGRectMake(originX, originY - shadowPathWidth / 2, originW, shadowPathWidth);
            break;
        case QYCShadowPathBottom:
            shadowRect = CGRectMake(originX, originH - shadowPathWidth / 2, originW, shadowPathWidth);
            break;

        case QYCShadowPathLeft:
            shadowRect = CGRectMake(originX - shadowPathWidth / 2, originY, shadowPathWidth, originH);
            break;

        case QYCShadowPathRight:
            shadowRect = CGRectMake(originW - shadowPathWidth / 2, originY, shadowPathWidth, originH);
            break;
        case QYCShadowPathNoTop:
            shadowRect = CGRectMake(originX - shadowPathWidth / 2, originY + 1, originW + shadowPathWidth, originH + shadowPathWidth / 2);
            break;
        case QYCShadowPathAllSide:
            shadowRect = CGRectMake(originX - shadowPathWidth / 2, originY - shadowPathWidth / 2, originW + shadowPathWidth, originH + shadowPathWidth);
            break;
    }

    UIBezierPath *path    = [UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = path.CGPath;
}

- (void)QYC_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(QYCShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight {
    self.layer.masksToBounds = NO;

    self.layer.shadowColor = shadowColor.CGColor;

    self.layer.shadowOpacity = shadowOpacity;

    self.layer.shadowRadius = shadowRadius;

    self.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;

    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat originW = viewWidth;
    CGFloat originH = viewHeight;

    switch (shadowPathSide) {
        case QYCShadowPathTop:
            shadowRect = CGRectMake(originX, originY - shadowPathWidth / 2, originW, shadowPathWidth);
            break;
        case QYCShadowPathBottom:
            shadowRect = CGRectMake(originX, originH - shadowPathWidth / 2, originW, shadowPathWidth);
            break;

        case QYCShadowPathLeft:
            shadowRect = CGRectMake(originX - shadowPathWidth / 2, originY, shadowPathWidth, originH);
            break;

        case QYCShadowPathRight:
            shadowRect = CGRectMake(originW - shadowPathWidth / 2, originY, shadowPathWidth, originH);
            break;
        case QYCShadowPathNoTop:
            shadowRect = CGRectMake(originX - shadowPathWidth / 2, originY + 1, originW + shadowPathWidth, originH + shadowPathWidth / 2);
            break;
        case QYCShadowPathAllSide:
            shadowRect = CGRectMake(originX - shadowPathWidth / 2, originY - shadowPathWidth / 2, originW + shadowPathWidth, originH + shadowPathWidth);
            break;
    }

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];

    self.layer.shadowPath = path.CGPath;
}

@end
