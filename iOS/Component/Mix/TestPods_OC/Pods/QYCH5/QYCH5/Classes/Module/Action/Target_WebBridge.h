//
//  Target_WebBridge.h
//  Qiyeyun
//
//  Created by 漆家佳 on 2020/10/30.
//  Copyright © 2020 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_WebBridge : NSObject

/**
 打开web控制器
 */
- (UIViewController *)Action_openH5WebViewController:(NSDictionary *)param;

/**
 打开支付页面
 */
- (UIViewController *)Action_openPayViewController:(NSDictionary *)param;

/**
 key  value
 vc   控制器
 其他  控制需要被赋的值
 */
- (void)Action_setValueForH5ViewController:(NSDictionary *)param;
@end

NS_ASSUME_NONNULL_END
