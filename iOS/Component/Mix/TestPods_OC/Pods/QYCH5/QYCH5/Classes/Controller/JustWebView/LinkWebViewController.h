//
//  LinkWebViewController.h
//  Qiyeyun
//
//  Created by dong on 16/3/10.
//  Copyright © 2016年 钱立新. All rights reserved.
// app内部分享控制器

#import "NSObject+QYCExtensionEntId.h"
#import <UIKit/UIKit.h>

/**
   启业云内置web浏览器(UIWebView->WKWebView)
 */
@interface LinkWebViewController : UIViewController

@property (nonatomic, strong) NSURL *url;

@end
