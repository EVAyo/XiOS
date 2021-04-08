//
//  QYAlterView.m
//  Qiyeyun
//
//  Created by dong on 2017/3/6.
//  Copyright © 2017年 安元. All rights reserved.
//

#import "QYAlterView.h"
#import "QYAlterViewItemInfo.h"
#import <QYCCategory/UIColor+QYCColor.h>
#import "UIColor+YYAdd.h"

static CGFloat kMargin          = 20;
static CGFloat kInterMargin     = 15;
static CGFloat kContrainerViewW = 300;
static CGFloat kTextViewH       = 80;
static CGFloat kTextFieldH      = 32;
static CGFloat kBtnH            = 40;
static NSInteger kTextLength    = 60;

inline static CGFloat getHeight(NSString *content, CGSize maxSize, CGFloat fontSize) {
    UILabel *lab      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxSize.width, maxSize.height)];
    lab.font          = [UIFont systemFontOfSize:fontSize];
    lab.numberOfLines = 3;
    lab.text          = content ?: @"";
    [lab sizeToFit];

    return lab.frame.size.height;
}

inline static NSMutableDictionary<NSString *, QYAlterViewItemInfo *> *get_itemFrame(QYAlertViewStyle sty, NSString *title, NSString *text) {
    NSMutableDictionary<NSString *, QYAlterViewItemInfo *> *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    CGFloat tempH                                                = 0.0 + kMargin;
    //标题
    if (!title || ![title isEqualToString:@""]) {
        CGFloat h = getHeight(title, CGSizeMake(kContrainerViewW - 15 * 2, CGFLOAT_MAX), 17);
        [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake(kMargin, tempH, kContrainerViewW - 2 * kMargin, h) totleH:h] forKey:@"title_label"];
        tempH += h + kInterMargin;
    }

    //定制的样式
    switch (sty) {
        case 0: {
        } break;
        case 1: {
            [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake(kMargin, tempH, kContrainerViewW - 2 * kMargin, kTextViewH) totleH:0] forKey:@"text_view"];
            tempH += kTextViewH + kInterMargin;

        } break;
        case 2: {
            [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake(kMargin, tempH, kContrainerViewW - 2 * kMargin, kTextViewH) totleH:0] forKey:@"text_view"];
            tempH += kTextViewH + kInterMargin;

            [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake((kContrainerViewW - 2 * kMargin - kTextViewH) / 2.0, tempH, kTextViewH, kTextViewH) totleH:0] forKey:@"iamge_view"];
            tempH += kTextViewH + kInterMargin;

        } break;
        case 3: {
            CGFloat h = getHeight(text, CGSizeMake(kContrainerViewW - 15 * 2, CGFLOAT_MAX), 15);
            [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake(kMargin, tempH, kContrainerViewW - 2 * kMargin, h) totleH:h] forKey:@"text_label"];
            tempH += h + kInterMargin;

        } break;
        case 4: {
            [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake((kContrainerViewW - 2 * kMargin - kTextViewH) / 2.0, tempH, kTextViewH, kTextViewH) totleH:0] forKey:@"iamge_view"];
            tempH += kTextViewH + kInterMargin;
        } break;
        case 5: {
            [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake(kMargin, tempH + kMargin, kContrainerViewW - 2 * kMargin, kTextFieldH) totleH:0] forKey:@"text_field"];
            tempH += kTextViewH + kInterMargin;

        } break;
        case QYAlertViewStyleStyleMessageTextFild: {
            CGFloat h = getHeight(text, CGSizeMake(kContrainerViewW - 15 * 2, CGFLOAT_MAX), 11);
            [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake(kMargin, tempH, kContrainerViewW - 2 * kMargin, h) totleH:h] forKey:@"text_label"];
            tempH += h + kInterMargin / 2.0;

            [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake(kMargin, tempH + kMargin, kContrainerViewW - 2 * kMargin, kTextFieldH) totleH:0] forKey:@"text_field"];
            tempH += kTextViewH + kInterMargin;

        } break;

        default:
            break;
    }

    [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake(0, tempH, kContrainerViewW, 0.5) totleH:0] forKey:@"heng_line"];

    //取消和确定的btn
    if (sty == QYAlertViewStyleStyleAlert) {
        [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake(0, tempH, kContrainerViewW, kBtnH) totleH:0] forKey:@"cancel_btn"];
        tempH += kBtnH;
    }
    else {
        [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake(0, tempH, kContrainerViewW / 2.0 - 1, kBtnH) totleH:0] forKey:@"cancel_btn"];
        [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake(kContrainerViewW / 2.0 + 1, tempH, kContrainerViewW / 2.0, kBtnH) totleH:0] forKey:@"sure_btn"];
        [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectMake(kContrainerViewW / 2.0, tempH, 0.5, kBtnH) totleH:0] forKey:@"shu_line"];

        tempH += kBtnH;
    }

    //整体的高度
    [dict setObject:[[QYAlterViewItemInfo alloc] initWithRect:CGRectZero totleH:tempH] forKey:@"totle_H"];

    return dict;
}

