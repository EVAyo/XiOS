//
//  ViewController.m
//  TestPods_OC
//
//  Created by 启业云03 on 2021/3/23.
//

#import "ViewController.h"

//#import <OnlyOCDemo/AllHeader.h>
#import <OnlyOCDemo/FunctionB.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    [FunctionA printSomethingA:@"A打印"];
    
    [FunctionB printSomethingB:@"B打印"];
}


@end
