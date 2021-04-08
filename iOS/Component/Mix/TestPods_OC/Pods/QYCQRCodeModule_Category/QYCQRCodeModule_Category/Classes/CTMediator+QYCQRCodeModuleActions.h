//
//  CTMediator+QYCQRCodeModuleActions.h
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/11/11.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (QYCQRCodeModuleActions)

- (void)mediator_handleURL:(NSString *)url vc:(UIViewController *)vc;

//- (UIViewController *)mediator_QRCodeActionVCWithImage:(UIImage *)image
//                                      viewDidLoadBlock:(void (^)(void))viewDidLoadBlock;
//
//- (void)mediator_showFromViewController:(UIViewController *)showVC codesData:(NSArray *)data vc:(UIViewController *)vc;

/// 识别图中二维码
/// @param image <#image description#>
- (NSArray<NSString *> *)mediator_discernQRCode:(UIImage *)image;

/// 处理二维码信息
/// @param code <#code description#>
/// @param vc <#vc description#>
- (void)mediator_dealCode:(NSString *)code currentVC:(UIViewController *)vc;
- (void)mediator_showFromVCWithImage:(UIImage *)image codesData:(NSArray *)codesData vc:(UIViewController *)vc callBack:(void (^_Nullable)(void))callBack;

@end

NS_ASSUME_NONNULL_END
