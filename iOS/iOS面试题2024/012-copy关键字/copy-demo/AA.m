//
//  AA.m
//  copy-test
//
//  Created by 启业云03 on 2024/7/18.
//

#import "AA.h"

@interface AA()

@property (nonatomic, strong) NSString *name;

@property (nonatomic, copy) NSString *title;

@end

@implementation AA

- (void)string_strong {
    NSMutableString *mStr = [NSMutableString stringWithString:@"张三"];

    self.name = mStr;

    NSLog(@"使用strong第一次得到的名字：%@", self.name);

    [mStr appendString:@"丰"];

    NSLog(@"使用strong第二次得到的名字：%@", self.name);
}

- (void)string_copy {
    
    NSMutableString *mStr = [NSMutableString stringWithString:@"张三"];

    self.title = mStr;

    NSLog(@"使用copy第一次得到的名字：%@", self.title);

    [mStr appendString:@"丰"];

    NSLog(@"使用copy第二次得到的名字：%@", self.title);
}

@end
