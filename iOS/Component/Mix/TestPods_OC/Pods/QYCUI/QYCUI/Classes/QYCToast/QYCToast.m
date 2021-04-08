
//
//  QYCToastView.m
//  Qiyeyun
//
//  Created by 钱立新 on 2017/4/29.
//  Copyright © 2017年 安元. All rights reserved.
//

#import "QYCToast.h"
// 定义
#import "QYCToastDefine.h"
// 依赖
#import <QYCIconFont/QYCIconFont.h>

#define HORIZONTAL_SPACE 8.f
#define BOTTOM_SPACE 80.f
#define BOTTOM_HORIZONTAL_MAX_SPACE 20.f

@interface QYCToast ()

//Toast内容Label
@property(strong,nonatomic)UILabel *messageLabel;
@property (nonatomic, copy) NSString* messageString;

@property (strong, nonatomic) UIImage* iconImage;

@property (assign, nonatomic) CGSize messageLabelSize;

@property (assign, nonatomic) CGRect toastViewFrame;

@property (strong, nonatomic) NSMutableAttributedString *atttibutString;

@property handler handler;
@end

@implementation QYCToast


static NSMutableArray* toastArray = nil;

+ (void)showToastWithMessage:(NSString*)message type:(QYCToastType)type duration:(NSTimeInterval)duration {
    QYCToast *toast = [[QYCToast alloc]initToastWithMessage:message iconImage:nil];
    toast.duration = duration;
    toast.toastAlpha = 1;
    toast.toastPosition = QYCToastPositionDefault;
    toast.toastType = type;
    toast.messageFont = [UIFont systemFontOfSize:15];
    toast.dismissToastAnimated = YES;
    [toast show];
}

+ (void)showToastWithMessage:(NSString*)message type:(QYCToastType)type iconImage:(UIImage*)iconImage {
    QYCToast *toast = [[QYCToast alloc]initToastWithMessage:message iconImage:nil];
    toast.duration = 2.0;
    toast.toastAlpha = 1;
    toast.toastPosition = QYCToastPositionDefault;
    toast.toastType = type;
    toast.iconImage = iconImage;
    toast.messageFont = [UIFont systemFontOfSize:15];
    toast.dismissToastAnimated = YES;
    [toast show];
}

+ (void)showToastWithMessage:(NSString*)message type:(QYCToastType)type {
    QYCToast *toast = [[QYCToast alloc]initToastWithMessage:message iconImage:nil];
    toast.duration = 2.0;
    toast.toastAlpha = 1;
    toast.toastPosition = QYCToastPositionDefault;
    toast.toastType = type;
    toast.messageFont = [UIFont systemFontOfSize:15];
    toast.dismissToastAnimated = YES;
    [toast show];
}

