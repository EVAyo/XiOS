//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+CZ.h"

@implementation MBProgressHUD (CZ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *IconFontBudleURL = [bundle URLForResource:@"QYCUI" withExtension:@"bundle"];
    NSBundle *IconFontBudle = [NSBundle bundleWithURL:IconFontBudleURL];
    UIImage *image = [UIImage imageNamed:icon inBundle:IconFontBudle compatibleWithTraitCollection:nil];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    //[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.cornerRadius = 10;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = YES;
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.9];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // ////////////////////////////////////////////////////////////
//    UIImageView  *imagView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"progress1.png"]];
//    hud.customView = imagView;
//    hud.mode = MBProgressHUDModeCustomView;
//    [self runAnimationWithCount:10 andImageView:imagView];
    // ////////////////////////////////////////////////////////////
//    hud.tipColor = [UIColor clearColor];
//    hud.labelColor = mRGBToColor(0x444444);
    hud.cornerRadius = 10;
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+(void) runAnimationWithCount:(NSInteger) count andImageView:(UIImageView*)imageView
{
    //  创建可变数组
    NSMutableArray *images = [NSMutableArray array];
    //  往数组中添加图片
    for (int index = 0; index < count; index++) {
        //        图片名称
        NSString *imageN = [NSString stringWithFormat:@"progress%d",index + 1];
        //       创建图片
//        NSString *path = [[NSBundle mainBundle] pathForResource:imageN ofType:@"png"];
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
        UIImage *image = [UIImage imageNamed:imageN];
        //       图片加入数组
        [images addObject:image];
    }
    //  把图片赋值给imageView动画数组【帧动画】
    imageView.animationImages = images;
    
    //  整个动画播放一圈的时间
    imageView.animationDuration = count * 0.05;
    
    //  动画的重复次数
    imageView.animationRepeatCount = 0;
    
    //   开始播放动画
    [imageView startAnimating];

}

@end
