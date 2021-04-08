//
//  QRViewController.h
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/4/25.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//  扫一扫

#import <UIKit/UIKit.h>

@class QRViewController;

typedef void (^QRUrlBlock)(NSString *url, QRViewController *vc);

@protocol QRViewControllerDelegate <NSObject>

@optional
- (void)qrViewController:(QRViewController *)vc scanResult:(NSString *)scanResult;

@end



@interface QRViewController : UIViewController

@property (nonatomic, copy) QRUrlBlock qrUrlBlock;

@property (nonatomic, weak) id<QRViewControllerDelegate> delegate;

@end
