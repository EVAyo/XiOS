//
//  Account.m
//  Qiyeyun
//
//  Created by 钱立新 on 15/11/19.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import "Account.h"
#import "MJExtension.h"

@interface Account ()

@end

@implementation Account
MJCodingImplementation

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict {
     return [[self alloc] initWithDic:dict];;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"userId":@[@"userId",@"user_id"],@"realName":@[@"realName",@"real_name"]};
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
