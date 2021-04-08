//
//  AppDelegate.m
//  Category
//
//  Created by 钱立新 on 14/10/28.
//  Copyright © 2014年 钱立新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

/**
 生成UIBarButtonItem

 @param image 正常图标
 @param highImage 高亮图标
 @param target 目标
 @param action 方法
 @param controlEvents 事件模式
 @return 返回生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 生成左侧UIBarButtonItem
 
 @param image 正常图标
 @param highImage 高亮图标
 @param target 目标
 @param action 方法
 @param controlEvents 事件模式
 @return 返回生成的UIBarButtonItem
 */

+ (UIBarButtonItem *)leftbarButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 生成UIBarButtonItem

 @param title 标题
 @param color 标题颜色
 @param fontNum 标题字体号
 @param target 目标
 @param action 方法
 @param controlEvents 事件模式
 @return 返回生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)color fontNum:(CGFloat)fontNum target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
/**
 生成导航栏的返回Item

 @param image 正常图标
 @param highImage 高亮图标
 @param target 目标
 @param action 方法
 @param controlEvents 事件模式
 @return 返回生成的导航栏的返回Item
 */
+ (NSArray<UIBarButtonItem *> *)barBackButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
