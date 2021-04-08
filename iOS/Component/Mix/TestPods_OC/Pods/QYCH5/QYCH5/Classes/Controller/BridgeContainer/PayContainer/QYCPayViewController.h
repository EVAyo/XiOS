//
//  QYCPayViewController.h
//  Qiyeyun
//
//  Created by dong on 2019/11/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import "QYCFormH5ViewController.h"

NS_ASSUME_NONNULL_BEGIN


extern const NSString *tradeNumberKey;
extern const NSString *tradeAmountKey;
extern const NSString *tradeMerchantIdKey;
extern const NSString *tradeMerchantNameKey;
extern const NSString *tradeNotifyUrlKey;

@interface QYCPayViewController : QYCBaseWebViewController

/**支付参数*/
@property (nonatomic, strong)NSDictionary *payParams;

- (instancetype)initWithPayUrlSting:(NSString *)urlSting payParams:(NSDictionary *)payParams;

@property(nonatomic, copy) void(^PayResultCallback)(id data);

@property(nonatomic, copy) void(^backClickCallback)(void);

@end

NS_ASSUME_NONNULL_END
