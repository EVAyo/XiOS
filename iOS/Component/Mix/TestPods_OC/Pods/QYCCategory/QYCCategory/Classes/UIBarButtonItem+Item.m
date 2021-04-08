//
//  AppDelegate.m
//  Category
//
//  Created by 钱立新 on 14/10/28.
//  Copyright © 2014年 钱立新. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:target action:action forControlEvents:controlEvents];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)color fontNum:(CGFloat)fontNum target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (fontNum != 0) {
        btn.titleLabel.font = [UIFont systemFontOfSize:fontNum];
    }
    [btn sizeToFit];

    [btn addTarget:target action:action forControlEvents:controlEvents];

    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)leftbarButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    btn.frame             = CGRectMake(0, 0, 30, 30);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);

    [btn addTarget:target action:action forControlEvents:controlEvents];

    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (NSArray<UIBarButtonItem *> *)barBackButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    // 自定义导航栏左侧按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn setImage:highImage forState:UIControlStateHighlighted];
    [leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftBtn.imageEdgeInsets            = UIEdgeInsetsMake(0, -8, 0, 0);
    UIView *backBtnView                = [[UIView alloc] initWithFrame:leftBtn.bounds];
    [backBtnView addSubview:leftBtn];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];

    return @[leftItem];

    //    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace  target:nil action:nil];
    //    nagetiveSpacer.width = -16;//这个值可以根据自己需要自己调整
    //   return @[nagetiveSpacer, leftItem];
}
@end
