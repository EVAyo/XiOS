//
//  CTMediator+FormViewModule.m
//  Qiyeyun
//
//  Created by 安元科技 on 2020/11/11.
//  Copyright © 2020 安元. All rights reserved.
//

#import "CTMediator+FormViewModule.h"
NSString *const QYCMediatorTargetFormView                    = @"FormView";
NSString *const QYCMediatorActionNativEnterFormView          = @"enterFormView";
NSString *const QYCMediatorActionNativFetchFormViewVC        = @"nativeFetchFormViewVC";
NSString *const QYCMediatorActionNativFormViewParams         = @"nativFormViewParams";
NSString *const QYCMediatorActionNativFormViewEntId          = @"nativFormViewEntId";
NSString *const QYCMediatorActionNativFormLeftNavTitleAction = @"nativformLeftNavTitleAction";

@implementation CTMediator (FormViewModule)

- (UIViewController *)mediator_enterFormViewWithEntId:(NSString *)entId formViewParam:(NSDictionary *)param filterCondtions:(nullable NSArray *)filterCondtions {
    NSDictionary *dic = @{
        @"entId" : entId ?: @"",
        @"param" : param ?: @{},
        @"filterCondtions" : filterCondtions ?: @[],
    };
    UIViewController *vc = [self performTarget:QYCMediatorTargetFormView action:QYCMediatorActionNativEnterFormView params:dic shouldCacheTarget:NO];
    if (vc == nil) {
        return [self unifiedExceptionVC];
    }
    else {
        return vc;
    }
}

- (void)mediator_openFormViewWithTargetVC:(UIViewController *)vc param:(NSDictionary *)param entId:(NSString *)entId {
    NSDictionary *dic = @{@"targetVC" : vc ?: [UIViewController new], @"param" : param ?: @{}, @"entId" : entId ?: @""};
    [self performTarget:QYCMediatorTargetFormView action:QYCMediatorActionNativFetchFormViewVC params:dic shouldCacheTarget:NO];
}

- (void)mediator_formViewParams:(NSDictionary *)params vc:(UIViewController *)vc {
    NSDictionary *p = @{@"vc" : vc ?: [UIViewController new], @"params" : params ?: @{}};
    [self performTarget:QYCMediatorTargetFormView action:QYCMediatorActionNativFormViewParams params:p shouldCacheTarget:NO];
}

- (void)mediator_formViewEntId:(NSString *)entId vc:(UIViewController *)vc {
    NSDictionary *p = @{@"vc" : vc ?: [UIViewController new], @"entId" : entId ?: @""};
    [self performTarget:QYCMediatorTargetFormView action:QYCMediatorActionNativFormViewEntId params:p shouldCacheTarget:NO];
}

- (void)mediator_formLeftNavTitleAction:(void (^)(BOOL isUsing, UIViewController *formVC))action vc:(UIViewController *)vc {
    void (^temp)(BOOL isUsing, UIViewController *formVC) = ^(BOOL isUsing, UIViewController *formVC) {

    };
    NSDictionary *p = @{
        @"action" : action ?: temp,
        @"vc" : vc ?: [UIViewController new],
    };
    [self performTarget:QYCMediatorTargetFormView action:QYCMediatorActionNativFormLeftNavTitleAction params:p shouldCacheTarget:NO];
}
@end
