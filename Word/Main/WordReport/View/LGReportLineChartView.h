//
//  LGReportLineChartView.h
//  Word
//
//  Created by caoguochi on 2018/4/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGReportModel.h"

@class LGBeforeChartView;
@interface LGReportLineChartView : UIView

//前 15天
@property (nonatomic, strong)NSMutableArray <LGWeekReportModel *> *before;

//后 14 天
@property (nonatomic, strong)NSMutableArray <NSString *>  *after;

//设置数据
- (void)setData:(NSMutableArray<LGWeekReportModel *> *)before after:(NSMutableArray <NSString *> *)after;

@end

@interface LGBeforeChartView : UIView

@property (nonatomic, strong)NSMutableArray <LGWeekReportModel *> *before;
@property (nonatomic, assign) CGFloat maxValue;

- (instancetype)initWithFrame:(CGRect)frame before:(NSMutableArray<LGWeekReportModel *> *)before maxValue:(CGFloat)maxValue;

@end
