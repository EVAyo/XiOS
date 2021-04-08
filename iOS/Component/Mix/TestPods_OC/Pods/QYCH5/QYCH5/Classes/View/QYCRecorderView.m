//
//  QYCRecorderView.m
//  Qiyeyun
//
//  Created by AYKJ on 2020/9/10.
//  Copyright © 2020 安元. All rights reserved.
//

#import "QYCRecorderView.h"
#import "QYCH5Config.h"
#import <AVFoundation/AVFoundation.h>
#import <QYCCategory/UIAlertController+Alert.h>
#import <QYCCategory/UIImage+Image.h>
#import <QYCCategory/UIViewController+QYCCurrentVC.h>
#import <SDWebImage/UIImage+GIF.h>
#import <YYCategories/UIColor+YYAdd.h>

NSString *const timeStr    = @"00:00:00";
NSString *const labelTitle = @"按住录音";
#define CommonRed_Color [UIColor colorWithHexString:@"Fb586c"]

@interface QYCRecorderView () <AVAudioPlayerDelegate>

@property (nonatomic, strong) UIView *actionSheetView;
@property (nonatomic, assign) CGFloat activityHeight;
@property (nonatomic, assign) BOOL isHadTimeTitle;
@property (nonatomic, assign) BOOL isHadRecorderButton;
@property (nonatomic, assign) BOOL isHadRecordeLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *recordImageView;
@property (nonatomic, strong) UILabel *recordeLabel;
//播放
@property (nonatomic, strong) UIButton *playBtn;
//提交
@property (nonatomic, strong) UIButton *submitBtn;
//重新录音
@property (nonatomic, strong) UIButton *repetBtn;

/**录音*/
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, assign) BOOL isRecording;
@property (nonatomic, strong) NSString *recordingFilePath;
@property (nonatomic, strong) NSString *sessionCategory;
/**播放*/
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSString *finalTimeStr;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) BOOL isHeadPhone;

@end

@implementation QYCRecorderView {
    NSTimer *_timer;

    NSUInteger _hour;
    NSUInteger _minite;
    NSUInteger _second;
    NSUInteger _count;
    BOOL _isRunning;
}

#pragma mark---------------------- 实例化方法 ----------------------------
- (instancetype)initWithRecorderViewWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //创建UI
        [self setupUI];

        _isHeadPhone = [self isHeadsetPluggedIn];

        //创建录音文件
        [self createRecordFile];
        //添加定时器
        [self createTimer];
    }
    return self;
}

#pragma mark---------------------- UI ----------------------------
- (void)setupUI {
    //背景视图层
    self.backgroundColor               = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.userInteractionEnabled        = YES;
    self.frame                         = CGRectMake(0, 0, WIDTH_H5, HEIGHT_H5);
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];

    //actionSheetview
    [self createSubView];

    //初始化相关控件
    [self createButtonWithTimeTitle:timeStr
                   recordLabelTitle:labelTitle];
}

- (void)createSubView {
    self.isHadTimeTitle      = NO;
    self.isHadRecorderButton = NO;
    self.isHadRecordeLabel   = NO;

    //初始化ACtionView的高度
    self.activityHeight = 260 + stateIncrement_H5();

    //生成ActionSheetView
    self.actionSheetView                 = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_H5, WIDTH_H5, 0)];
    self.actionSheetView.backgroundColor = [UIColor whiteColor];

    //添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedactionSheetView)];
    [self.actionSheetView addGestureRecognizer:tapGesture];
    [self addSubview:self.actionSheetView];
}

//初始化相关控件
- (void)createButtonWithTimeTitle:(NSString *)title recordLabelTitle:(NSString *)recordLabTitle {
    //时间label
    if (title) {
        self.isHadTimeTitle = YES;
        self.timeLabel      = [self createTimeLabelWithTitle:title];
        [self.actionSheetView addSubview:self.timeLabel];
    }

    //录音ImageView
    self.isHadRecorderButton = YES;
    self.recordImageView     = [self createVoiceRecordButton];
    [self.actionSheetView addSubview:self.recordImageView];

    //录音label
    if (recordLabTitle) {
        [self createRecordLabelWithRecordLabTitle:recordLabTitle];
    }

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [weakSelf.actionSheetView setFrame:CGRectMake(0, HEIGHT_H5 - weakSelf.activityHeight, WIDTH_H5, weakSelf.activityHeight)];
                     }];
}

