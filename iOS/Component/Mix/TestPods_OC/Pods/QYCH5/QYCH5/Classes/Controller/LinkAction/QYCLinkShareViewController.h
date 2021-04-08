//
//  QYCLinkShareViewController.h
//  Qiyeyun
//
//  Created by dong on 2017/10/1.
//  Copyright © 2017年 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OperationType) {
    OperationTypeForward,
    OperationTypeRelay,
    OperationTypeCopy,
    OperationTypeOpenLink,
    OperationTypeRefresh
};

typedef void (^OperationClick)(OperationType operationType);

@interface QYCLinkShareViewController : UIViewController

@property (nonatomic, copy) OperationClick operationClick;
@property (nonatomic, copy) void (^dissMissAction)();

@end
