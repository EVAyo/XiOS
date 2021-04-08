//
//  UIViewController+QYCLandscape.m
//  Qiyeyun
//
//  Created by dong on 2017/11/10.
//  Copyright © 2017年 安元. All rights reserved.
//

#import "UIViewController+QYCLandscape.h"
#import "NSObject+QYCSwizzle.h"
#import <objc/runtime.h>

@implementation UIViewController (QYCLandscape)
+ (void)load{
    [self qyc_swizzleMethod:@selector(shouldAutorotate) withMethod:@selector(qyc_shouldAutorotate) error:nil];
    [self qyc_swizzleMethod:@selector(supportedInterfaceOrientations) withMethod:@selector(qyc_supportedInterfaceOrientations) error:nil];
}

- (BOOL)qyc_shouldAutorotate{ // 是否支持旋转.
    if ([self isKindOfClass:NSClassFromString(@"QYCBashBoardDetailsViewController")]) {
        return YES;
    }
    
    if ([self isKindOfClass:NSClassFromString(@"BLRootViewController")]) {
        return self.childViewControllers.firstObject.shouldAutorotate;
    }
    
    if ([self isKindOfClass:NSClassFromString(@"JPWarpViewController")]) {
        return self.childViewControllers.firstObject.shouldAutorotate;
    }
    
    if ([self isKindOfClass:NSClassFromString(@"UITabBarController")]) {
        return ((UITabBarController *)self).selectedViewController.shouldAutorotate;
    }
    
    if ([self isKindOfClass:NSClassFromString(@"UINavigationController")]) {
        return ((UINavigationController *)self).viewControllers.lastObject.shouldAutorotate;
    }
    
    if ([self checkSelfNeedLandscape]) {
        return YES;
    }
    
    if (self.qyc_shouldAutoLandscape) {
        return YES;
    }
    
    return NO;
}

- (UIInterfaceOrientationMask)qyc_supportedInterfaceOrientations{ // 支持旋转的方向.
    
    if ([self isKindOfClass:NSClassFromString(@"QYCBashBoardDetailsViewController")]) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    
    if ([self isKindOfClass:NSClassFromString(@"BLRootViewController")]) {
        return [self.childViewControllers.firstObject supportedInterfaceOrientations];
    }
    
    if ([self isKindOfClass:NSClassFromString(@"JPWarpViewController")]) {
        return [self.childViewControllers.firstObject supportedInterfaceOrientations];
    }
    
    if ([self isKindOfClass:NSClassFromString(@"UITabBarController")]) {
        return [((UITabBarController *)self).selectedViewController supportedInterfaceOrientations];
    }
    
    if ([self isKindOfClass:NSClassFromString(@"UINavigationController")]) {
        return [((UINavigationController *)self).viewControllers.lastObject supportedInterfaceOrientations];
    }
    
    if ([self checkSelfNeedLandscape]) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    
    if (self.qyc_shouldAutoLandscape) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    
    return UIInterfaceOrientationMaskPortrait;
}


- (void)setQyc_shouldAutoLandscape:(BOOL)qyc_shouldAutoLandscape{
    objc_setAssociatedObject(self, @selector(qyc_shouldAutoLandscape), @(qyc_shouldAutoLandscape), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)qyc_shouldAutoLandscape{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (BOOL)checkSelfNeedLandscape{
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    NSOperatingSystemVersion operatingSytemVersion = processInfo.operatingSystemVersion;
    
    if (operatingSytemVersion.majorVersion == 8) {
        NSString *className = NSStringFromClass(self.class);
        if ([@[@"AVPlayerViewController", @"AVFullScreenViewController", @"AVFullScreenPlaybackControlsViewController"
               ] containsObject:className]) {
            return YES;
        }
        
        if ([self isKindOfClass:[UIViewController class]] && [self childViewControllers].count && [self.childViewControllers.firstObject isKindOfClass:NSClassFromString(@"AVPlayerViewController")]) {
            return YES;
        }
    }
    else if (operatingSytemVersion.majorVersion == 9){
        NSString *className = NSStringFromClass(self.class);
        if ([@[@"WebFullScreenVideoRootViewController", @"AVPlayerViewController", @"AVFullScreenViewController"
               ] containsObject:className]) {
            return YES;
        }
        
        if ([self isKindOfClass:[UIViewController class]] && [self childViewControllers].count && [self.childViewControllers.firstObject isKindOfClass:NSClassFromString(@"AVPlayerViewController")]) {
            return YES;
        }
    }
    else if (operatingSytemVersion.majorVersion == 10){
        if ([self isKindOfClass:NSClassFromString(@"AVFullScreenViewController")]) {
            return YES;
        }
    }
    
    return NO;
}

@end
