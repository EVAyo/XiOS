//
//  QYCAssets.m
//  QYCAssets
//
//  Created by 启业云03 on 2020/12/31.
//

#import "QYCAssets.h"

@implementation QYCAssets

// load from QYCAssets bundle
+ (nullable UIImage *)imageNamed:(NSString *)name {
    if (name) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *url       = [bundle URLForResource:@"QYCAssets" withExtension:@"bundle"];
        if (url) {
            NSBundle *imageBundle = [NSBundle bundleWithURL:url];
            UIImage *image        = [UIImage imageNamed:name inBundle:imageBundle compatibleWithTraitCollection:nil];
            return image;
        }
    }
    return nil;
}

@end
