//
//  ViewController.m
//  TestPods_OC
//
//  Created by 启业云03 on 2021/3/23.
//

#import "ViewController.h"

//#import <OnlyOCDemo/AllHeader.h>
#import <OnlyOCDemo/FunctionB.h>

#import <OnlySwiftDemo/OnlySwiftDemo-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = UIColor.orangeColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 纯OC组件
//    [FunctionA printSomethingA:@"A打印"];
    [FunctionB printSomethingB:@"B打印"];
    
    // 纯Swift组件
    SwiftLibC *C = [[SwiftLibC alloc] init];
    [C show];
}


@end
