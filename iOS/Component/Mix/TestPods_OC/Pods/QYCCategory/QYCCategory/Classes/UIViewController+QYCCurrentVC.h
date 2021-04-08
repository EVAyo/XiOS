//
//  UIViewController+QYCCurrentVC.h
//  FBSnapshotTestCase
//
//  Created by Qiyeyun2 on 2020/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (QYCCurrentVC)

+ (UIViewController *)appRootViewController;

+ (UIViewController *)currentViewController;

+ (UIViewController *)currentViewController:(UIViewController *)baseVc;

@end

NS_ASSUME_NONNULL_END
