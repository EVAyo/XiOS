//
//  QRUtil.h
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/10/9.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QRUtil : NSObject

+ (CGRect)screenBounds;

+ (AVCaptureVideoOrientation) videoOrientationFromCurrentDeviceOrientation;

#pragma mark - =========== 检测相机、相册是否可用 ===========
/// 是否支持相机，例如：模拟器不支持
+ (BOOL)isCameraAvailable;

/// 前置摄像头是否可用
+ (BOOL)isFrontCameraAvailable;

/// 后置摄像头是否可用
+ (BOOL)isRearCameraAvailable;

/// 前置闪光是否可用
+ (BOOL)isFrontFlashAvailable;

/// 后置闪光是否可用
+ (BOOL)isRearFlashAvailable;

/// 是否支持图库
+ (BOOL)isPhotoLibraryAvailable;

/// 是否支持相片库
+ (BOOL)isPhotosAlbumAvailable;

#pragma mark - =========== 检测相机、相册是否可用 ===========

/**
 AVAuthorizationStatusNotDetermined：首次(用户还没有选择)
 AVAuthorizationStatusRestricted：受限制的(例如:家长控制)
 AVAuthorizationStatusDenied：用户拒绝
 AVAuthorizationStatusAuthorized：用户授权
 */
+ (BOOL)isCameraAuthStatusCorrect;

#pragma mark - =========== 前往设置 ===========

+ (void)openAppSetting;

#pragma mark - =========== 国际化 ===========

+ (NSString *)localizedString:(NSString *)key;


@end
