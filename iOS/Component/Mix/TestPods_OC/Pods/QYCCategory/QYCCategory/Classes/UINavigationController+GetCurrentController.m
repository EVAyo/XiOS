//
//  UINavigationController+GetCurrentController.m
//  Qiyeyun
//
//  Created by dong on 2016/12/23.
//  Copyright © 2016年 安元. All rights reserved.
//

#import "UINavigationController+GetCurrentController.h"
#import <objc/runtime.h>

@implementation UINavigationController (GetCurrentController)

+ (UINavigationController *)getCurrentController {
    UIWindow *window            = [UIApplication sharedApplication].delegate.window;
    UITabBarController *tab     = (UITabBarController *)window.rootViewController;
    UINavigationController *nav = [tab selectedViewController];
    return nav;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Inject "-navigationBar:shouldPopItem:"
        Method originalMethod = class_getInstanceMethod(self, @selector(navigationBar:shouldPopItem:));
        Method swizzledMethod = class_getInstanceMethod(self, @selector(QYC_navigationBar:shouldPopItem:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (BOOL)QYC_navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    // Should pop. It appears called the pop view controller methods. We should pop items directly.
    BOOL shouldPopItemAfterPopViewController = [[self valueForKey:@"_isTransitioning"] boolValue];

    if (shouldPopItemAfterPopViewController) {
        return [self QYC_navigationBar:navigationBar shouldPopItem:item];
    }

    if (self.popHandler) {
        BOOL shouldPopItemAfterPopViewController = self.popHandler(navigationBar, item);

        if (shouldPopItemAfterPopViewController) {
            return [self QYC_navigationBar:navigationBar shouldPopItem:item];
        }

        // Make sure the back indicator view alpha set to 1.0.
        [UIView animateWithDuration:0.25
                         animations:^{
                             [[self.navigationBar subviews] lastObject].alpha = 1;
                         }];

        return shouldPopItemAfterPopViewController;
    }
    else {
        UIViewController *viewController = [self topViewController];

        if ([viewController respondsToSelector:@selector(navigationBar:shouldPopItem:)]) {
            BOOL shouldPopItemAfterPopViewController = [(id<QYCNavigationBackItemProtocol>)viewController navigationBar:navigationBar shouldPopItem:item];

            if (shouldPopItemAfterPopViewController) {
                return [self QYC_navigationBar:navigationBar shouldPopItem:item];
            }

            // Make sure the back indicator view alpha set to 1.0.
            [UIView animateWithDuration:0.25
                             animations:^{
                                 [[self.navigationBar subviews] lastObject].alpha = 1;
                             }];

            return shouldPopItemAfterPopViewController;
        }
    }

    return [self QYC_navigationBar:navigationBar shouldPopItem:item];
}

#pragma mark - Getters&Setters
- (QYCNavigationItemPopHandler)popHandler {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPopHandler:(QYCNavigationItemPopHandler)popHandler {
    objc_setAssociatedObject(self, @selector(popHandler), [popHandler copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
