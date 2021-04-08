//
//  UIImage+Image.h
//
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
// instancetype默认会识别当前是哪个类或者对象调用，就会转换成对应的类的对象
// UIImage *

/// 调用不同Bundle中的图片资源，默认 main bundle
/// @param aName 图片名
/// @param aClass 当前调用类Class
/// @param aBundle bundle名
+ (nullable UIImage *)imageNamed:(NSString *_Nonnull)aName aClass:(Class _Nullable)aClass bundle:(NSString *_Nullable)aBundle;

// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;
// 将图片拉伸
+ (instancetype)imageWithStretchableName:(NSString *)imageName;
// 将图片变成圆形
+ (UIImage *)circleImage:(UIImage *)image;

+ (instancetype)ml_imageFromBundleNamed:(NSString *)name;
//等比例缩放
- (UIImage *)scaleToSize:(CGSize)size;
//指定宽度按比例缩放
- (UIImage *)imageCompressForWidth:(CGFloat)defineWidth;
// 缩放从顶部开始平铺图片
- (UIImage *)imageScaleAspectFillFromTop:(CGSize)frameSize;
//
- (UIImage *)subImageInRect:(CGRect)rect;
//
- (UIImage *)imageFillSize:(CGSize)viewsize;
//
- (UIImage *)fixOrientation;
//获取头像
//- (UIImage *)getheadImageWithUserId:(NSString *)userId;
/**
 *  给图片加水印图片
 *
 *  @param image   水印图片
 *  @param imgRect 水印图片所在位置，大小
 *  @param alpha   水印图片的透明度，0~1之间，透明度太大会完全遮盖被加水印图片的那一部分
 *
 *  @return 加完水印的图片
 */
- (UIImage *)imageWaterMarkWithImage:(UIImage *)image imageRect:(CGRect)imgRect alpha:(CGFloat)alpha;
/**
 *  给图片加文字水印
 *
 *  @param str     水印文字
 *  @param strRect 文字所在的位置大小
 *  @param attri   文字的相关属性，自行设置
 *
 *  @return 加完水印文字的图片
 */
- (UIImage *)imageWaterMarkWithString:(NSString *)str rect:(CGRect)strRect attribute:(NSDictionary *)attri;
/**
 *  同上
 *
 *  @param str     同上
 *  @param strRect 文字的位置大小
 *  @param attri   同上
 *  @param image   同上
 *  @param imgRect 图片的位置大小
 *  @param alpha   透明度
 *
 *  @return 同上
 */
- (UIImage *)imageWaterMarkWithString:(NSString *)str rect:(CGRect)strRect attribute:(NSDictionary *)attri image:(UIImage *)image imageRect:(CGRect)imgRect alpha:(CGFloat)alpha;

//获取图片的MIMEType
+ (NSString *)imageMIMETypeByImageData:(NSData *)data;
//获取图片的扩展名
+ (NSString *)getExtensionByImageData:(NSData *)data;
//通过图片NSData来获取图片的size大小
+ (CGSize)getImageSizeWithData:(NSData *)data;
@end
