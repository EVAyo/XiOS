//
//  ZHXZFontImage.h
//  Qiyeyun
//
//  Created by 张伟 on 2019/9/17.
//  Copyright © 2019 安元. All rights reserved.
//  中化物流港图片库 单独处理

#import "HQFontImage.h"

@interface ZHXZFontImage : HQFontImage

+ (NSMutableAttributedString*)attributedStringIconWithName:(NSString*)name fontSize:(CGFloat)size color:(UIColor*)color;
+ (NSString *) imageCodeWithImageName:(NSString*)imageName;

@end


