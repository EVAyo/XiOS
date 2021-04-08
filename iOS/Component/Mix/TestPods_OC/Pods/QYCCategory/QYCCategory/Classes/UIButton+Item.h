//
//  UIButton+Item.h
//  Qiyeyun
//
//  Created by 钱立新 on 15/12/15.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LXImagePosition) {
    LXImagePositionLeft   = 0, /**图片在左，文字在右，默认*/
    LXImagePositionRight  = 1, /**图片在右，文字在左*/
    LXImagePositionTop    = 2, /**图片在上，文字在下*/
    LXImagePositionBottom = 3, /**图片在下，文字在上*/
};

@interface UIButton (Item)

@property (nonatomic, assign) BOOL recordPosition;  ///< 是否记录手势相对屏幕的坐标位置
@property (nonatomic, assign) CGPoint relativePoint;  ///< 手势相对窗口的坐标

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

/**
 创建带圆角的button
 
 @param frame frame
 @param corner 需要设置的圆角
 @param radius 圆角半径
 @return 返回圆角按钮
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame ByRoundingCorners:(UIRectCorner)corner cornerRadius:(CGFloat)radius;

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(LXImagePosition)postion spacing:(CGFloat)spacing;

/**
 设置图片与文字样式

 @param postion 图片位置样式
 @param spacing 图片与文字之间的间距
 @param imagePositionBlock 在此 Block 中设置按钮的图片、文字以及 contentHorizontalAlignment 属性
 */
- (void)setImagePosition:(LXImagePosition)postion spacing:(CGFloat)spacing imagePositionBlock:(void (^)(UIButton *btn))imagePositionBlock;

@end
