//
//  CTMediator+QYCQRCodeModuleActions.m
//  Qiyeyun
//
//  Created by Qiyeyun2 on 2020/11/11.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator+QYCQRCodeModuleActions.h"

NSString *const kQYCMediatorTargetQRCodeModule = @"QRCodeModule";

NSString *const kQYCMediatorActionmediator_handleURL = @"mediator_handleURL";
NSString *const kQYCMediatorActionQRCodeActionVC     = @"QRCodeActionVC";
//NSString *const kQYCMediatorActionshowFromViewController = @"showFromViewController";
NSString *const kQYCMediatorActiondiscernQRCode = @"discernQRCode";
NSString *const kQYCMediatorActiondealCode      = @"dealCode";

NSString *const kQYCMediatorActionmediator_showFromVC = @"showFromViewController";

@implementation CTMediator (QYCQRCodeModuleActions)

- (void)mediator_handleURL:(NSString *)url vc:(UIViewController *)vc {
    [self performTarget:kQYCMediatorTargetQRCodeModule action:kQYCMediatorActionmediator_handleURL params:@{@"url" : url ?: @"", @"vc" : vc ?: [UIViewController new]} shouldCacheTarget:NO];
}

//- (UIViewController *)mediator_QRCodeActionVCWithImage:(UIImage *)image
//                                      viewDidLoadBlock:(void (^)(void))viewDidLoadBlock {
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if (image) {
//        [params setValue:image forKey:@"image"];
//    }
//    if (viewDidLoadBlock) {
//        [params setValue:viewDidLoadBlock forKey:@"viewDidLoadBlock"];
//    }
//
//    return [self performTarget:kQYCMediatorTargetQRCodeModule action:kQYCMediatorActionQRCodeActionVC params:params shouldCacheTarget:NO];
//}

//- (void)mediator_showFromViewController:(UIViewController *)showVC codesData:(NSArray *)data vc:(UIViewController *)vc {
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if (showVC) {
//        [params setValue:showVC forKey:@"showVC"];
//    }
//    if (data) {
//        [params setValue:data forKey:@"data"];
//    }
//    if (vc) {
//        [params setValue:vc forKey:@"vc"];
//    }
//    [self performTarget:kQYCMediatorTargetQRCodeModule action:kQYCMediatorActionshowFromViewController params:params shouldCacheTarget:NO];
//}

- (NSArray<NSString *> *)mediator_discernQRCode:(UIImage *)image {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (image) {
        [params setValue:image forKey:@"image"];
    }
    return [self performTarget:kQYCMediatorTargetQRCodeModule action:kQYCMediatorActiondiscernQRCode params:params shouldCacheTarget:NO];
}

- (void)mediator_dealCode:(NSString *)code currentVC:(UIViewController *)vc {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (code) {
        [params setValue:code forKey:@"code"];
    }
    if (vc) {
        [params setValue:vc forKey:@"vc"];
    }
    [self performTarget:kQYCMediatorTargetQRCodeModule action:kQYCMediatorActiondealCode params:params shouldCacheTarget:NO];
}
- (void)mediator_showFromVCWithImage:(UIImage *)image codesData:(NSArray *)codesData vc:(UIViewController *)vc callBack:(void (^_Nullable)(void))callBack {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (image) {
        dic[@"imageData"] = UIImagePNGRepresentation(image);
    }

    if (codesData) {
        dic[@"codesData"] = codesData;
    }
    if (vc) {
        dic[@"vc"] = vc;
    }
    if (callBack) {
        dic[@"callBack"] = callBack;
    }

    [self performTarget:kQYCMediatorTargetQRCodeModule action:kQYCMediatorActionmediator_showFromVC params:dic shouldCacheTarget:NO];
}

@end
