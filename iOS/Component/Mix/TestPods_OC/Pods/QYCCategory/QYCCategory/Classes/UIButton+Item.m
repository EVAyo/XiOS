//
//  UIButton+Item.m
//  Qiyeyun
//
//  Created by 钱立新 on 15/12/15.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import "UIButton+Item.h"
#import <objc/runtime.h>

NSString const *KRelativePoint = @"KRelativePoint";

@implementation UIButton (Item)

static char kAssociatedObjectKey_recordPosition;
- (void)setRecordPosition:(BOOL)recordPosition {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_recordPosition, @(recordPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)recordPosition {
    return [((NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_recordPosition)) boolValue];
}

- (CGPoint)relativePoint {
    NSValue *value = objc_getAssociatedObject(self, &KRelativePoint);
    if (value == nil) {
        return CGPointZero;
    }
    return [value CGPointValue];
}

- (void)setRelativePoint:(CGPoint)relativePoint {
    objc_setAssociatedObject(self, &KRelativePoint, [NSValue valueWithCGPoint:relativePoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch     = touches.anyObject;
    CGPoint point      = [touch locationInView:[UIApplication sharedApplication].keyWindow];
    self.relativePoint = point;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (self.recordPosition) {
        UITouch *touch     = touches.anyObject;
        CGPoint point      = [touch locationInView:[UIApplication sharedApplication].keyWindow];
        self.relativePoint = point;
    }
}

/*****************************************************************************/
static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect {
    NSNumber *topEdge    = objc_getAssociatedObject(self, &topNameKey);
    NSNumber *rightEdge  = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *leftEdge   = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue, self.bounds.origin.y - topEdge.floatValue, self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue, self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame ByRoundingCorners:(UIRectCorner)corner cornerRadius:(CGFloat)radius {
    UIButton *btn           = [[UIButton alloc] initWithFrame:frame];
    UIBezierPath *maskPath  = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *masklayer = [CAShapeLayer new];
    masklayer.frame         = btn.bounds;
    masklayer.path          = maskPath.CGPath;
    btn.layer.mask          = masklayer;
    return btn;
}

/*****************************************************************************/
- (void)setImagePosition:(LXImagePosition)postion spacing:(CGFloat)spacing {
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];

    CGFloat imageW = self.imageView.frame.size.width;
    CGFloat imageH = self.imageView.frame.size.height;
    CGFloat titleW = self.titleLabel.frame.size.width;

    switch (postion) {
        case LXImagePositionLeft: {
            if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
                self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
            }
            else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
            }
            else {
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing / 2, 0, spacing / 2);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, -spacing / 2);
            }
            break;
        }
        case LXImagePositionRight: {
            if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
                self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW + spacing, 0, 0);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageW, 0, 0);
            }
            else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -titleW);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, imageW + spacing);
            }
            else {
                CGFloat imageOffset  = titleW + spacing / 2;
                CGFloat titleOffset  = imageW + spacing / 2;
                self.imageEdgeInsets = UIEdgeInsetsMake(0, imageOffset, 0, -imageOffset);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -titleOffset, 0, titleOffset);
            }
            break;
        }
        case LXImagePositionTop: {
            CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
            CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
            self.imageEdgeInsets               = UIEdgeInsetsMake(-titleIntrinsicContentSizeH - spacing, 0, 0, -titleIntrinsicContentSizeW);
            self.titleEdgeInsets               = UIEdgeInsetsMake(0, -imageW, -imageH - spacing, 0);
            break;
        }
        case LXImagePositionBottom: {
            CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
            CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
            self.imageEdgeInsets               = UIEdgeInsetsMake(titleIntrinsicContentSizeH + spacing, 0, 0, -titleIntrinsicContentSizeW);
            self.titleEdgeInsets               = UIEdgeInsetsMake(0, -imageW, imageH + spacing, 0);
            break;
        }
        default:
            break;
    }
}

- (void)setImagePosition:(LXImagePosition)postion spacing:(CGFloat)spacing imagePositionBlock:(void (^)(UIButton *))imagePositionBlock {
    imagePositionBlock(self);

    if (postion == LXImagePositionLeft) {
        if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
        }
        else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
        }
        else {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -0.5 * spacing, 0, 0.5 * spacing);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * spacing, 0, -0.5 * spacing);
        }
    }
    else if (postion == LXImagePositionRight) {
        CGFloat imageW = self.imageView.image.size.width;
        CGFloat titleW = self.titleLabel.frame.size.width;
        if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW + spacing, 0, 0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageW, 0, 0);
        }
        else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -titleW);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, imageW + spacing);
        }
        else {
            CGFloat imageOffset  = titleW + 0.5 * spacing;
            CGFloat titleOffset  = imageW + 0.5 * spacing;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, imageOffset, 0, -imageOffset);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -titleOffset, 0, titleOffset);
        }
    }
    else if (postion == LXImagePositionTop) {
        CGFloat imageW                     = self.imageView.frame.size.width;
        CGFloat imageH                     = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets               = UIEdgeInsetsMake(-titleIntrinsicContentSizeH - spacing, 0, 0, -titleIntrinsicContentSizeW);
        self.titleEdgeInsets               = UIEdgeInsetsMake(0, -imageW, -imageH - spacing, 0);
    }
    else if (postion == LXImagePositionBottom) {
        CGFloat imageW                     = self.imageView.frame.size.width;
        CGFloat imageH                     = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets               = UIEdgeInsetsMake(titleIntrinsicContentSizeH + spacing, 0, 0, -titleIntrinsicContentSizeW);
        self.titleEdgeInsets               = UIEdgeInsetsMake(0, -imageW, imageH + spacing, 0);
    }
}

@end
