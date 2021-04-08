//
//  UIViewController+QYCCurrentVC.m
//  FBSnapshotTestCase
//
//  Created by Qiyeyun2 on 2020/11/18.
//

#import "UIViewController+QYCCurrentVC.h"

@implementation UIViewController (QYCCurrentVC)

+ (UIViewController *)appRootViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC     = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

+ (UIViewController *)currentViewController:(UIViewController *)baseVc {
    UIViewController *nav = [self appRootViewController];
    if (baseVc) {
        nav = baseVc;
    }
    if ([nav isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav2 = (UINavigationController *)nav;
        return [nav2.viewControllers lastObject];
    }
    else if ([nav isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabvc        = (UITabBarController *)nav;
        UIViewController *tabbarChildNav = [tabvc.viewControllers objectAtIndex:tabvc.selectedIndex];
        return [self currentViewController:tabbarChildNav];
    }
    return nav;
}

+ (UIViewController *)currentViewController {
    return [self currentViewController:nil];
}

@end