- (instancetype)initToastWithMessage:(NSString *)message iconImage:(UIImage*)iconImage {
    
    if (!toastArray) toastArray = [NSMutableArray new];
    //设置默认背景色
    self.toastBackgroundColor = QYCColor(UIColor.whiteColor, HexColor(0x2F2F2F));
    
    self.messageString = message;
    
    if (iconImage == nil) {
        if (self.toastType == QYCToastPositionDefault) {
            self.iconImage = nil;
        }
    }
    else{
        self.iconImage = iconImage;
    }
    
    return [self init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.messageLabel = [[UILabel alloc]init];
        [self addSubview:self.messageLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat tempStatusBarHeight = 0;
    if (self.toastPosition == QYCToastPositionDefault) {
        tempStatusBarHeight = IPHONE_STATUSBAR_HEIGHT;
    }
    
    CGFloat messageLabelW = self.messageLabelSize.width;
    CGFloat messageLabelH = self.messageLabelSize.height;
    CGFloat messageLabelX = (self.toastViewFrame.size.width - messageLabelW)* 0.5;
    CGFloat messageLabelY = (self.toastViewFrame.size.height - self.messageLabelSize.height - tempStatusBarHeight)/2 + tempStatusBarHeight;
    
    self.messageLabel.frame = CGRectMake(messageLabelX, messageLabelY, messageLabelW, messageLabelH);
}

/// 加载各View数据
- (void)loadViewData {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    UIColor *textColor = QYCColor(self.messageTextColor ? : UIColor.blackColor, UIColor.whiteColor);
    NSDictionary * attributes = @{NSParagraphStyleAttributeName:paragraphStyle,
                                  NSFontAttributeName:_messageFont,
                                  NSForegroundColorAttributeName:textColor};
    NSString *mess = self.messageString?:@"";
    self.atttibutString = [[NSMutableAttributedString alloc]initWithString: mess attributes:attributes];
    
    if (self.iconImage) {
        [self.atttibutString insertAttributedString:[[NSAttributedString alloc]initWithString:@"   "] atIndex:0];
        NSTextAttachment *attchment = [NSTextAttachment new];
        attchment.image = self.iconImage;
        attchment.bounds = CGRectMake(0, -4,20, 20);
        NSAttributedString *imageAttribute = [NSAttributedString attributedStringWithAttachment:attchment];
        [self.atttibutString insertAttributedString:imageAttribute atIndex:0];
    }
    
    CGFloat textMaxWidth = 0;
    textMaxWidth = WIDTH - 2*HORIZONTAL_SPACE;
    
    if (self.toastPosition == QYCToastPositionBelowStatusBar || self.toastPosition == QYCToastPositionBelowStatusBarWithFillet) {
        textMaxWidth -= 2*HORIZONTAL_SPACE;
    }
    else if(self.toastPosition == QYCToastPositionBottom || self.toastPosition == QYCToastPositionBottomWithFillet){
        textMaxWidth -= 2*BOTTOM_HORIZONTAL_MAX_SPACE;
    }
    
    self.messageLabelSize = [self sizeForAttributedString:self.atttibutString maxWidth:textMaxWidth];
    
    self.messageLabel.attributedText = self.atttibutString;
    
    if (_toastBackgroundColor != nil) {
        self.backgroundColor = _toastBackgroundColor;
    }
}

/// 设置Toast的frame、属性及内部控件的属性等
- (void)layoutToastView {
    
    //设置子控件属性
    self.messageLabel.textColor = _messageTextColor;
    self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = _messageFont;
    
    self.alpha = _toastAlpha;
    self.layer.cornerRadius = _toastCornerRadius;
    self.layer.masksToBounds = YES;
    //根据toastType的icon
    switch (self.toastType) {
        case QYCToastTypeDefault: break;
        case QYCToastTypeSuccess:
            if (!_iconImage) self.iconImage = [QYCFontImage iconWithName:@"toast-success" fontSize:20.f color:HexColor(0x66C131)];
            // if (!_iconImage) self.iconImage = [UIImage imageNamed:@"form_toast_success"];
            break;
            
        case QYCToastTypeError:
            if (!_iconImage) self.iconImage = [QYCFontImage iconWithName:@"toast-error" fontSize:20.f color:HexColor(0xFC5C5C)];
            // if (!_iconImage) self.iconImage = [UIImage imageNamed:@"form_toast_error"];
            break;
            
        case QYCToastTypeWarning:
            if (!_iconImage) self.iconImage = [QYCFontImage iconWithName:@"toast-warn" fontSize:20.f color:[UIColor orangeColor]];
            // if (!_iconImage) self.iconImage = [UIImage imageNamed:@"form_toast_warning"];
            break;
            
        case QYCToastTypeInfo:
            if (!_iconImage) self.iconImage = [QYCFontImage iconWithName:@"toast-base" fontSize:20.f color:HexColor(0x4680FF)];
            // if (!_iconImage) self.iconImage = [UIImage imageNamed:@"form_toast_info"];
            break;
       case QYCToastTypeOnGoing:
            if (!_iconImage) self.iconImage = [QYCFontImage iconWithName:@"toast-down" fontSize:20.f color:HexColor(0x4680FF)];
            break;
            
        default: break;
    }
    
    [self loadViewData];
    
    //上滑消失
    if (_toastPosition != QYCToastPositionBottom && _toastPosition != QYCToastPositionBottomWithFillet) {
        UISwipeGestureRecognizer* swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipeGesture];
    }
    
    self.toastViewFrame = [self getToastViewFrame];
    
    switch (self.toastPosition) {
        case QYCToastPositionDefault:
            self.frame = CGRectMake(_toastViewFrame.origin.x, -_toastViewFrame.size.height, _toastViewFrame.size.width, _toastViewFrame.size.height);
            break;
        case QYCToastPositionBelowStatusBar:
            self.frame = CGRectMake(_toastViewFrame.origin.x, -(_toastViewFrame.size.height + IPHONE_STATUSBAR_HEIGHT), _toastViewFrame.size.width, _toastViewFrame.size.height);
            break;
        case QYCToastPositionBelowStatusBarWithFillet:
            self.frame = CGRectMake(_toastViewFrame.origin.x, -(_toastViewFrame.size.height + IPHONE_STATUSBAR_HEIGHT), _toastViewFrame.size.width, _toastViewFrame.size.height);
            break;
        case QYCToastPositionBottom:
            self.frame = _toastViewFrame;
            self.alpha = 0.f;
            break;
        case QYCToastPositionBottomWithFillet:
            self.frame = _toastViewFrame;
            self.alpha = 0.f;
            break;
        default:
            break;
    }
    
}

/// 计算ToastView的frame
- (CGRect)getToastViewFrame {
    
    CGFloat toastViewX = 0;
    CGFloat toastViewY = 0;
    CGFloat toastViewW = 0;
    CGFloat toastViewH = 0;

    CGFloat Vertical_Space = 8;
    toastViewH = self.messageLabelSize.height + 2 * Vertical_Space;
    
    
    switch (self.toastPosition) {
        case QYCToastPositionDefault: {
            toastViewW = WIDTH;
            toastViewH += IPHONE_STATUSBAR_HEIGHT;
            break;
        }
        case QYCToastPositionBelowStatusBar: {
            toastViewY = IPHONE_STATUSBAR_HEIGHT;
            toastViewW = WIDTH;
            break;
        }
        case QYCToastPositionBelowStatusBarWithFillet: {
            toastViewX = HORIZONTAL_SPACE;
            toastViewY = IPHONE_STATUSBAR_HEIGHT;
            toastViewW = WIDTH - 2*HORIZONTAL_SPACE;
            
            if (self.toastCornerRadius == 0) {
                self.toastCornerRadius = 5.f;
            }
            self.layer.cornerRadius = _toastCornerRadius;
            self.layer.masksToBounds = YES;
            
            break;
        }
        case QYCToastPositionBottom: {
            
            toastViewW = _messageLabelSize.width + 2* HORIZONTAL_SPACE;
            toastViewX = (WIDTH - toastViewW)/2;
            toastViewY = HEIGHT - toastViewH - BOTTOM_SPACE;
            break;
        }
        case QYCToastPositionBottomWithFillet: {
            
            toastViewW = _messageLabelSize.width + 2* HORIZONTAL_SPACE;
            toastViewX = (WIDTH - toastViewW)/2;
            toastViewY = HEIGHT - toastViewH - BOTTOM_SPACE;
            
            if (self.toastCornerRadius == 0) {
                self.toastCornerRadius = 5.f;
            }
            self.layer.cornerRadius = _toastCornerRadius;
            self.layer.masksToBounds = YES;
            
            break;
        }
        default:
            break;
    }
    return CGRectMake(toastViewX, toastViewY, toastViewW, toastViewH);
}

/// 显示一个Toast
- (void)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self layoutToastView];
        
        //显示之前先把之前的移除
        if ([toastArray count] != 0) {
            [self performSelectorOnMainThread:@selector(dismiss) withObject:nil waitUntilDone:YES];
        }
        @synchronized (toastArray) {
            
            UIWindow *windowView = [UIApplication sharedApplication].delegate.window;
            [windowView addSubview:self];
            [windowView bringSubviewToFront:self];
            [UIView animateWithDuration:0.5f delay:0.f usingSpringWithDamping:0.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.frame = _toastViewFrame;
                self.alpha = _toastAlpha;
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            } completion:nil];
            
            [toastArray addObject:self];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:_duration];
        }
    });
}