@interface QYAlterView ()

@end

@implementation QYAlterView
#pragma mark - LifeCycle Method

+ (instancetype)alterViewForFowardWithStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title text:(NSString *)text image:(UIImage *)image {
    QYAlterView *alert                      = [[QYAlterView alloc] initWithAlterViewStyle:alterViewStyle title:title text:text image:image cancelButtonTitle:@"取消" otherButtonTitle:@"发送"];
    alert.containView.title_label.textColor = KQYCColor(333333, c4c4c4);
    alert.containView.title_label.font      = [UIFont boldSystemFontOfSize:18];
    alert.containView.text_label.textColor  = KQYCColor(666666, a0a0a0);
    alert.containView.text_label.font       = [UIFont systemFontOfSize:14];
    [alert.containView.sureBtn setTitleColor:[UIColor colorWithHexString:@"#4680ff"] forState:UIControlStateNormal];
    return alert;
}

- (instancetype)initWithAlterViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title text:(NSString *)text image:(UIImage *)image cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    self = [super init];
    if (self) {
        self.backgroundColor = KQYCColorAlpha(000000, 0.3, 000000, 0.3);
        self.frame           = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _style               = alterViewStyle;
        _title               = title;
        _cancelButtonTitle   = cancelButtonTitle;
        _otherButtonTitle    = otherButtonTitle;
        _image               = image;
        _text                = text;
        [self initSubViews];
    }
    return self;
}
- (instancetype)initWithAlterViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title {
    return [self initWithAlterViewStyle:alterViewStyle title:title image:nil cancelButtonTitle:nil otherButtonTitle:nil];
}

- (instancetype)initWithAlterViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title image:(UIImage *)image cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    return [self initWithAlterViewStyle:alterViewStyle title:title text:nil image:image cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle];
}

- (instancetype)initWithAlterViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title image:(UIImage *)image {
    return [self initWithAlterViewStyle:alterViewStyle title:title image:image cancelButtonTitle:nil otherButtonTitle:nil];
}

- (instancetype)initWithAlterViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    return [self initWithAlterViewStyle:alterViewStyle title:title image:nil cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle];
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.containView.bounds = CGRectMake(0, 0, kContrainerViewW, get_itemFrame(_style, _title, _text)[@"totle_H"].AlterViewH);
    self.containView.center = self.center;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
#pragma mark - Delegate Method
#pragma mark - EventResponse Method
#pragma mark - Private Method
- (void)initSubViews {
    [self addSubview:self.containView];
}
#pragma mark - Setter And Getter Method
- (QYContainerView *)containView {
    if (!_containView) {
        _containView                           = [[QYContainerView alloc] initWithContainerViewStyle:_style title:_title text:_text image:_image cancelButtonTitle:_cancelButtonTitle otherButtonTitle:_otherButtonTitle];
        _containView.textViewRequire           = self.textViewRequire;
        _containView.title_label.numberOfLines = 0;

        _containView.layer.cornerRadius = 5;

        // When YES, content and subviews are clipped to the bounds of the view. Default is NO.
        [_containView setClipsToBounds:YES];

        __weak typeof(self) weakSelf = self;

        _containView.cancelBtnClickBlock = ^(void) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.cancelBtnBlock) {
                strongSelf.cancelBtnBlock();
            }
            [strongSelf removeFromSuperview];
        };

        _containView.sureBtnClickBlock = ^(NSString *text) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.sureBtnBlock) {
                strongSelf.sureBtnBlock(text);
            }
            if (_style == QYAlertViewStyleStyleTextView || _style == QYAlertViewStyleStyleTextFild) {
                if (!text || [text isEqualToString:@""]) {
                    if (strongSelf.textViewRequire) {
                    }
                    else {
                        [strongSelf removeFromSuperview];
                    }
                }
                else {
                    [strongSelf removeFromSuperview];
                }
            }
            else {
                [strongSelf removeFromSuperview];
            }
        };
    }
    return _containView;
}
@end

