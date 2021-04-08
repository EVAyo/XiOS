//
//  NSObject+LXViewControllerAdditions.m
//  Qiyeyun
//
//  Created by 钱立新 on 16/10/10.
//  Copyright © 2016年 安元. All rights reserved.
//

#import "NSObject+LXViewControllerAdditions.h"

@implementation NSObject (LXViewControllerAdditions)

- (UIViewController *)lx_activityViewController {
    UIViewController *activityViewController = nil;

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }

    NSArray *viewsArray = [window subviews];
    if ([viewsArray count] > 0) {
        UIView *frontView = [viewsArray objectAtIndex:0];

        id nextResponder = [frontView nextResponder];

        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            activityViewController = nextResponder;
        }
        else {
            activityViewController = window.rootViewController;
        }
    }

    return activityViewController;
}

@end
