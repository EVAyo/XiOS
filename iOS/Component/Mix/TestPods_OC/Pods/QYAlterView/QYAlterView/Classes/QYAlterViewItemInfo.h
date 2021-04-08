//
//  QYAlterViewItemInfo.h
//  Qiyeyun
//
//  Created by dong on 2017/3/6.
//  Copyright © 2017年 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYAlterViewItemInfo : NSObject
/**容器视图的整体高度*/
@property (nonatomic,assign)CGFloat AlterViewH;
@property (nonatomic,assign)CGRect rect;

- (instancetype)initWithRect:(CGRect)rect totleH:(CGFloat)totleH;
@end
