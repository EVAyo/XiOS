//
//  UIView+CornerExtension.m
//  Qiyeyun
//
//  Created by dong on 2017/2/17.
//  Copyright © 2017年 安元. All rights reserved.
//

#import "UIView+CornerExtension.h"
#import "UIView+RoundCorner.h"
#import <objc/runtime.h>
static const void *isNeedCornerKey = &isNeedCornerKey;
@implementation UIView (CornerExtension)
@dynamic isNeedCorner;
- (void)setIsNeedCorner:(NSNumber *)isNeedCorner {
    if ([isNeedCorner isEqualToNumber:@0])
        return;
    UIView *bgiew = self;
    [bgiew dd_addRoundedCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight withRadii:CGSizeMake(5, 5)];
    objc_setAssociatedObject(self, isNeedCornerKey, isNeedCorner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)isNeedCorner {
    return objc_getAssociatedObject(self, isNeedCornerKey);
}
@end
