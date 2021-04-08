//
//  QYCToastDefine.h
//  QYCUI
//
//  Created by 启业云03 on 2020/8/12.
//

#ifndef QYCToastDefine_h
#define QYCToastDefine_h

// 是否为iPhoneX系列
static inline BOOL isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = nil;
        if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
            mainWindow = [[UIApplication sharedApplication].delegate window];
        }
        else {
            mainWindow = [UIApplication sharedApplication].windows.firstObject;
        }
        
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

// 尺寸
#define IS_IPHONE_X_Series isIPhoneXSeries()
#define IPHONE_NAVIGATIONBAR_HEIGHT (IS_IPHONE_X_Series ? 88 : 64)
#define IPHONE_STATUSBAR_HEIGHT (IS_IPHONE_X_Series ? 44 : 20)
#define IPHONE_SAFEBOTTOMAREA_HEIGHT (IS_IPHONE_X_Series ? 34 : 0)
#define IPHONE_TOPSENSOR_HEIGHT (IS_IPHONE_X_Series ? 32 : 0)
//屏幕的大小
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width

// 十六进制颜色
#define HexColor(hex) [UIColor colorWithRed:((hex >> 16) & 0xFF)/255.0 green:((hex >> 8) & 0xFF)/255.0 blue:(hex & 0xFF)/255.0 alpha:1.0]

// 颜色适配暗黑
static inline UIColor* QYCColor(UIColor *lightColor, UIColor *darkColor) {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return lightColor;
            }
            else {
                return darkColor;
            }
        }];
    }
    else {
        return lightColor ? lightColor : (darkColor ? darkColor : [UIColor clearColor]);
    }
}

#endif /* QYCToastDefine_h */
