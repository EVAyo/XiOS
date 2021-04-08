//
//  QYCPayViewController.m
//  Qiyeyun
//
//  Created by dong on 2019/11/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import "QYCPayViewController.h"
#import "QYCH5Config.h"
#import <CommonCrypto/CommonDigest.h>
// QYC Pods
#import <QYCCategory/UIColor+QYCColor.h>
#import <QYCIconFont/QYCFontImage.h>
#import <QYCUI/MBProgressHUD+CZ.h>
#import <QYCUI/QYCToast.h>
// Vendor Pods
#import <WechatOpenSDK/WXApi.h>
#import <WechatOpenSDK/WXApiObject.h>
#import <YYCategories/UIColor+YYAdd.h>
#import <YYCategories/YYCategoriesMacro.h>
//const
NSString *tradeNumberKey       = @"tradeNumber";
NSString *tradeAmountKey       = @"tradeAmount";
NSString *tradeMerchantIdKey   = @"tradeMerchantId";
NSString *tradeNotifyUrlKey    = @"notifyUrl";
NSString *tradeMerchantNameKey = @"merchantName";

@interface QYCPayViewController ()

@end

@implementation QYCPayViewController
#pragma mark - ================ LifeCycle =================
- (instancetype)initWithPayUrlSting:(NSString *)urlSting payParams:(NSDictionary *)payParams {
    self = [super initWithURLStr:urlSting];
    if (self) {
        _payParams = payParams;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self p_setup];
    //
    [self p_registerNativeJSCallback];
    //
    [self p_registerNoti];
}
#pragma mark - ================ Public Methods =================
#pragma mark - ================ Private Methods =================
- (void)p_setup {
    //
    self.navigationItem.title = @"请您支付";
    self.view.backgroundColor = KQYCColor(ffffff, 1e1e1e);
    UIImage *image                        = [QYCFontImage iconWithName:@"返回" fontSize:20 color:UIColorHex(ffffff)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick)];
}
- (void)p_registerNoti {
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"QYCPayWeChatPayFinishCallback"
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *_Nonnull note) {
                                                      PayResp *payResp = note.object;
                                                      [weakSelf callHandler:@"getNativePayStatus"
                                                                       data:@{@"errCode" : @(payResp.errCode)}
                                                           responseCallback:^(id responseData){

                                                           }];
                                                  }];
}
- (void)p_registerNativeJSCallback {
    @weakify(self);
    [self registerHandler:@"getNativeTradeInfo"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      NSString *tradeNo           = self.payParams[tradeNumberKey];
                      NSString *tradeNumStr       = self.payParams[tradeAmountKey];
                      NSString *tradeMerchantId   = self.payParams[tradeMerchantIdKey];
                      NSString *tradeMerchantName = self.payParams[tradeMerchantNameKey];
                      NSString *tradeNotifyUrl    = self.payParams[tradeNotifyUrlKey];
                      NSLog(@"%@", tradeNotifyUrl);
                      responseCallback(@{@"tradeNum" : tradeNumStr, @"tradeNo" : tradeNo, @"companyName" : tradeMerchantName, @"merchantId" : tradeMerchantId, @"payMode" : @"CP0002", @"notifyUrl" : tradeNotifyUrl});
                  }];
    [self registerHandler:@"callNativePay"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      if ([data[@"payType"] isEqual:@"wxpay"]) {
                          //微信支付
                          if (!data) {
                              [QYCToast showToastWithMessage:@"支付订单错误" type:QYCToastTypeError];
                              return;
                          }
                          PayReq *payRequest   = [[PayReq alloc] init];
                          payRequest.partnerId = data[@"partnerId"];
                          payRequest.prepayId  = data[@"prepayId"];
                          payRequest.package   = data[@"packageName"];
                          payRequest.nonceStr  = data[@"nonceStr"];
                          payRequest.timeStamp = (UInt32)[data[@"timeStamp"] integerValue];
                          payRequest.sign      = data[@"sign"];
                          [WXApi sendReq:payRequest completion:nil];
                      }
                  }];
    [self registerHandler:@"payResultCallback"
                  handler:^(id data, QYCWebBridgeResponseCallback responseCallback) {
                      @strongify(self);
                      if (self.PayResultCallback) {
                          self.PayResultCallback(data);
                      }
                  }];
}

#pragma mark - ================ Delegate =================
#pragma mark ===== 父类调用，子类触发
- (void)webViewControllerDidFinishLoad {
    
}
- (void)webViewDidFailLoadWithError:(nonnull NSError *)error {
    
}
- (void)webViewUpdateTitle:(NSString*)title {
    
}

#pragma mark - ================ Actions =================
- (void)leftBarButtonClick {
    if (self.backClickCallback) {
        self.backClickCallback();
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - ================ Getter and Setter =================
@end
