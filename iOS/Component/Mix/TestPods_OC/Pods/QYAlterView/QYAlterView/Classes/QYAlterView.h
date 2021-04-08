//
//  QYAlterView.h
//  Qiyeyun
//
//  Created by dong on 2017/3/6.
//  Copyright © 2017年 安元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTextView.h"

typedef void(^SureBtnClickBlock)(NSString *text);

typedef void(^CanceBtnClickBlock)(void);


typedef NS_ENUM(NSInteger, QYAlertViewStyle) {
    QYAlertViewStyleStyleDefault = 0,
    QYAlertViewStyleStyleTextView,
    QYAlertViewStyleStylePicShare,
    QYAlertViewStyleStyleText,
    QYAlertViewStyleStylePic,
    QYAlertViewStyleStyleTextFild,
    QYAlertViewStyleStyleAlert,
    QYAlertViewStyleStyleMessageTextFild

};

@interface QYContainerView : UIView
/**alterView样式*/
@property (nonatomic,assign,readonly)QYAlertViewStyle style;
/**标题内容*/
@property (nonatomic,copy,readonly)NSString *title;
/**取消的文字*/
@property (nonatomic,copy)NSString *cancelButtonTitle;
/**其他按钮的文字*/
@property (nonatomic,copy)NSString *otherButtonTitle;


@property (nonatomic,strong)UIView *topLineView;
@property (nonatomic,strong)UIView *hengLine;
@property (nonatomic,strong)UIView *shuLine;


@property (nonatomic,strong)UILabel *title_label;
@property (nonatomic,strong)YYTextView *textView;
@property (nonatomic,strong)UITextField *textField;


@property (nonatomic,strong)UIImage *image;
@property (nonatomic,strong)UIImageView *shareIamgeView;


@property (nonatomic,copy)NSString *text;
@property (nonatomic,strong)UILabel *text_label;

@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,copy)CanceBtnClickBlock cancelBtnClickBlock;
@property (nonatomic,copy)SureBtnClickBlock sureBtnClickBlock;

@property (nonatomic,assign)BOOL textViewRequire;
/*title标题的对其方式,默认左对齐*/
@property(nonatomic)        NSTextAlignment  textAlignment;
/*占位符文字*/
@property (nonatomic,copy)NSString *placeholder;
/*占位符文字颜色*/
@property (nonatomic,strong)UIColor *placeholderColor;
/*占位符文字字体*/
@property (nonatomic,strong)UIFont *font;
/**输入框最大输入数量 默认60*/
@property(nonatomic, assign) NSInteger textMaxLength;


- (instancetype)initWithContainerViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title;


- (instancetype)initWithContainerViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title  image:(UIImage *)image;


- (instancetype)initWithContainerViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;

- (instancetype)initWithContainerViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title  image:(UIImage *)image cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;

- (instancetype)initWithContainerViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title text:(NSString *)text image:(UIImage *)image cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;

@end



@interface QYAlterView : UIView
/**容器的背景色*/
@property (strong,nonatomic)UIColor *backColor;
/**alterView样式*/
@property (nonatomic,assign,readonly)QYAlertViewStyle style;
/**标题*/
@property (nonatomic,copy)NSString *title;

/**取消的文字*/
@property (nonatomic,copy)NSString *cancelButtonTitle;
/**其他按钮的文字*/
@property (nonatomic,copy)NSString *otherButtonTitle;

@property (nonatomic,assign)BOOL textViewRequire;



@property (nonatomic,strong,readonly)UIImage *image;

@property (nonatomic,copy)NSString *text;

@property (nonatomic,copy)SureBtnClickBlock sureBtnBlock;
@property (nonatomic,copy)CanceBtnClickBlock cancelBtnBlock;

/**容器view*/
@property (nonatomic,strong)QYContainerView *containView;


// 创建
- (instancetype)initWithAlterViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title;

- (instancetype)initWithAlterViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title  image:(UIImage *)image;


- (instancetype)initWithAlterViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;

- (instancetype)initWithAlterViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title  image:(UIImage *)image cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;

- (instancetype)initWithAlterViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title text:(NSString *)text image:(UIImage *)image cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;

////

/**
 创建启聊中转发分享的弹框

 @param alterViewStyle 弹框e类型
 @param title 标题
 @param image 图片缩略图
 @return 弹框
 */
+ (instancetype)alterViewForFowardWithStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title text:(NSString *)text image:(UIImage *)image ;


// 渲染

- (void)show;
@end


