//
//  NSObject+QYCExtensionEntId.m
//  Qiyeyun
//
//  Created by dong on 2019/7/10.
//  Copyright © 2019 安元. All rights reserved.
//

#import "NSObject+QYCExtensionEntId.h"
#import <objc/runtime.h>
#import "AccountTool.h"

@implementation NSObject (QYCExtensionEntId)

- (void)setQyc_entId:(NSString *)qyc_entId {
    objc_setAssociatedObject(self, @selector(qyc_entId), qyc_entId, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)qyc_entId {
    id object = objc_getAssociatedObject(self, _cmd);
    //add default value
    if (object == nil) {
        Account *acc = [AccountTool account];
        object       = acc.entId;
    }
    //append space
    if (object) {
        if ([object rangeOfString:@"space"].location == NSNotFound) {
            object = [NSString stringWithFormat:@"space-%@", object];
        }
    }
    return object;
}

- (NSString *)URLPath:(NSString *)path entId:(NSString *)entId {
    return [NSString stringWithFormat:@"space-%@/%@", entId ?: @"", path];
}

- (NSString *)URLPath:(NSString *)path {
    return [NSString stringWithFormat:@"%@/%@", self.qyc_entId, path];
}

- (NSString *)getRealEntId {
    NSRange range = [self.qyc_entId rangeOfString:@"space-"];
    return [self.qyc_entId substringFromIndex:range.location + range.length];
}

@end
