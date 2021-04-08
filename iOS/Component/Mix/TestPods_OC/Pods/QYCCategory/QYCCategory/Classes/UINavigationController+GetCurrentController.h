//
//  UINavigationController+GetCurrentController.h
//  Qiyeyun
//
//  Created by dong on 2016/12/23.
//  Copyright © 2016年 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL (^QYCNavigationItemPopHandler)(UINavigationBar *navigationBar, UINavigationItem *navigationItem);

@protocol QYCNavigationBackItemProtocol <NSObject>
@optional

/**
 Decision method to tell navigation to pop item or not.
 @discusstion handler has higher priority than protocol. If you have both implemented. Then the system will choose the handler instead of protocol.

 @param navigationBar navigationBar navigation bar to layout item
 @param item item item to pop
 @return a Boolean value to decide pop item or not
 */
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item;
@end

@interface UINavigationController (GetCurrentController)

@property (copy, nonatomic) QYCNavigationItemPopHandler popHandler;

+ (UINavigationController *)getCurrentController;

@end
