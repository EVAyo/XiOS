//
//  QRViewController.m
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/4/25.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import "QRViewController.h"
#import <AVFoundation/AVFoundation.h>
// Define
#import "QYCScanDefine.h"
// View
#import "QRView.h"
// Util
#import "QRUtil.h"
// Vendor
#import <QYCIconFont/QYCIconFont.h>
#import <TZImagePickerController/TZImagePickerController.h>

typedef void (^getLocationBlock)(BOOL isSuccess, NSString *address);

@interface QRViewController () <AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
/***/
@property (strong, nonatomic) AVCaptureDevice *device;
/***/
@property (strong, nonatomic) AVCaptureDeviceInput *input;
/***/
@property (strong, nonatomic) AVCaptureMetadataOutput *output;
/***/
@property (strong, nonatomic) AVCaptureSession *session;
/***/
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;
/***/
@property (nonatomic, strong) UIButton *backBtn;
/***/
@property (nonatomic, strong) QRView *qrView;
/***/
@property (nonatomic, assign) AVCaptureTorchMode lightMode;
/**扫描结果处理方式*/
//@property (nonatomic, assign) QRProcessingMethod processingMethod;

@end

@implementation QRViewController

#pragma mark - ================ LifeCycle =================

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = QYCScanLocalizedString(@"扫一扫");
    
    /*
    // 返回按钮
    UIImage *backImage = [QYCFontImage iconWithName:@"返回" fontSize:25 color:HexColor(0x4680FF)];
    UIBarButtonItem *leftItem = nil;
    if (backImage) {
        leftItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(p_dismiss)];
    }
    else {
        leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(p_dismiss)];
    }
    self.navigationItem.leftBarButtonItem = leftItem;
     */
    
    // 初始化UI
    [self configUI];
    
    if (![QRUtil isCameraAvailable]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:QYCScanLocalizedString(@"提示") message:QYCScanLocalizedString(@"相机不可用") preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:QYCScanLocalizedString(@"知道了") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self p_dismissAnimated:YES];
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    else if (![QRUtil isCameraAuthStatusCorrect]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:QYCScanLocalizedString(@"提示") message:QYCScanLocalizedString(@"您没有相机的访问权限!\n前往 设置 打开权限") preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:QYCScanLocalizedString(@"知道了") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self p_dismissAnimated:YES];
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [QRUtil openAppSetting];
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    else {
        [self createAVCapture]; //初始化配置,主要是二维码的配置
        [self updateLayout];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 再次进入页面
    if (![_session isRunning] && [QRUtil isCameraAvailable] && [QRUtil isCameraAuthStatusCorrect]) {
        [self createAVCapture];
        [self updateLayout];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [_preview removeFromSuperlayer];
    [_session stopRunning];
    if (_lightMode == AVCaptureTorchModeOn) {
        [_qrView resetLightStatus];
    }
}

- (void)appDidBecomeActive:(NSNotification *)notify {
    /// 恢复扫一扫功能
    if (self.session) {
        [self.session startRunning];
    }
}

- (void)appWillResignActive:(NSNotification *)notify {
    /// 暂停扫一扫功能
    if (self.session) {
        [self.session stopRunning];
    }
}

#pragma mark dealloc

- (void)dealloc {
    /// 关闭定时器
    [self.qrView removeTimer];
    
    // NSLog(@"%s", __func__);
}

#pragma mark UI

- (void)createAVCapture {
    // 1.实例化拍摄设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    // 2.设置输入设备 Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];

    // 3.设置元数据输出 Output
    // 3.1 实例化拍摄元数据输出
    _output = [[AVCaptureMetadataOutput alloc] init];
    // 3.2 设置输出数据代理
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    // 4. 添加拍摄会话 Session
    // 4.1 实例化拍摄会话
    _session = [[AVCaptureSession alloc] init];
    // 4.2 设置高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    // 4.3 添加会话输入
    if ([_session canAddInput:_input]) {
        [_session addInput:_input];
    }
    // 4.4 添加会话输出
    if ([_session canAddOutput:_output]) {
        [_session addOutput:_output];
    }
    // 4.5 设置条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes = @[ AVMetadataObjectTypeQRCode ];

    // 5. 视频预览图层 Preview
    // 5.1 实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    _preview              = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResize;
    _preview.frame        = [QRUtil screenBounds];
    // 5.2 将图层插入当前视图
    [self.view.layer insertSublayer:_preview atIndex:0];
    // 5.3 设置ouput video的方向，默认为AVCaptureVideoOrientationLandscapeLeft，是旋转90°的，这个是相机传感器导致的。
    _preview.connection.videoOrientation = [QRUtil videoOrientationFromCurrentDeviceOrientation];

    
    //先进行判断是否支持控制对焦,不开启自动对焦功能，很难识别二维码。
    if (_device.isFocusPointOfInterestSupported && [_device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        [_input.device lockForConfiguration:nil];
        [_input.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [_input.device unlockForConfiguration];
    }
    
    // 6. 启动会话
    [_session startRunning];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
}

- (void)configUI {
    [self.view addSubview:self.qrView];
    @weakify(self);
    
    self.qrView.lightImgClick = ^(BOOL open) {
        @strongify(self);
        [self.device lockForConfiguration:nil];
        self.lightMode = open ? AVCaptureTorchModeOn : AVCaptureTorchModeOff;
        [self.device setTorchMode:self.lightMode];
        [self.device unlockForConfiguration];
    };

    // 扫描相册的二维码
    self.qrView.scanPhotoAlbumBlock = ^{
        @strongify(self);
        TZImagePickerController *imagePickerVc   = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        imagePickerVc.navigationBar.barTintColor = HexColor(0x296cff);
        imagePickerVc.allowTakePicture           = NO;
        imagePickerVc.allowTakeVideo             = NO;
        imagePickerVc.allowPickingOriginalPhoto  = YES;
        imagePickerVc.photoWidth                 = WIDTH * [UIScreen mainScreen].scale;
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            UIImage *pickImage   = [photos firstObject];
            CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
            // 获取选择图片中识别结果
            NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(pickImage)]];
            if (features.count > 0) {
                CIQRCodeFeature *feature = features.firstObject;
                NSString *stringValue    = feature.messageString;
                // 返回
                [self p_dismissAnimated:NO];
                if (self.qrUrlBlock) {
                    self.qrUrlBlock(stringValue, self);
                }
                if ([self.delegate respondsToSelector:@selector(qrViewController:scanResult:)]) {
                    [self.delegate qrViewController:self scanResult:stringValue];
                }
            }
            else {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:QYCScanLocalizedString(@"提示") message:QYCScanLocalizedString(@"请选择有效的二维码") preferredStyle:UIAlertControllerStyleAlert];
                [alertVC addAction:[UIAlertAction actionWithTitle:QYCScanLocalizedString(@"知道了") style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alertVC animated:YES completion:nil];
            }
        }];
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    };
}

