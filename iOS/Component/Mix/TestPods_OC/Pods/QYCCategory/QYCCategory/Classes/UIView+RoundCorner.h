//
//  UIView+RoundCorner.h
//  Qiyeyun
//
//  Created by dong on 2016/12/15.
//  Copyright © 2016年 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RoundCorner)

/**绝对圆角*/
- (void)dd_addRoundedCorners:(UIRectCorner)corners
                   withRadii:(CGSize)radi;
/**相对圆角*/
- (void)dd_addRoundedCorners:(UIRectCorner)corners
                   withRadii:(CGSize)radii
                    viewRect:(CGRect)rect;
- (void)dd_cutCicleViewWithRoundedCorners:(UIRectCorner)corners radious:(CGSize)radius;

@end
