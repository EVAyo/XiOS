//
//  NSObject+LXViewControllerAdditions.h
//  Qiyeyun
//
//  Created by 钱立新 on 16/10/10.
//  Copyright © 2016年 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LXViewControllerAdditions)

/**
 *  获取当前活动的视图控制器
 */
- (UIViewController *)lx_activityViewController;

@end
