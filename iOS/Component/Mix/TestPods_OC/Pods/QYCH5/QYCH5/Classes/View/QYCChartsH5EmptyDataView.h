//
//  QYCChartsH5EmptyDataView.h
//  Qiyeyun
//
//  Created by dong on 2018/10/23.
//  Copyright © 2018年 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYCChartsH5EmptyDataView;

NS_ASSUME_NONNULL_BEGIN

@protocol QYCChartsH5EmptyDataViewDelegate <NSObject>

@optional

- (void)chartsH5EmptyDataViewReloadClick:(QYCChartsH5EmptyDataView *)emptyDataView;

@end

@interface QYCChartsH5EmptyDataView : UIView

@property(nonatomic, weak) id <QYCChartsH5EmptyDataViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
