//
//  UIView+RoundCorner.m
//  Qiyeyun
//
//  Created by dong on 2016/12/15.
//  Copyright © 2016年 安元. All rights reserved.
//

#import "UIView+RoundCorner.h"

@implementation UIView (RoundCorner)
- (void)dd_addRoundedCorners:(UIRectCorner)corners
                   withRadii:(CGSize)radii {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape   = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];  //设置路径

    self.layer.mask = shape;
}

- (void)dd_addRoundedCorners:(UIRectCorner)corners
                   withRadii:(CGSize)radii
                    viewRect:(CGRect)rect {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape   = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];

    self.layer.mask = shape;
}

- (void)dd_cutCicleViewWithRoundedCorners:(UIRectCorner)corners radious:(CGSize)radius {
    CGSize size      = self.frame.size;
    CGRect rect      = CGRectMake(0, 0, size.width, size.height);
    UIColor *bkColor = self.backgroundColor;

    UIImage *image = [[UIImage alloc] init];
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, bkColor.CGColor);
    CGContextAddPath(context, [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radius].CGPath);
    CGContextDrawPath(context, kCGPathFill);
    [image drawInRect:rect];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image        = output;
    [self insertSubview:imageView atIndex:0];
    self.backgroundColor = [UIColor clearColor];
}

@end
