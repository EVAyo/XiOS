//
//  QRView.m
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/4/25.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import "QRView.h"
#import "QRUtil.h"
#import "QYCScanDefine.h"
// 依赖
#import <QYCIconFont/QYCIconFont.h>

static NSTimeInterval kQrLineanimateDuration = 0.005;

@interface QRView ()
/// 手电筒按钮
@property (nonatomic, strong) UIButton *flashlightBtn;
/// 定时器
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation QRView {
    UIImageView *qrLine;
    CGFloat qrLineY;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    // NSLog(@"%s", __func__);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!qrLine) {
        [self initQRLine];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:kQrLineanimateDuration target:self selector:@selector(show) userInfo:nil repeats:YES];
        // 将定时器添加到run loop
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
        // 触发定时器
        [self.timer fire];
    }

    if (!self.flashlightBtn) {
        [self initQrMenu];
    }
}

/// 关闭定时器
- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)initQRLine {
    CGRect screenBounds = [QRUtil screenBounds];
    qrLine              = [[UIImageView alloc] initWithFrame:CGRectMake(screenBounds.size.width / 2 - self.transparentArea.width / 2, screenBounds.size.height / 2 - self.transparentArea.height / 2, self.transparentArea.width, 5)];
    
    // 获取当前bundle路径
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *ScanBudleURL = [bundle URLForResource:@"QYCScan" withExtension:@"bundle"];
    NSBundle *ScanBudle = [NSBundle bundleWithURL:ScanBudleURL];
    // 获取图片
    qrLine.image = [UIImage imageNamed:@"work_scan_line" inBundle:ScanBudle compatibleWithTraitCollection:nil];
    
    [self addSubview:qrLine];
    qrLineY = qrLine.frame.origin.y;
}

- (void)initQrMenu {
    CGFloat width = [QRUtil screenBounds].size.width;

    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    label.center        = CGPointMake(self.center.x, self.center.y + self.transparentArea.height / 2 + 35);
    label.text          = QYCScanLocalizedString(@"将二维码放入框内，即可自动扫描");
    label.font          = [UIFont systemFontOfSize:15];
    label.textColor     = QYCColor(HexColor(0xFFFFFF), HexColor(0xFFFFFF));
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    UIButton *flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [QYCFontImage iconWithName:@"light-off" fontSize:25 color:QYCColor(HexColor(0xFFFFFF), HexColor(0xC4C4C4))];
    [flashBtn setImage:normalImage forState:UIControlStateNormal];
    UIImage *seletImage = [QYCFontImage iconWithName:@"light-on" fontSize:25 color:QYCColor(HexColor(0xFFFFFF), HexColor(0xC4C4C4))];
    [flashBtn setImage:seletImage forState:UIControlStateSelected];
    [flashBtn addTarget:self action:@selector(flashlightSwitchClick:) forControlEvents:UIControlEventTouchUpInside];
    self.flashlightBtn = flashBtn;
    
    self.flashlightBtn.frame               = CGRectMake(self.center.x - self.transparentArea.width / 2, CGRectGetMaxY(label.frame) + 25, 45, 45);
    self.flashlightBtn.backgroundColor     = QYCColor(HexColorAlpha(0x000000, 0.5), HexColorAlpha(0x000000, 0.5));
    self.flashlightBtn.layer.cornerRadius  = 22.5f;
    self.flashlightBtn.layer.masksToBounds = YES;
    [self addSubview:self.flashlightBtn];

    
    UIButton *albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage1 = [QYCFontImage iconWithName:@"zhaopian" fontSize:25 color:QYCColor(HexColor(0xFFFFFF), HexColor(0xC4C4C4))];
    [albumBtn setImage:normalImage1 forState:UIControlStateNormal];
    UIImage *seletImage1 = [QYCFontImage iconWithName:@"zhaopian" fontSize:25 color:QYCColor(HexColor(0xFFFFFF), HexColor(0xC4C4C4))];
    [albumBtn setImage:seletImage1 forState:UIControlStateSelected];
    [albumBtn addTarget:self action:@selector(scanPhotoAlbumClick) forControlEvents:UIControlEventTouchUpInside];
    
    albumBtn.frame               = CGRectMake(self.center.x + self.transparentArea.width / 2 - 40, CGRectGetMaxY(label.frame) + 25, 45, 45);
    albumBtn.backgroundColor     = QYCColor(HexColorAlpha(0x000000, 0.5), HexColorAlpha(0x000000, 0.5));
    albumBtn.layer.cornerRadius  = 22.5f;
    albumBtn.layer.masksToBounds = YES;
    [self addSubview:albumBtn];
}

