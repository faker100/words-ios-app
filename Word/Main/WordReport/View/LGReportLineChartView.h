//
//  LGReportLineChartView.h
//  Word
//
//  Created by caoguochi on 2018/4/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGReportModel.h"

@interface LGReportLineChartView : UIView

//前 15天
@property (nonatomic, strong)NSMutableArray <LGWeekReportModel *> *before;

//后 14 天
@property (nonatomic, strong)NSMutableArray <NSString *>  *after;

//x 轴数据
@property (nonatomic, strong) NSArray<NSString *> *date;

//设置数据
- (void)setReportData:(LGReportModel *)reportModel;

@end

@interface LGBarChartView : UIView

@property (nonatomic, strong)NSMutableArray <LGWeekReportModel *> *before;
@property (nonatomic, strong)NSMutableArray <NSString *>  *after;

@property (nonatomic, assign) CGFloat maxValue;

- (instancetype)initWithFrame:(CGRect)frame before:(NSMutableArray<LGWeekReportModel *> *)before after:(NSMutableArray <NSString *> *)after  maxValue:(CGFloat)maxValue;

@end

@interface LGXDataView : UIView

@property (nonatomic, strong) NSArray<NSString *> *date;

- (instancetype)initWithFrame:(CGRect)frame date:(NSArray<NSString *> *)date;

@end


