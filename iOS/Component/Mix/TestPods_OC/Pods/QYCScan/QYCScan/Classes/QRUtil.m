//
//  QRUtil.m
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/10/9.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import "QRUtil.h"


@implementation QRUtil


+ (CGRect)screenBounds {
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect screenRect;
    if (![screen respondsToSelector:@selector(fixedCoordinateSpace)] && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        screenRect = CGRectMake(0, 0, screen.bounds.size.height, screen.bounds.size.width);
    }
    else {
        screenRect = screen.bounds;
    }
    return screenRect;
}

+ (AVCaptureVideoOrientation) videoOrientationFromCurrentDeviceOrientation {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait) {
        return AVCaptureVideoOrientationPortrait;
    }
    else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return AVCaptureVideoOrientationLandscapeLeft;
    }
    else if (orientation == UIInterfaceOrientationLandscapeRight){
        return AVCaptureVideoOrientationLandscapeRight;
    }
    else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return AVCaptureVideoOrientationPortraitUpsideDown;
    }
    
    return AVCaptureVideoOrientationPortrait;
}


#pragma mark - =========== 检测相机、相册是否可用 ===========

/// 是否支持相机，例如：模拟器不支持
+ (BOOL)isCameraAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

/// 前置摄像头是否可用
+ (BOOL)isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

/// 后置摄像头是否可用
+ (BOOL)isRearCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

/// 前置闪光是否可用
+ (BOOL)isFrontFlashAvailable {
    return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceFront];
}

/// 后置闪光是否可用
+ (BOOL)isRearFlashAvailable {
    return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
}

/// 是否支持图库
+ (BOOL)isPhotoLibraryAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

/// 是否支持相片库
+ (BOOL)isPhotosAlbumAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}

#pragma mark - =========== 检测相机、相册是否可用 ===========

/**
 AVAuthorizationStatusNotDetermined：首次(用户还没有选择)
 AVAuthorizationStatusRestricted：受限制的(例如:家长控制)
 AVAuthorizationStatusDenied：用户拒绝
 AVAuthorizationStatusAuthorized：用户授权
 */
+ (BOOL)isCameraAuthStatusCorrect {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusAuthorized) {
        return YES;
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (NO == granted) {
                //... 拒绝授权
            }
        }];
        return YES;
    }
    return NO;
}

#pragma mark - =========== 前往设置 ===========

+ (void)openAppSetting {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url
                                               options:@{}
                                     completionHandler:^(BOOL success){

                                     }];
        }
        else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark - =========== 国际化 ===========

+ (NSString *)localizedString:(NSString *)key {
    
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    if (language.length == 0) {
        return key;
    }
    NSString *fileNamePrefix = @"zh-Hans";
    if([language hasPrefix:@"en"]) {
        fileNamePrefix = @"en";
    }
    NSBundle *tmpBundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [tmpBundle URLForResource:@"QYCScan" withExtension:@"bundle"];
    if(!url) return key;
    NSBundle *tmp = [NSBundle bundleWithURL:url];
    
    NSString *path = [tmp pathForResource:fileNamePrefix ofType:@"lproj"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    NSString *localizedString = [bundle localizedStringForKey:key value:nil table:@"Localizable"];
    if (!localizedString) {
        localizedString = key;
    }
    return localizedString;
}

@end
