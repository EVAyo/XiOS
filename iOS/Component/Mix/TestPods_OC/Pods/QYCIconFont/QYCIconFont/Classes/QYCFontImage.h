//
//  QYCFontImage.h
//  Qiyeyun
//
//  Created by dong on 2017/11/23.
//  Copyright © 2017年 安元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQFontImage.h"

@interface QYCFontImage : HQFontImage
+ (NSMutableAttributedString*)attributedStringIconWithName:(NSString*)name fontSize:(CGFloat)size color:(UIColor*)color;
+ (NSString *)imageCodeWithImageName:(NSString*)imageName;
@end
