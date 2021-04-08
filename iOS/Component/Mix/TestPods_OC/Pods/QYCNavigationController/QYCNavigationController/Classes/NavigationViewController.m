//
//  NavigationViewController.m
//  Qiyeyun
//
//  Created by 钱立新 on 15/10/30.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import "NavigationViewController.h"
#import "QYCFontImage.h"
#import "UIColor+QYCColor.h"
#import "UIColor+YYAdd.h"
#import <QYCNavigationExtension/JZNavigationExtension.h>

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self congfigNavgationBar];
}

- (void)congfigNavgationBar {
    UINavigationBar *navBar = self.navigationBar;
    navBar.barTintColor     = KQYCColor(296cff, 000000);

    /**tintColor是用于导航条的所有Item*/
    navBar.tintColor = KQYCColor(ffffff, c4c4c4);

    /**设置导航条标题的字体和颜色*/
    NSDictionary *titleAttr = @{
        NSForegroundColorAttributeName : KQYCColor(ffffff, c4c4c4),
        NSFontAttributeName : [UIFont systemFontOfSize:20]
    };
    [navBar setTitleTextAttributes:titleAttr];

    /**更改返回箭头图片*/
    [navBar setBackIndicatorImage:[QYCFontImage iconWithName:@"返回" fontSize:20 color:UIColorHex(ffffff)]];
    [navBar setBackIndicatorTransitionMaskImage:[QYCFontImage iconWithName:@"返回" fontSize:20 color:UIColorHex(ffffff)]];
    self.jz_fullScreenInteractivePopGestureEnabled = YES;
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark 导航控制器的子控制器被push 的时候会调用
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //设置 push 新控制器的时候 隐藏Tabbar
    if (self.childViewControllers.count) { // 不是根控制器
        viewController.hidesBottomBarWhenPushed                          = YES;
        viewController.navigationItem.backBarButtonItem                  = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.viewControllers.lastObject.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }

    [super pushViewController:viewController animated:animated];
}

@end
