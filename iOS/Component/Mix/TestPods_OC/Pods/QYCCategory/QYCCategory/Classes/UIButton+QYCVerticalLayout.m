//
//  UIButton+QYCVerticalLayout.m
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2019/12/24.
//  Copyright © 2019 安元. All rights reserved.
//

#import "UIButton+QYCVerticalLayout.h"

@implementation UIButton (QYCVerticalLayout)

- (void)qyc_centerVerticallyWithPadding:(float)padding{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGFloat totalHeight = (imageSize.height + titleSize.height + padding);

    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
                                            0.0f,
                                            0.0f,
                                            - titleSize.width);

    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            - imageSize.width,
                                            - (totalHeight - titleSize.height),
                                            0.0f);

    self.contentEdgeInsets = UIEdgeInsetsMake(0.0f,
                                              0.0f,
                                              titleSize.height,
                                              0.0f);
}
- (void)qyc_centerVertically{
    const CGFloat kDefaultPadding = 0.0f;
    [self qyc_centerVerticallyWithPadding:kDefaultPadding];
}

@end