//布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark---------------------- 判断当前音频设备状态 ----------------------------
- (BOOL)isHeadsetPluggedIn {
    AVAudioSessionRouteDescription *route = [[AVAudioSession sharedInstance] currentRoute];
    for (AVAudioSessionPortDescription *desc in [route outputs]) {
        if ([[desc portType] isEqualToString:AVAudioSessionPortHeadphones]) {
            NSLog(@"%@", desc);
            return YES;
        }
    }
    return NO;
}

#pragma mark---------------------- 创建储存录音文件 ----------------------------
- (void)createRecordFile {
    //m4a格式的文件
    NSString *fileName     = [[NSProcessInfo processInfo] globallyUniqueString];
    self.recordingFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a", fileName]];
    //    NSLog(@"存储的地址%@", self.recordingFilePath);
    //设置后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];

    //判断后台有没有播放
    if (!session) {
        NSLog(@"Error creating session:%@", sessionError.description);
    }
    else {
        [session setActive:YES error:nil];
    }
}

//删除录音文件
- (void)removeRecorderFile {
    [[NSFileManager defaultManager] removeItemAtPath:self.recordingFilePath error:nil];
}

#pragma mark---------------------- 长按手势触发事件 ----------------------------
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) { //手势开始
        //长按手势触发改变UI
        [self gestureBeginWithChangeUI];
        //开始计时器
        [_timer setFireDate:[NSDate distantPast]];
        //开始录音
        [self recordBegin];
    }
    else if (longPress.state == UIGestureRecognizerStateEnded) { //手势结束
        if (_second < 1) {                                       //手势触发小于1s
            UIAlertController *alertVC = [UIAlertController alertShowWithTitle:@"录音时间过短" message:@"" confirm:@"确定"];
            [[UIViewController currentViewController] presentViewController:alertVC animated:YES completion:nil];

            //结束计时器
            [_timer setFireDate:[NSDate distantFuture]];
            _count       = 0;
            _isRecording = NO;
            [self.recordeLabel removeFromSuperview];
            [self createRecordLabelWithRecordLabTitle:labelTitle];
            self.timeLabel.text        = timeStr;
            self.recordImageView.image = [UIImage imageNamed:@"icon_voice_record" aClass:self.class bundle:QYCH5];
            //移除录音
            [self removeRecorderFile];
        }
        else {
            //结束录音
            [self.audioRecorder stop];
            //结束计时器
            [_timer setFireDate:[NSDate distantFuture]];
            //更新UI
            [self gestureEndWithUpDateUI];
            self.finalTimeStr = self.timeLabel.text;
        }
    }
}

#pragma mark---------------------- 录音相关 ----------------------------
- (void)recordBegin {
    _isRecording   = YES;
    self.isPlaying = NO;

    //录音属性相关
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    //音频格式 kAudioFormatLinearPCM会将未压缩的音频流写入文件中。 这中格式保真度最高   kAudioFormatMPEG4AAC的压缩格式会显著缩小文件，还能保证高质量的音频内容
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //采样率 单位HZ 一般标准的采样率为8000、16000、22050和44100  采样率必须要设为11025才能使转化成mp3格式后不会失真
    [recordSetting setValue:[NSNumber numberWithFloat:11025.0] forKey:AVSampleRateKey];
    //通道数  定义记录音频内容的通道数。默认值为1意味着使用单声道录制，设置为2采用立体声录制。
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    //比特率  8 16 24 32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVEncoderBitDepthHintKey];
    //声音质量
    [recordSetting setValue:@(AVAudioQualityMedium) forKey:AVEncoderAudioQualityKey];

    //    ① AVAudioQualityMin  = 0, 最小的质量
    //    ② AVAudioQualityLow  = 0x20, 比较低的质量
    //    ③ AVAudioQualityMedium = 0x40, 中间的质量
    //    ④ AVAudioQualityHigh  = 0x60,高的质量
    //    ⑤ AVAudioQualityMax  = 0x7F 最好的质量
    //    5.AVEncoderBitRateKey 音频编码的比特率 单位Kbps 传输的速率 一般设置128000 也就是128kbps

    //判断录音文件是否为空
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.recordingFilePath]) {
        [self removeRecorderFile];
    }

    _sessionCategory = [[AVAudioSession sharedInstance] category];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];

    //开始录音
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:self.recordingFilePath] settings:recordSetting error:nil];
    //准备记录录音
    [self.audioRecorder prepareToRecord];
    //启动或者恢复记录的录音文件
    [self.audioRecorder record];
}

