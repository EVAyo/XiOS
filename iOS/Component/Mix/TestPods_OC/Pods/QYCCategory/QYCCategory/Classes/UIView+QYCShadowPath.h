//
//  UIView+LXShadowPath.h
//  LXViewShadowPath
//
//  Created by chenergou on 2017/11/23.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSInteger {

    QYCShadowPathLeft,

    QYCShadowPathRight,

    QYCShadowPathTop,

    QYCShadowPathBottom,

    QYCShadowPathNoTop,

    QYCShadowPathAllSide

} QYCShadowPathSide;
@interface UIView (QYCShadowPath)

/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 
 * shadowPathWidth 阴影的宽度，
 
 * viewWidth view自身的宽度，

 * viewHeight view自身的高度，

 */

- (void)QYC_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(QYCShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;

- (void)QYC_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(QYCShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight;

@end
