//
//  QRView.h
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/4/25.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRView : UIView

/// 透明的区域
@property (nonatomic, assign) CGSize transparentArea;

@property (nonatomic, copy) void (^lightImgClick)(BOOL open);

@property (nonatomic, copy) dispatch_block_t scanPhotoAlbumBlock;

/// 关闭定时器
- (void)removeTimer;

- (void)resetLightStatus;

@end
