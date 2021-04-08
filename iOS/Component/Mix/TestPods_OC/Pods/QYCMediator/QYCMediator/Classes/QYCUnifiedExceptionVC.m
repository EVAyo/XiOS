//
//  QYCUnifiedExceptionVC.m
//  QYCMediator
//
//  Created by 启业云 on 2021/1/7.
//  Copyright © 2021 1342294200@qq.com. All rights reserved.
//

#import "QYCUnifiedExceptionVC.h"

typedef NS_ENUM(NSUInteger, PageReturnType) {
    PageReturnTypeNone,
    PageReturnTypePop,
    PageReturnTypeDismiss,
};

@interface QYCUnifiedExceptionVC ()

@property (nonatomic, assign) PageReturnType type;
@end

@implementation QYCUnifiedExceptionVC

- (void)viewDidLoad {
    [super viewDidLoad];

    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = UIColor.systemBackgroundColor;
    } else {
        self.view.backgroundColor = UIColor.whiteColor;
    }
    // Do any additional setup after loading the view.
    UILabel *lab = [[UILabel alloc]init];
    lab.text = @"未集成功能";
    lab.textColor = UIColor.systemGrayColor;
    [lab sizeToFit];
    lab.center = CGPointMake(self.view.center.x, self.view.center.y - 40);;
    [self.view addSubview:lab];

    if (self.navigationController) {//有导航控制器
        NSUInteger count = self.navigationController.childViewControllers.count;
        if (count > 1) {//如果只有当前VC或者一个都没有的话，是
            _type = PageReturnTypePop;
        } else if (count == 0) {
            _type = PageReturnTypeNone;
        } else {//只有当前控制器时
            if (self.navigationController.presentingViewController) {//有present方式显示的父视图
                _type = PageReturnTypeDismiss;
            } else {
                _type = PageReturnTypeNone;
            }
        }
    } else {//没有导航控制器
        if (self.presentingViewController) {
            _type = PageReturnTypeDismiss;
        } else {
            _type = PageReturnTypePop;
        }
    }


    if (_type != PageReturnTypeNone) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
        [btn setTitle:@"知道了" forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
        btn.center = self.view.center;
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }


}

- (void)dismiss {
    if (_type == PageReturnTypePop) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
