//
//  QYCChartsBoardViewController.m
//  Qiyeyun
//
//  Created by dong on 2018/10/16.
//  Copyright © 2018年 安元. All rights reserved.
//

#import "QYCChartsBoardViewController.h"
#import "CTMediator+Profile.h"

@interface QYCChartsBoardViewController ()
@property (nonatomic, assign) BOOL againLoad;
@end

@implementation QYCChartsBoardViewController

#pragma mark - ================ LifeCycle =================

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [CT() mediator_updateNavgationBarUserHeaderToVC:self];
}

// 刷新前操作
- (void)willRefresh {
    // 重新加载cookie
    NSHTTPCookieStorage *cookieStorage             = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSMutableArray<NSHTTPCookie *> *sessionCookies = [NSMutableArray array];
    [cookieStorage.cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj.name isEqualToString:@"PHPSESSID"] || [obj.name isEqualToString:@"CURRENT_ENT"]) {
            [sessionCookies addObject:obj];
        }
    }];
    self.cookies = sessionCookies.copy;
}

- (void)completedRefresh {
    //
}

@end
