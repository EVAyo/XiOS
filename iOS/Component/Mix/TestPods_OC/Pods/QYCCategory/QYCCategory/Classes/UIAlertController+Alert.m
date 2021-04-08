//
//  UIAlertController+Alert.m
//  EasyDoctor
//
//  Created by ylzinfo on 16/3/7.
//  Copyright © 张伟. All rights reserved.
//

#import "UIAlertController+Alert.h"
#import "UIColor+QYCColor.h"

//屏幕的大小
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width

@implementation UIAlertController (Alert)

+ (UIAlertController *)alertShowWithTitle:(NSString *)title message:(NSString *)message confirm:(NSString *)confirmTitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction  = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleCancel handler:nil];
    //    [okAction setValue:kBlueTextColor forKey:@"_titleTextColor"];//#4EB3D5
    [alert addAction:okAction];
    return alert;
}

+ (UIAlertController *)alertShowWithTitle:(NSString *)title message:(NSString *)message confirm:(NSString *)confirmTitle confirmHandler:(void (^)(void))handler {
    return [self alertShowWithTitle:title message:message cancel:@"取消" cancelHandler:nil confirm:confirmTitle confirmHandler:handler];
}

+ (UIAlertController *)alertShowWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler confirm:(NSString *)confirmTitle confirmHandler:(void (^)(void))handler {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    if (cancelTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *_Nonnull action) {
                                                                 if (cancelHandler) {
                                                                     cancelHandler();
                                                                 }
                                                             }];

        //        [cancelAction setValue:kBlueTextColor forKey:@"_titleTextColor"];
        [alertVC addAction:cancelAction];
    }

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:confirmTitle
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *_Nonnull action) {
                                                         if (handler) {
                                                             handler();
                                                         }
                                                     }];
    //    [okAction setValue:kBlueTextColor forKey:@"_titleTextColor"];//#4EB3D5
    [alertVC addAction:okAction];

    return alertVC;
}

+ (UIAlertController *)alertShowReverseButtonTitle:(NSString *)title message:(NSString *)message confirm:(NSString *)confirmTitle confirmHandler:(void (^)(void))handler {
    return [self alertShowReverseButtonTitle:title message:message confirm:confirmTitle confirmHandler:handler cancel:@"取消" cancelHandler:nil];
}

//按钮位置调换，确定在左取消在右
+ (UIAlertController *)alertShowReverseButtonTitle:(NSString *)title message:(NSString *)message confirm:(NSString *)confirmTitle confirmHandler:(void (^)(void))handler cancel:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:confirmTitle
                                                       style:UIAlertActionStyleCancel
                                                     handler:^(UIAlertAction *_Nonnull action) {
                                                         if (handler) {
                                                             handler();
                                                         }
                                                     }];
    //    [okAction setValue:kBlueTextColor forKey:@"_titleTextColor"];//#4EB3D5
    [alertVC addAction:okAction];
    //UIAlertActionStyleCancel样式总是显示在左侧，与添加按钮的顺序无关

    if (cancelTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *_Nonnull action) {
                                                                 if (cancelHandler) {
                                                                     cancelHandler();
                                                                 }
                                                             }];
        //        [cancelAction setValue:kBlueTextColor forKey:@"_titleTextColor"];//#4EB3D5
        [alertVC addAction:cancelAction];
    }
    return alertVC;
}

+ (UIAlertController *)alertShowWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler isDestructive:(BOOL)isDestructive confirm:(NSString *)confirmTitle confirmHandler:(void (^)(void))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (cancelTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *_Nonnull action) {
                                                                 if (cancelHandler) {
                                                                     cancelHandler();
                                                                 }
                                                             }];
        //        [cancelAction setValue:kBlueTextColor forKey:@"_titleTextColor"];//#4EB3D5
        [alert addAction:cancelAction];
    }
    UIAlertAction *otherAction;
    if (isDestructive) {
        otherAction = [UIAlertAction actionWithTitle:confirmTitle
                                               style:UIAlertActionStyleDestructive
                                             handler:^(UIAlertAction *_Nonnull action) {
                                                 if (handler) {
                                                     handler();
                                                 }
                                             }];
    }
    else {
        otherAction = [UIAlertAction actionWithTitle:confirmTitle
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *_Nonnull action) {
                                                 if (handler) {
                                                     handler();
                                                 }
                                             }];
        //        [otherAction setValue:kBlueTextColor forKey:@"_titleTextColor"];//#4EB3D5
    }
    [alert addAction:otherAction];
    return alert;
}

#pragma mark UIAlertControllerStyleActionSheet
+ (UIAlertController *)actionSheetWithButtonTitleArray:(NSArray *)buttonTitleArray handler:(void (^)(NSInteger index))handler {
    return [self actionSheetWithTitle:nil buttonTitleArray:buttonTitleArray handler:handler];
}

+ (UIAlertController *)actionSheetWithTitle:(NSString *)title buttonTitleArray:(NSArray *)buttonTitleArray handler:(void (^)(NSInteger index))handler {
    return [self actionSheetWithTitle:title buttonTitleArray:buttonTitleArray handler:handler cancelHandler:nil];
}

+ (UIAlertController *)actionSheetWithTitle:(NSString *)title buttonTitleArray:(NSArray *)buttonTitleArray handler:(void (^)(NSInteger index))handler cancelHandler:(void (^)(void))cancelHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (title.length > 0) {
        alert.title = title;
    }
    for (NSInteger i = 0; i < buttonTitleArray.count; i++) {
        NSString *buttonTitle = buttonTitleArray[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           handler(i);
                                                       }];
        [action setValue:KQYCColor(333333, c4c4c4) forKey:@"_titleTextColor"]; //#4EB3D5
        [alert addAction:action];
    }

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action) {
                                                       if (cancelHandler) {
                                                           cancelHandler();
                                                       }
                                                   }];
    [cancel setValue:KQYCColor(333333, c4c4c4) forKey:@"_titleTextColor"]; //#4EB3D5
    [alert addAction:cancel];

    UIPopoverPresentationController *popover = alert.popoverPresentationController;
    if (popover) {
        popover.sourceView               = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        popover.sourceRect               = CGRectMake(WIDTH * 0.5, HEIGHT, 1.0, 1.0);
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }

    return alert;
}

@end
