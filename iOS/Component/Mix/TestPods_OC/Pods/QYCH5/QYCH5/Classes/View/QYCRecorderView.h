//
//  QYCRecorderView.h
//  Qiyeyun
//
//  Created by AYKJ on 2020/9/10.
//  Copyright © 2020 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    QYCVoiceRecorderStylePlay   = 1, //播放录音
    QYCVoiceRecorderStyleSubmit = 2, //提交
    QYCVoiceRecorderStyleRepet  = 3, //重新录音

} QYCVoiceRecorderButtonStyle;

@interface QYCRecorderView : UIView

@property (nonatomic, copy) void (^startVoiceRecordBlock)(NSString *fileUrl);

/**
 *  初始化方法
 *  @param frame       背景的frame   default is full screen
 *
 */
- (instancetype)initWithRecorderViewWithFrame:(CGRect)frame;

@end
