//
//  UIView+QYCViewScreenshots.m
//  Qiyeyun
//
//  Created by dong on 2017/11/21.
//  Copyright © 2017年 安元. All rights reserved.
//

#import "UIView+QYCViewScreenshots.h"

@implementation UIView (QYCViewScreenshots)

- (UIImage *)qyc_viewScreenshotsWithRect:(CGRect)rect {
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(rect);
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage *)qyc_viewScreenshots {
    return [self qyc_viewScreenshotsWithRect:self.bounds];
}

@end
