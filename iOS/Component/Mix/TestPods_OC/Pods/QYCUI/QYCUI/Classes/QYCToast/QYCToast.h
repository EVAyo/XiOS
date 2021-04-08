//
//  QYCToastView.h
//  Qiyeyun
//
//  Created by 钱立新 on 2017/4/29.
//  Copyright © 2017年 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, QYCToastType) {
    
    QYCToastTypeDefault = 1,    /**无图标，默认*/
    QYCToastTypeSuccess = 2,    /**成功*/
    QYCToastTypeError = 3,      /**失败/错误*/
    QYCToastTypeWarning = 4,    /**警告*/
    QYCToastTypeInfo = 5,       /**信息*/
    QYCToastTypeOnGoing = 6     /**进行中*/
};

typedef NS_ENUM(NSInteger, QYCToastPosition) {
    
    //显示在屏幕顶部
    QYCToastPositionDefault = 0,          /**显示在屏幕顶部*/
    //显示在状态栏下方
    QYCToastPositionBelowStatusBar = 1,   /**显示在状态栏下方*/
    //显示在状态栏下方+圆角+左右边距
    QYCToastPositionBelowStatusBarWithFillet = 2,  /**显示在状态栏下方+圆角+左右边距*/
    //显示在屏幕底部
    QYCToastPositionBottom = 3,           /**显示在屏幕底部*/
    //显示在屏幕底部+圆角
    QYCToastPositionBottomWithFillet = 4  /**显示在屏幕底部+圆角*/
    
};


@interface QYCToast : UIView


//Toast点击回调
typedef void(^handler)(void);

//背景颜色
@property (strong, nonatomic) UIColor* toastBackgroundColor;
//Toast内容文字颜色
@property (strong, nonatomic) UIColor* messageTextColor;

//Toast文字字体
@property (strong, nonatomic) UIFont* messageFont;

//Toast View圆角
@property(assign,nonatomic)CGFloat toastCornerRadius;
//Toast View透明度
@property(assign,nonatomic)CGFloat toastAlpha;

//Toast显示时长
@property(assign,nonatomic)NSTimeInterval duration;
//Toast消失动画是否启用
@property(assign,nonatomic)BOOL dismissToastAnimated;

//Toast显示位置
@property (assign, nonatomic) QYCToastPosition toastPosition;
//Toast显示类型
@property (assign, nonatomic) QYCToastType toastType;

/**
 创建一个默认在顶部出现的Toast(持续时间为2秒)
 
 @param message 消息内容
 @param type 消息类型
 */
+ (void)showToastWithMessage:(NSString*)message type:(QYCToastType)type;

/**
 创建一个默认在顶部出现的Toast
 
 @param message 消息内容
 @param type 消息类型
 @param duration 持续时间
 */
+ (void)showToastWithMessage:(NSString*)message type:(QYCToastType)type duration:(NSTimeInterval)duration;

/**
 创建一个默认在顶部出现的Toast
 
 @param message 消息内容
 @param type 消息类型
 @param iconImage 图片
 */
+ (void)showToastWithMessage:(NSString*)message type:(QYCToastType)type iconImage:(UIImage*)iconImage;
/**
 创建一个Toast
 
 @param message 消息内容
 @param iconImage 消息icon
 @return Toast
 */
- (instancetype)initToastWithMessage:(NSString *)message iconImage:(UIImage*)iconImage;


/**
 显示一个Toast
 */
- (void)show;

/**
 显示一个Toast
 
 @param handler Toast点击回调
 */
- (void)show:(handler)handler;


@end