//切换手电筒开关
- (void)flashlightSwitchClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    !self.lightImgClick ?: self.lightImgClick(sender.selected);
}

//扫描相册
- (void)scanPhotoAlbumClick {
    if (self.scanPhotoAlbumBlock) {
        self.scanPhotoAlbumBlock();
    }
}

- (void)resetLightStatus {
    self.flashlightBtn.selected = YES;
    [self flashlightSwitchClick:self.flashlightBtn];
}

- (void)show {
    [UIView animateWithDuration:kQrLineanimateDuration
        animations:^{
            CGRect rect   = qrLine.frame;
            rect.origin.y = qrLineY;
            qrLine.frame  = rect;
        }
        completion:^(BOOL finished) {
            CGFloat maxBorder = self.frame.size.height / 2 + self.transparentArea.height / 2 - 4;
            if (qrLineY > maxBorder) {
                qrLineY = self.frame.size.height / 2 - self.transparentArea.height / 2;
            }
            qrLineY++;
        }];
}

- (void)drawRect:(CGRect)rect {
    //整个二维码扫描界面的颜色
    //    CGSize screenSize =[QRUtil screenBounds].size;
    CGSize screenSize     = self.frame.size;
    CGRect screenDrawRect = CGRectMake(0, 0, screenSize.width, screenSize.height);

    //中间清空的矩形框
    CGRect clearDrawRect = CGRectMake(screenDrawRect.size.width / 2 - self.transparentArea.width / 2,
                                      screenDrawRect.size.height / 2 - self.transparentArea.height / 2,
                                      self.transparentArea.width,
                                      self.transparentArea.height);

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self addScreenFillRect:ctx rect:screenDrawRect];

    [self addCenterClearRect:ctx rect:clearDrawRect];

    [self addWhiteRect:ctx rect:clearDrawRect];

    [self addCornerLineWithContext:ctx rect:clearDrawRect];
}

- (void)addScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    CGContextSetRGBFillColor(ctx, 40 / 255.0, 40 / 255.0, 40 / 255.0, 0.5);
    CGContextFillRect(ctx, rect); //draw the transparent layer
}

- (void)addCenterClearRect:(CGContextRef)ctx rect:(CGRect)rect {
    CGContextClearRect(ctx, rect); //clear the center rect  of the layer
}

- (void)addWhiteRect:(CGContextRef)ctx rect:(CGRect)rect {
    CGContextStrokeRect(ctx, rect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 0.8);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

- (void)addCornerLineWithContext:(CGContextRef)ctx rect:(CGRect)rect {
    //画四个边角
    CGContextSetLineWidth(ctx, 4);
    CGContextSetRGBStrokeColor(ctx, 62 / 255.0, 119 / 255.0, 244 / 255.0, 1); //蓝色

    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x + 0.7, rect.origin.y),
        CGPointMake(rect.origin.x + 0.7, rect.origin.y + 15)};

    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y + 0.7), CGPointMake(rect.origin.x + 15, rect.origin.y + 0.7)};
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];

    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x + 0.7, rect.origin.y + rect.size.height - 15), CGPointMake(rect.origin.x + 0.7, rect.origin.y + rect.size.height)};
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y + rect.size.height - 0.7), CGPointMake(rect.origin.x + 0.7 + 15, rect.origin.y + rect.size.height - 0.7)};
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];

    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x + rect.size.width - 15, rect.origin.y + 0.7), CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + 0.7)};
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x + rect.size.width - 0.7, rect.origin.y), CGPointMake(rect.origin.x + rect.size.width - 0.7, rect.origin.y + 15 + 0.7)};
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];

    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x + rect.size.width - 0.7, rect.origin.y + rect.size.height + -15), CGPointMake(rect.origin.x - 0.7 + rect.size.width, rect.origin.y + rect.size.height)};
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x + rect.size.width - 15, rect.origin.y + rect.size.height - 0.7), CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - 0.7)};
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    CGContextStrokePath(ctx);
}

- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx {
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
}

@end