@interface QYContainerView () <YYTextViewDelegate, UITextFieldDelegate>

@end

@implementation QYContainerView
#pragma mark - LifeCycle Method

- (instancetype)initWithContainerViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title text:(NSString *)text image:(UIImage *)image cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    self = [super init];
    if (self) {
        self.backgroundColor = KQYCColor(ffffff, 2f2f2f);
        _title               = title;
        _style               = alterViewStyle;
        _cancelButtonTitle   = cancelButtonTitle;
        _otherButtonTitle    = otherButtonTitle;
        _image               = image;
        _text                = text;
        [self initSubViewsWithStyle:alterViewStyle title:title];
    }
    return self;
}
- (instancetype)initWithContainerViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title {
    return [self initWithContainerViewStyle:alterViewStyle title:title image:nil cancelButtonTitle:nil otherButtonTitle:nil];
}

- (instancetype)initWithContainerViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title image:(UIImage *)image {
    return [self initWithContainerViewStyle:alterViewStyle title:title image:image cancelButtonTitle:nil otherButtonTitle:nil];
}

- (instancetype)initWithContainerViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    return [self initWithContainerViewStyle:alterViewStyle title:title image:nil cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle];
}
- (instancetype)initWithContainerViewStyle:(QYAlertViewStyle)alterViewStyle title:(NSString *)title image:(UIImage *)image cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    return [self initWithContainerViewStyle:alterViewStyle title:title text:nil image:image cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle];
}