- (void)updateLayout {
    _qrView.center = CGPointMake([QRUtil screenBounds].size.width / 2, [QRUtil screenBounds].size.height / 2);

    // 修正扫描区域
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth  = self.view.frame.size.width;
    CGRect cropRect      = CGRectMake((screenWidth - self.qrView.transparentArea.width) / 2,
                                 (screenHeight - self.qrView.transparentArea.height) / 2,
                                 self.qrView.transparentArea.width,
                                 self.qrView.transparentArea.height);

    [_output setRectOfInterest:CGRectMake(cropRect.origin.y / screenHeight,
                                          cropRect.origin.x / screenWidth,
                                          cropRect.size.height / screenHeight,
                                          cropRect.size.width / screenWidth)];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    if ([metadataObjects count] > 0) {
        //停止扫描
        [_session stopRunning];
        //
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
        stringValue                                         = metadataObject.stringValue;
        // 返回
        [self p_dismissAnimated:NO];
        if (self.qrUrlBlock) {
            self.qrUrlBlock(stringValue, self);
        }
        if ([self.delegate respondsToSelector:@selector(qrViewController:scanResult:)]) {
            [self.delegate qrViewController:self scanResult:stringValue];
        }
    }
}

#pragma mark - ================ Private Methods =================

- (void)p_dismissAnimated:(BOOL)animated {
    [self.navigationController popViewControllerAnimated:animated];
    /*
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:animated];
    }
     */
}

#pragma mark - ================ Getter and Setter =================

- (QRView *)qrView {
    if (!_qrView) {
        CGRect screenRect       = [QRUtil screenBounds];
        _qrView                 = [[QRView alloc] initWithFrame:screenRect];
        _qrView.transparentArea = CGSizeMake(self.view.frame.size.width * 0.7, self.view.frame.size.width * 0.7);
        _qrView.backgroundColor = [UIColor clearColor];
    }
    return _qrView;
}

@end
