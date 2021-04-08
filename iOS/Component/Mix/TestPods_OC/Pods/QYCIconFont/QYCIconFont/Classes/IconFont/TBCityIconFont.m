//
//  TBCityIconFont.m
//  iCoupon
//
//  Created by John Wong on 10/12/14.
//  Copyright (c) 2014 Taodiandian. All rights reserved.
//

#import "TBCityIconFont.h"
#import <CoreText/CoreText.h>

@implementation TBCityIconFont

static NSString *_fontName;

+ (void)registerFontWithURL:(NSURL *)url {
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath:[url path]], @"Font file doesn't exist");
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)url);
    CGFontRef newFont = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(newFont, nil);
    CGFontRelease(newFont);
}

+ (UIFont *)fontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:[self fontName] size:size];
    if (font == nil) {
        // 方法一
        NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:@"/QYCIconFont.bundle"];
        NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
        NSURL *fontFileUrl = [resource_bundle URLForResource:[self fontName] withExtension:@"ttf"];
        
        [self registerFontWithURL: fontFileUrl];
        font = [UIFont fontWithName:[self fontName] size:size];
        NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    }
    return font;
}

+ (UIFont *)fontWithSize: (CGFloat)size withFontName:(NSString*)fontName
{
    UIFont *font = [UIFont fontWithName:fontName size:size];
    if (font == nil) {
        // 方法二
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *IconFontBudleURL = [bundle URLForResource:@"QYCIconFont" withExtension:@"bundle"];
        NSBundle *IconFontBudle = [NSBundle bundleWithURL:IconFontBudleURL];
        NSURL *fontFileUrl = [IconFontBudle URLForResource:fontName withExtension:@"ttf"];
        
        [self registerFontWithURL: fontFileUrl];
        font = [UIFont fontWithName:fontName size:size];
        NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    }
    return font;
}

+ (void)setFontName:(NSString *)fontName {
    _fontName = fontName;
}

+ (NSString *)fontName {
    return _fontName ? : @"LLIconfont";
}

@end