#pragma mark - Delegate Method
- (void)textViewDidChange:(YYTextView *)textView {
    NSInteger maxLength = self.textMaxLength > 0 ? self.textMaxLength : kTextLength;
    if (textView.text.length > maxLength) {
        textView.text = [textView.text substringToIndex:maxLength];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidChange:(UITextField *)textField {
    NSInteger kMaxLength = self.textMaxLength > 0 ? self.textMaxLength : kTextLength;
    NSString *toBeString = textField.text;
    NSString *lang       = [[UIApplication sharedApplication] textInputMode].primaryLanguage;

    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [textField markedTextRange];

        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];

        if (!position) { // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        else { //有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }
    else { //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}
#pragma mark - EventResponse Method

- (void)cancelBtnClick {
    self.cancelBtnClickBlock();
}
- (void)sureBtnClick {
    if (self.style == QYAlertViewStyleStyleTextFild || self.style == QYAlertViewStyleStyleMessageTextFild) {
        self.sureBtnClickBlock(self.textField.text);
    }
    else if (self.style == QYAlertViewStyleStyleTextView) {
        self.sureBtnClickBlock(self.textView.text);
    }
    else if (self.style == QYAlertViewStyleStylePicShare) {
        self.sureBtnClickBlock(self.textView.text);
    }
    else {
        self.sureBtnClickBlock(nil);
    }
}
#pragma mark - Private Method
- (void)initSubViewsWithStyle:(QYAlertViewStyle)style title:(NSString *)title {
    if (!title || ![title isEqualToString:@""])
        [self addSubview:self.title_label];
    switch (style) {
        case 0:

            break;
        case 1:
            [self addSubview:self.textView];

            break;
        case 2: {
            [self addSubview:self.textView];
            [self addSubview:self.shareIamgeView];
        }

        break;
        case 3: {
            [self addSubview:self.text_label];

        }

        break;
        case 4: {
            [self addSubview:self.shareIamgeView];
        }

        break;
        case 5: {
            [self addSubview:self.textField];
        }

        break;
        case QYAlertViewStyleStyleMessageTextFild: {
            [self addSubview:self.text_label];
            [self addSubview:self.textField];
        }

        break;

        default:
            break;
    }

    [self addSubview:self.hengLine];
    //    [self addSubview:self.topLineView];
    [self addSubview:self.cancelBtn];
    if (style != QYAlertViewStyleStyleAlert)
        [self addSubview:self.sureBtn];
    [self addSubview:self.shuLine];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    NSMutableDictionary<NSString *, QYAlterViewItemInfo *> *dict = get_itemFrame(_style, _title, _text);
    //    self.topLineView.frame =dict?dict[@"topline_view"].rect:CGRectZero;
    self.title_label.frame    = dict ? dict[@"title_label"].rect : CGRectZero;
    self.textView.frame       = dict ? dict[@"text_view"].rect : CGRectZero;
    self.cancelBtn.frame      = dict ? dict[@"cancel_btn"].rect : CGRectZero;
    self.sureBtn.frame        = dict ? dict[@"sure_btn"].rect : CGRectZero;
    self.shareIamgeView.frame = dict ? dict[@"iamge_view"].rect : CGRectZero;
    self.text_label.frame     = dict ? dict[@"text_label"].rect : CGRectZero;
    self.textField.frame      = dict ? dict[@"text_field"].rect : CGRectZero;
    self.hengLine.frame       = dict ? dict[@"heng_line"].rect : CGRectZero;
    self.shuLine.frame        = dict ? dict[@"shu_line"].rect : CGRectZero;
}
#pragma mark - Setter And Getter Method

- (UIView *)hengLine {
    if (!_hengLine) {
        _hengLine                 = [[UIView alloc] init];
        _hengLine.backgroundColor = KQYCColor(e6e6e6, 555555);
    }
    return _hengLine;
}

- (UIView *)shuLine {
    if (!_shuLine) {
        _shuLine                 = [[UIView alloc] init];
        _shuLine.backgroundColor = KQYCColor(e6e6e6, 555555);
    }
    return _shuLine;
}

- (UILabel *)title_label {
    if (!_title_label) {
        _title_label               = [[UILabel alloc] init];
        _title_label.font          = [UIFont systemFontOfSize:17];
        _title_label.numberOfLines = 3;
        if (_style == QYAlertViewStyleStyleDefault || _style == QYAlertViewStyleStyleAlert || _style == QYAlertViewStyleStyleTextFild || _style == QYAlertViewStyleStyleMessageTextFild) {
            _title_label.textAlignment = NSTextAlignmentCenter;
        }
        //        _title_label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _title_label.text      = @"sdfsdfsdfsdf";
        _title_label.textColor = KQYCColor(444444, c4c4c4);
        _title_label.text      = _title;
    }
    return _title_label;
}

- (UILabel *)text_label {
    if (!_text_label) {
        _text_label               = [[UILabel alloc] init];
        _text_label.font          = [UIFont systemFontOfSize:15];
        _text_label.numberOfLines = 3;
        //        _title_label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _text_label.text      = @"sdfsdfsdfsdf";
        _text_label.textColor = KQYCColor(444444, c4c4c4);
        if (_style == QYAlertViewStyleStyleMessageTextFild) {
            _text_label.font          = [UIFont systemFontOfSize:11];
            _text_label.textAlignment = NSTextAlignmentCenter;
            _text_label.textColor     = UIColorHex(BBC5D5);
        }

        _text_label.text = _text;
    }
    return _text_label;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:_cancelButtonTitle forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        if (_style == QYAlertViewStyleStyleAlert) {
            [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#4680ff"] forState:UIControlStateNormal];
        }
        else {
            [_cancelBtn setTitleColor:UIColorHex(888888) forState:UIControlStateNormal];
        }
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitle:_otherButtonTitle forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_sureBtn setTitleColor:UIColorHex(888888) forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (YYTextView *)textView {
    if (!_textView) {
        _textView                      = [[YYTextView alloc] init];
        _textView.textColor            = KQYCColor(333333, c4c4c4);
        _textView.layer.borderWidth    = .5;
        _textView.layer.borderColor    = KQYCColor(c1c1c1, 555555).CGColor;
        _textView.layer.cornerRadius   = 2;
        _textView.placeholderText      = self.placeholder ?: @"可以在这里留言(限60字)";
        _textView.placeholderTextColor = self.placeholderColor ?: KQYCColor(999999, 898989);
        _textView.delegate             = self;
    }
    return _textView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField                       = [UITextField new];
        _textField.textColor             = KQYCColor(444444, 1e1e1e);
        _textField.borderStyle           = UITextBorderStyleNone;
        _textField.delegate              = self;
        _textField.placeholder           = self.placeholder ?: @"最多输入10个字";
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder ?: @"最多输入10个字" attributes:@{NSForegroundColorAttributeName : self.placeholderColor ?: UIColorHex(bbc5d5), NSFontAttributeName : self.font ?: [UIFont boldSystemFontOfSize:13]}];
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        if (_style == QYAlertViewStyleStyleMessageTextFild) {
            _textField.secureTextEntry = YES;
            _textField.placeholder     = @"请输入密码";
        }
    }
    return _textField;
}

- (UIImageView *)shareIamgeView {
    if (!_shareIamgeView) {
        _shareIamgeView             = [[UIImageView alloc] init];
        _shareIamgeView.image       = _image;
        _shareIamgeView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _shareIamgeView;
}

- (UIView *)messageTextFildBottomLineView {
    UIView *line         = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#E6E6E6);
    return line;
}

@end