/// 显示一个Toast并添加点击回调
- (void)show:(handler)handler {
    [self show];
    if (handler) {
        _handler = handler;
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionWithHandler)];
        [self addGestureRecognizer:tapGesture];
    }
}

- (void)tapActionWithHandler {
    if (_handler) {
        _handler();
    }
    [self dismiss];
}

/// 隐藏一个Toast
- (void)dismiss {
    
    if (toastArray && [toastArray count] > 0) {
        @synchronized (toastArray) {
            
            QYCToast* toast = toastArray[0];
            [NSRunLoop cancelPreviousPerformRequestsWithTarget:toast];
            [toastArray removeObject:toast];
            
            if (self.dismissToastAnimated == YES && _toastPosition != QYCToastPositionBottom && _toastPosition != QYCToastPositionBottomWithFillet) {
                
                CGFloat tempStatusBarHeight = 0;
                if (self.toastPosition == QYCToastPositionDefault) {
                    tempStatusBarHeight = IPHONE_STATUSBAR_HEIGHT;
                }
                
                [UIView animateWithDuration:0.2f animations:^{
                    toast.alpha = 0.f;
                    self.frame = CGRectMake(_toastViewFrame.origin.x, -(_toastViewFrame.size.height + tempStatusBarHeight), _toastViewFrame.size.width, _toastViewFrame.size.height);
                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                } completion:^(BOOL finished) {
                    [toast removeFromSuperview];
                }];
                
            }
            else{
                [UIView animateWithDuration:0.2f animations:^{
                    toast.alpha = 0.f;
                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                } completion:^(BOOL finished) {
                    [toast removeFromSuperview];
                }];
                
            }
            
        }
    }
}

/// 工具
- (CGSize)sizeForAttributedString:(NSAttributedString*)content maxWidth:(CGFloat) maxWidth {
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, maxWidth,HEIGHT)];
    lab.numberOfLines = 0;
    lab.attributedText = content;
    [lab sizeToFit];
    return lab.frame.size;
}

@end
