//
//  QYCLinkShareViewController.m
//  Qiyeyun
//
//  Created by dong on 2017/10/1.
//  Copyright © 2017年 安元. All rights reserved.
//

#import "QYCLinkShareViewController.h"
#import "QYCH5Config.h"
#import <QYCCategory/UIColor+QYCColor.h>
#import <QYCCategory/UIImage+Image.h>

@interface QYCLinkShareViewController ()
@property (weak, nonatomic) IBOutlet UIButton *forward_btn;
@property (weak, nonatomic) IBOutlet UIButton *share_btn;
@property (weak, nonatomic) IBOutlet UIButton *linkCopy_btn;
@property (weak, nonatomic) IBOutlet UIButton *refresh_btn;
@property (weak, nonatomic) IBOutlet UIButton *openBrower_btn;
@property (weak, nonatomic) IBOutlet UIView *forward_view;
@property (weak, nonatomic) IBOutlet UIView *share_view;
@property (weak, nonatomic) IBOutlet UIView *linkCopy_view;
@property (weak, nonatomic) IBOutlet UIView *openBrower_view;
@property (weak, nonatomic) IBOutlet UIView *refresh_view;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (weak, nonatomic) IBOutlet UILabel *forward_lab;
@property (weak, nonatomic) IBOutlet UILabel *share_lab;
@property (weak, nonatomic) IBOutlet UILabel *linkCopy_lab;
@property (weak, nonatomic) IBOutlet UILabel *openBrower_lab;
@property (weak, nonatomic) IBOutlet UILabel *refresh_lab;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@end

@implementation QYCLinkShareViewController

#pragma mark - ================ LifeCycle =================

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_initSubView];
}

#pragma mark - Delegate Method
#pragma mark - EventResponse Method

#pragma mark - ================ Private Methods =================

- (void)p_initSubView {
    self.view.backgroundColor = KQYCColorAlpha(ffffff, .1, ffffff, .1); // [UIColor colorWithWhite:1 alpha:0.1];
    // setImage
    [self.forward_btn setImage:[UIImage imageNamed:@"webshare" aClass:self.class bundle:QYCH5] forState:UIControlStateNormal];
    [self.share_btn setImage:[UIImage imageNamed:@"H5_工作圈" aClass:self.class bundle:QYCH5] forState:UIControlStateNormal];
    [self.linkCopy_btn setImage:[UIImage imageNamed:@"weblink" aClass:self.class bundle:QYCH5] forState:UIControlStateNormal];
    [self.refresh_btn setImage:[UIImage imageNamed:@"webRefresh" aClass:self.class bundle:QYCH5] forState:UIControlStateNormal];
    [self.openBrower_btn setImage:[UIImage imageNamed:@"websafari" aClass:self.class bundle:QYCH5] forState:UIControlStateNormal];

    [self initCornerView:self.forward_btn];
    [self initCornerView:self.share_btn];
    [self initCornerView:self.linkCopy_btn];
    [self initCornerView:self.refresh_btn];
    [self initCornerView:self.openBrower_btn];
    self.bg_view.backgroundColor         = KQYCColor(ffffff, 1e1e1e);
    self.line.backgroundColor            = KQYCColor(e7e9ed, 333333);
    self.forward_view.backgroundColor    = KQYCColor(ffffff, 1e1e1e);
    self.share_view.backgroundColor      = KQYCColor(ffffff, 1e1e1e);
    self.linkCopy_view.backgroundColor   = KQYCColor(ffffff, 1e1e1e);
    self.openBrower_view.backgroundColor = KQYCColor(ffffff, 1e1e1e);
    self.refresh_view.backgroundColor    = KQYCColor(ffffff, 1e1e1e);
    self.forward_lab.textColor           = KQYCColor(666666, a0a0a0);
    self.share_lab.textColor             = KQYCColor(666666, a0a0a0);
    self.linkCopy_lab.textColor          = KQYCColor(666666, a0a0a0);
    self.openBrower_lab.textColor        = KQYCColor(666666, a0a0a0);
    self.refresh_lab.textColor           = KQYCColor(666666, a0a0a0);
    [self.cancleBtn setTitleColor:KQYCColor(333333, c4c4c4) forState:UIControlStateNormal];
    //工作圈模块存在可分享工作圈
    NSNumber *workCircleMoudle = [[NSUserDefaults standardUserDefaults] objectForKey:@"hasWorkCircle"];
    BOOL hasWorkCircle         = workCircleMoudle && [workCircleMoudle isEqual:@1];
    self.share_view.hidden     = !hasWorkCircle;
    //启聊模块存在可转发
    NSNumber *qiChatMoudle   = [[NSUserDefaults standardUserDefaults] objectForKey:@"hasQiChat"];
    BOOL hasQiChat           = qiChatMoudle && [qiChatMoudle isEqual:@1];
    self.forward_view.hidden = !hasQiChat;
}

#pragma mark - ================ Getter and Setter =================

- (IBAction)cancelBtnClick:(id)sender {
    !_dissMissAction ?: _dissMissAction();
    [self dismissViewControllerAnimated:nil completion:nil];
}

- (IBAction)btnClick:(UIButton *)sender {
    !_dissMissAction ?: _dissMissAction();
    [self dismissViewControllerAnimated:nil completion:nil];
    switch (sender.tag) {
        case 999:
            if (self.operationClick) {
                self.operationClick(OperationTypeForward);
            }
            break;
        case 1000:
            if (self.operationClick) {
                self.operationClick(OperationTypeRelay);
            }
            break;
        case 1001:
            if (self.operationClick) {
                self.operationClick(OperationTypeCopy);
            }
            break;
        case 1002:
            if (self.operationClick) {
                self.operationClick(OperationTypeOpenLink);
            }
            break;
        case 1003:
            if (self.operationClick) {
                self.operationClick(OperationTypeRefresh);
            }
            break;

        default:
            break;
    }
}

- (void)initCornerView:(UIButton *)btn {
    btn.layer.cornerRadius = 10;
    //    btn.layer.shadowOffset = CGSizeMake(0, 0);
    //    btn.layer.shadowColor = KQYCColor(000000, ffffff).CGColor;
    //    btn.layer.shadowRadius = 4;
    //    btn.layer.shadowOpacity = 0.1;
    btn.layer.backgroundColor = KQYCColor(f6f7f8, 2c2c2c).CGColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:nil completion:nil];
    !_dissMissAction ?: _dissMissAction();
}

@end
