//
//  ZLAssets.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 15-1-3.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import "ZLPhotoAssets.h"
#import "MJExtension.h"

@implementation ZLPhotoAssets
MJExtensionCodingImplementation

- (instancetype)initWithALAsset:(ALAsset *)asset {
    if (self = [super init]) {
        self.asset = asset;
        self.assetURL         = [[asset defaultRepresentation] url];
        NSString *type        = [asset valueForProperty:ALAssetPropertyType];
        self.isVideoType      = [type isEqualToString:ALAssetTypeVideo];
    }
    return self;
}

- (UIImage *)aspectRatioImage{
    return [UIImage imageWithCGImage:[self.asset aspectRatioThumbnail]];
}

- (UIImage *)thumbImage{
    return [UIImage imageWithCGImage:[self.asset thumbnail]];
}

@end