- (void)playOfRecordForAutomic {
    self.isPlaying = YES;

    _sessionCategory = [[AVAudioSession sharedInstance] category];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSError *playError;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.recordingFilePath] error:&playError];
    if (!self.audioPlayer) {
        NSLog(@"%@", playError.description);
    }
    self.audioPlayer.delegate = self;
}

//当播放结束后调用这个方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    //按钮标题变为播放
    [self.playBtn setImage:[UIImage imageNamed:@"icon_voice_play" aClass:self.class bundle:QYCH5] forState:UIControlStateNormal];
    [_timer setFireDate:[NSDate distantFuture]];
    self.isPlaying = NO;
}

#pragma mark---------------------- 定时器相关 ----------------------------
- (void)createTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerGo) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantFuture]];
    _isRunning = NO;
}

- (void)timerGo {
    //改变Label的文本
    _second             = ++_count / 10 % 60;
    _minite             = _count / 10 / 60 % 60;
    _hour               = _count / 10 / 60 / 60 % 24;
    self.timeLabel.text = [NSString stringWithFormat:@"%.2lu:%.2lu:%.2lu", (unsigned long)_hour, (unsigned long)_minite, (unsigned long)_second];
}

#pragma mark - 更新改变UI相关
//长按手势触发改变UI
- (void)gestureBeginWithChangeUI {
    NSInteger scale = 2;
    if ([UIScreen mainScreen].scale > 2) {
        scale = [UIScreen mainScreen].scale;
    }
    NSString *imageStr         = [NSString stringWithFormat:@"recording_automic@%ldx", (long)scale];
    NSString *filePath         = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:imageStr ofType:@"gif"];
    NSData *imageData          = [NSData dataWithContentsOfFile:filePath];
    self.recordImageView.image = [UIImage sd_animatedGIFWithData:imageData];
    //改变颜色 红底白字
    self.recordeLabel.backgroundColor   = CommonRed_Color;
    self.recordeLabel.textColor         = [UIColor whiteColor];
    self.recordeLabel.layer.borderColor = CommonRed_Color.CGColor;
}

