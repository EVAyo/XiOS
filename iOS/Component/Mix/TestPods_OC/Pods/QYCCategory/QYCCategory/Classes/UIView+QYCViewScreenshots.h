//
//  UIView+QYCViewScreenshots.h
//  Qiyeyun
//
//  Created by dong on 2017/11/21.
//  Copyright © 2017年 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QYCViewScreenshots)

/**
  view截屏

 @return
 */
- (UIImage *)qyc_viewScreenshots;

/**
 view截屏

 @param rect 截屏位置
 @return
 */
- (UIImage *)qyc_viewScreenshotsWithRect:(CGRect)rect;

@end
