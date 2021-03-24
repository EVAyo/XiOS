//
//  FunctionD_OC.m
//  OCAddSwiftDemo
//
//  Created by 启业云03 on 2021/3/24.
//

#import "FunctionD_OC.h"

#import <Alamofire/Alamofire-Swift.h>

#import <OnlySwiftDemo/OnlySwiftDemo-Swift.h>

#import <OCAddSwiftDemo/OCAddSwiftDemo-Swift.h>

@implementation FunctionD_OC

+ (void)printSomething:(NSString *)log {
    NSLog(@"FunctionD_OC 打印：%@", log);
}

+ (void)useSwiftSource {
    SwiftLibD *D = [[SwiftLibD alloc] init];
    [D show:@"456"];
}

+ (void)useSwiftPod {
    SwiftLibC *C = [[SwiftLibC alloc] init];
    [C show];
}

@end