//长按手势结束更新UI
- (void)gestureEndWithUpDateUI {
    //先移除之前的控件
    [self.recordImageView removeFromSuperview];
    [self.recordeLabel removeFromSuperview];

    //播放button
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn setImage:[UIImage imageNamed:@"icon_voice_play" aClass:self.class bundle:QYCH5] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"icon_voice_play" aClass:self.class bundle:QYCH5] forState:UIControlStateSelected];
    [self.playBtn addTarget:self action:@selector(recordeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.playBtn.tag   = QYCVoiceRecorderStylePlay;
    self.playBtn.frame = CGRectMake(WIDTH_H5 / 2 - 40, CGRectGetMaxY(self.timeLabel.frame) + 25, 80, 80);
    [self.actionSheetView addSubview:self.playBtn];

    //提交button
    self.submitBtn                 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.backgroundColor = UIColorHex(Fb586c);
    [self.submitBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.submitBtn addTarget:self action:@selector(recordeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.submitBtn.tag   = QYCVoiceRecorderStyleSubmit;
    self.submitBtn.frame = CGRectMake(WIDTH_H5 / 2 - 65, CGRectGetMaxY(self.playBtn.frame) + 10, 130, 36);
    //提交按钮 和之前的录音label同宽 36
    self.submitBtn.clipsToBounds      = YES;
    self.submitBtn.layer.cornerRadius = 36 / 2;
    self.submitBtn.layer.borderWidth  = 1;
    self.submitBtn.layer.borderColor  = CommonRed_Color.CGColor;
    [self.actionSheetView addSubview:self.submitBtn];

    //重录button
    self.repetBtn                 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.repetBtn.backgroundColor = [UIColor whiteColor];
    [self.repetBtn setTitle:@"重新录制" forState:UIControlStateNormal];
    [self.repetBtn setTitleColor:UIColorHex(393a3c) forState:UIControlStateNormal];
    self.repetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.repetBtn addTarget:self action:@selector(recordeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.repetBtn.tag                = QYCVoiceRecorderStyleRepet;
    self.repetBtn.frame              = CGRectMake(WIDTH_H5 / 2 - 65, CGRectGetMaxY(self.submitBtn.frame) + 10, 130, 36);
    self.repetBtn.clipsToBounds      = YES;
    self.repetBtn.layer.cornerRadius = 36 / 2;
    self.repetBtn.layer.borderWidth  = 1;
    self.repetBtn.layer.borderColor  = UIColorHex(ebeff2).CGColor;
    [self.actionSheetView addSubview:self.repetBtn];
}

#pragma mark----------------------  Actions ----------------------------
- (void)recordeButtonClicked:(UIButton *)sender {
    switch (sender.tag) {
        case QYCVoiceRecorderStylePlay: { //播放
            if (self.isPlaying == NO) {
                //开始播放
                self.isPlaying = YES;
                _count         = 0;
                [_timer setFireDate:[NSDate distantPast]];
                [self playOfRecordForAutomic];
                [self.audioPlayer play];
                [self.playBtn setImage:[UIImage imageNamed:@"icon_voice_pause" aClass:self.class bundle:QYCH5] forState:UIControlStateNormal];
            }
            else {
                self.timeLabel.text = self.finalTimeStr;
                self.isPlaying      = NO;
                [self.audioPlayer pause];
                [_timer setFireDate:[NSDate distantFuture]];
                [self.playBtn setImage:[UIImage imageNamed:@"icon_voice_play" aClass:self.class bundle:QYCH5] forState:UIControlStateNormal];
            }
        } break;
        case QYCVoiceRecorderStyleSubmit: { //提交
            _isRecording = NO;
            if (self.startVoiceRecordBlock) {
                self.startVoiceRecordBlock(self.recordingFilePath);
            }
            [self tappedCancel];

        } break;
        case QYCVoiceRecorderStyleRepet: { //重新录制
            __weak typeof(self) weakSelf = self;
            UIAlertController *alertVC   = [UIAlertController alertShowWithTitle:@"是否重新录音"
                                                                       message:@"如果重新录音,之前录音会被删除"
                                                                       confirm:@"确定"
                                                                confirmHandler:^{
                                                                    //停止录音
                                                                    [weakSelf.audioPlayer stop];
                                                                    //移除录音
                                                                    [weakSelf removeRecorderFile];
                                                                    //重载UI
                                                                    [weakSelf reloadRecordView];
                                                                    weakSelf.isRecording = NO;
                                                                }];
            [[UIViewController currentViewController] presentViewController:alertVC animated:YES completion:nil];
        } break;
        default:
            break;
    }
}

- (void)tappedCancel {
    if (_isRecording == YES) {
        UIAlertController *alertVC = [UIAlertController alertShowWithTitle:@"友情提示" message:@"您当前录音还未提交" confirm:@"确定"];
        [[UIViewController currentViewController] presentViewController:alertVC animated:YES completion:nil];
    }
    else {
        [UIView animateWithDuration:0.3f
            animations:^{
                [self setFrame:CGRectMake(0, HEIGHT_H5, WIDTH_H5, 0)];
                self.alpha = 0;
            }
            completion:^(BOOL finished) {
                if (finished) {
                    [self removeFromSuperview];
                }
            }];
    }
}

#pragma mark---------------------- Private ----------------------------
- (NSInteger)stringConversionNumber:(NSString *)time {
    //判断是否有分钟 此处暂时不判断小时
    //    NSString * hour;
    NSInteger tmpSecond;
    NSInteger finalTime;
    NSString *secondStr = [time substringFromIndex:4];
    if ([secondStr integerValue] && [secondStr integerValue] < 59) {
        tmpSecond = [secondStr integerValue] * 60;
        finalTime = tmpSecond;

        NSString *subTimeStr = [time substringFromIndex:6];
        if ([subTimeStr integerValue] < 10) {
            NSString *tmpStr = [subTimeStr substringFromIndex:1];
            NSInteger minute = [tmpStr integerValue] + tmpSecond;
            finalTime        = minute;
        }
        else {
            NSInteger minute = [subTimeStr integerValue] + tmpSecond;
            finalTime        = minute;
        }
    }
    else {
        NSString *subTimeStr = [time substringFromIndex:6];
        if ([subTimeStr integerValue] < 10) {
            finalTime = [[subTimeStr substringFromIndex:1] integerValue];
        }
        else {
            finalTime = [subTimeStr integerValue];
        }
    }
    return finalTime;
}

- (void)tappedactionSheetView {
}

//销毁timer
- (void)dealloc {
    NSLog(@"TJPRecorderViewDealloc");
    if (_timer) {
        [_timer invalidate];
    }
}

#pragma mark---------------------- 重载UI ----------------------------
- (void)reloadRecordView {
    [self.timeLabel removeFromSuperview];
    [self.playBtn removeFromSuperview];
    [self.submitBtn removeFromSuperview];
    [self.repetBtn removeFromSuperview];
    _count  = 0;
    _second = 0;
    _hour   = 0;
    [self createButtonWithTimeTitle:timeStr
                   recordLabelTitle:labelTitle];
}

#pragma mark---------------------- 创建控件 ----------------------------
- (UILabel *)createTimeLabelWithTitle:(NSString *)timeTitle {
    UILabel *timeLabel      = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_H5 / 2 - 40, 15, 80, 35)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font          = [UIFont systemFontOfSize:16];
    timeLabel.text          = timeTitle;
    timeLabel.textColor     = UIColorHex(393a3c);
    return timeLabel;
}

- (void)createRecordLabelWithRecordLabTitle:(NSString *)recordLabTitle {
    self.isHadRecordeLabel                         = YES;
    self.recordeLabel                              = [self createRecordeLabelWithTitle:recordLabTitle];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPressGesture.minimumPressDuration          = 0.3;
    [self.recordeLabel addGestureRecognizer:longPressGesture];
    [self.actionSheetView addSubview:_recordeLabel];
}

- (UIImageView *)createVoiceRecordButton {
    UIImageView *recordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_H5 / 2 - 40, CGRectGetMaxY(_timeLabel.frame) + 30, 80, 80)];
    recordImageView.image        = [UIImage imageNamed:@"icon_voice_record" aClass:self.class bundle:QYCH5];
    return recordImageView;
}

- (UILabel *)createRecordeLabelWithTitle:(NSString *)recordTitle {
    UILabel *recordLabel               = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_H5 / 2 - 65, 210, 130, 36)];
    recordLabel.textAlignment          = NSTextAlignmentCenter;
    recordLabel.font                   = [UIFont boldSystemFontOfSize:15];
    recordLabel.text                   = recordTitle;
    recordLabel.clipsToBounds          = YES;
    recordLabel.layer.borderWidth      = 1;
    recordLabel.userInteractionEnabled = YES;
    recordLabel.layer.cornerRadius     = 36 / 2;
    recordLabel.layer.borderColor      = UIColorHex(ebeff2).CGColor;
    recordLabel.textColor              = UIColorHex(393a3c);

    return recordLabel;
}

@end
