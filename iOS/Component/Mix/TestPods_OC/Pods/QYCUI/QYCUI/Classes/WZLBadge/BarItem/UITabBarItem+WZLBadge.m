//
//  UITabBarItem+WZLBadge.m
//  WZLBadgeDemo
//
//  Created by zilin_weng on 15/9/24.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import "UITabBarItem+WZLBadge.h"

#define kActualView     [self getActualBadgeSuperView]

@implementation UITabBarItem (WZLBadge)

#pragma mark -- public methods

/**
 *  show badge with red dot style and WBadgeAnimTypeNone by default.
 */
- (void)showBadge {
    dispatch_async(dispatch_get_main_queue(), ^{
        [kActualView showBadge];
    });
}

/**
 *  showBadge
 *
 *  @param style WBadgeStyle type
 *  @param value (if 'style' is WBadgeStyleRedDot or WBadgeStyleNew,
 this value will be ignored. In this case, any value will be ok.)
 *   @param aniType
 */
- (void)showBadgeWithStyle:(WBadgeStyle)style
                     value:(NSInteger)value
             animationType:(WBadgeAnimType)aniType {
    dispatch_async(dispatch_get_main_queue(), ^{
        [kActualView showBadgeWithStyle:style value:value animationType:aniType];
    });
}

/**
 *  clear badge
 */
- (void)clearBadge {
    dispatch_async(dispatch_get_main_queue(), ^{
        [kActualView clearBadge];
    });
}

- (void)resumeBadge {
    dispatch_async(dispatch_get_main_queue(), ^{
        [kActualView resumeBadge];
    });
}

#pragma mark -- private method

/**
 *  Because UIBarButtonItem is kind of NSObject, it is not able to directly attach badge.
 This method is used to find actual view (non-nil) inside UIBarButtonItem instance.
 *
 *  @return view
 */
- (UIView *)getActualBadgeSuperView {
    // 1.get UITabbarButtion
    UIView *bottomView = [self valueForKeyPath:@"_view"];
    
    // 2.get imageView, to make sure badge front at anytime.
    UIView *actualSuperView = nil;
    if (bottomView) {
        if (@available(iOS 13.0, *)) {
            // 通过设置 badgeValue 的值让系统添加大胖点
            self.badgeValue = @"";
            self.badgeColor = [UIColor clearColor];
            actualSuperView = [self ios13Find:bottomView];
        }
        else {
            actualSuperView = [self find:bottomView firstSubviewWithClass:NSClassFromString(@"UIImageView")];
        }
    }
    
    // badge label will be added onto imageView
    return actualSuperView;
}

- (UIView *)ios13Find:(UIView *)view {
    __block UIView *targetView = nil;
    [view.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass(subview.class) containsString:@"UIBadgeVie"]) {
            targetView = subview;
            *stop = YES;
        }
    }];
    return targetView;
}

- (UIView *)find:(UIView *)view firstSubviewWithClass:(Class)cls {
    __block UIView *targetView = nil;
    [view.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([subview isKindOfClass:cls]) {
            targetView = subview;
            *stop = YES;
        }
    }];
    return targetView;
}

#pragma mark -- setter/getter
- (UILabel *)badge {
    return kActualView.badge;
}

- (void)setBadge:(UILabel *)label {
    [kActualView setBadge:label];
}

- (UIFont *)badgeFont {
	return kActualView.badgeFont;
}

- (void)setBadgeFont:(UIFont *)badgeFont {
	[kActualView setBadgeFont:badgeFont];
}

- (UIColor *)badgeBgColor {
    return [kActualView badgeBgColor];
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor {
    [kActualView setBadgeBgColor:badgeBgColor];
}

- (UIColor *)badgeTextColor {
    return [kActualView badgeTextColor];
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    [kActualView setBadgeTextColor:badgeTextColor];
}

- (WBadgeAnimType)aniType {
    return [kActualView aniType];
}

- (void)setAniType:(WBadgeAnimType)aniType {
    [kActualView setAniType:aniType];
}

- (CGRect)badgeFrame {
    return [kActualView badgeFrame];
}

- (void)setBadgeFrame:(CGRect)badgeFrame {
    [kActualView setBadgeFrame:badgeFrame];
}

- (CGPoint)badgeCenterOffset {
    return [kActualView badgeCenterOffset];
}

- (void)setBadgeCenterOffset:(CGPoint)badgeCenterOffset {
    [kActualView setBadgeCenterOffset:badgeCenterOffset];
}

- (void)setBadgeRadius:(CGFloat)badgeRadius {
    [kActualView setBadgeRadius:badgeRadius];
}

- (CGFloat)badgeRadius {
    return [kActualView badgeRadius];
}

- (NSInteger)badgeMaximumBadgeNumber {
    return [kActualView badgeMaximumBadgeNumber];
}

- (void)setBadgeMaximumBadgeNumber:(NSInteger)badgeMaximumBadgeNumber {
    [kActualView setBadgeMaximumBadgeNumber:badgeMaximumBadgeNumber];
}

@end
