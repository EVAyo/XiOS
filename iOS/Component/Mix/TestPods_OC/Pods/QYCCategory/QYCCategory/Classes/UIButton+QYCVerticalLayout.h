//
//  UIButton+QYCVerticalLayout.h
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2019/12/24.
//  Copyright © 2019 安元. All rights reserved.
//UIbutton 图文垂直布局


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (QYCVerticalLayout)

- (void)qyc_centerVerticallyWithPadding:(float)padding;
- (void)qyc_centerVertically;

@end

NS_ASSUME_NONNULL_END
