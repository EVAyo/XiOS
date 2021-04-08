//
//  UIAlertController+Alert.h
//  smartcampus
//
//  Created by zhangw on 19/8/15.
//  Copyright © 张伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Alert)

/**
 定制化AlertView
 
 @param title 标题
 @param message 信息
 @param confirmTitle 确定按钮
 @return UIAlertController
 */
+ (UIAlertController *)alertShowWithTitle:(NSString *)title message:(NSString *)message confirm:(NSString *)confirmTitle;

/**
 定制化AlertView
 
 @param title 标题
 @param message 信息
 @param confirmTitle 确定按钮
 @param handler 确定回调
 @return UIAlertController
 */
+ (UIAlertController *)alertShowWithTitle:(NSString *)title message:(NSString *)message confirm:(NSString *)confirmTitle confirmHandler:(void (^)(void))handler;

/**
 定制化AlertView
 
 @param title 标题
 @param message 信息
 @param cancelTitle 取消按钮
 @param cancelHandler 取消回调
 @param confirmTitle 确定按钮
 @param handler 确定回调
 @return UIAlertController
 */
+ (UIAlertController *)alertShowWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler confirm:(NSString *)confirmTitle confirmHandler:(void (^)(void))handler;

/**
 定制化AlertView 按钮位置调换，确定在左取消在右
 
 @param title 标题
 @param message 信息
 @param confirmTitle 确定按钮
 @param handler 确定回调
 @return UIAlertController
 */
+ (UIAlertController *)alertShowReverseButtonTitle:(NSString *)title message:(NSString *)message confirm:(NSString *)confirmTitle confirmHandler:(void (^)(void))handler;

/**
 定制化AlertView 按钮位置调换，确定在左取消在右
 
 @param title 标题
 @param message 信息
 @param confirmTitle 确定按钮
 @param handler 确定回调
 @param cancelTitle 取消按钮
 @param cancelHandler 取消回调
 @return UIAlertController
 */
+ (UIAlertController *)alertShowReverseButtonTitle:(NSString *)title message:(NSString *)message confirm:(NSString *)confirmTitle confirmHandler:(void (^)(void))handler cancel:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler;

/**
 定制化AlertView
 
 @param title 标题
 @param message 信息
 @param cancelTitle 取消按钮
 @param cancelHandler 取消回调
 @param isDestructive 是否具有该样式
 @param confirmTitle 确定按钮
 @param handler 确定回调
 @return UIAlertController
 */
+ (UIAlertController *)alertShowWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler isDestructive:(BOOL)isDestructive confirm:(NSString *)confirmTitle confirmHandler:(void (^)(void))handler;

/**
 定制化actionSheet（不带标题）
 
 @param buttonTitleArray 选择框数组
 @param handler 回调事件
 @return UIAlertController
 */
+ (UIAlertController *)actionSheetWithButtonTitleArray:(NSArray *)buttonTitleArray handler:(void (^)(NSInteger index))handler;  //不带标题

/**
 定制化actionSheet
 
 @param title 标题
 @param buttonTitleArray 选择框数组
 @param handler 回调事件
 @return UIAlertController
 */
+ (UIAlertController *)actionSheetWithTitle:(NSString *)title buttonTitleArray:(NSArray *)buttonTitleArray handler:(void (^)(NSInteger index))handler;

/**
 定制化actionSheet
 
 @param title 标题
 @param buttonTitleArray 选择框数组
 @param handler 回调事件
 @param cancelHandler 取消回调事件
 @return UIAlertController
 */
+ (UIAlertController *)actionSheetWithTitle:(NSString *)title buttonTitleArray:(NSArray *)buttonTitleArray handler:(void (^)(NSInteger index))handler cancelHandler:(void (^)(void))cancelHandler;

@end
