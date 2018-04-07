//
//  LGReportController.h
//  Word
//
//  Created by Charles Cao on 2018/4/4.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGReportPieView.h"
#import "LGReportLineChartView.h"

@interface LGReportController : UIViewController


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//饼状图
@property (weak, nonatomic) IBOutlet LGReportPieView *reportPieView;
//折线图
@property (weak, nonatomic) IBOutlet LGReportLineChartView *lineChartView;

//周报总共
@property (weak, nonatomic) IBOutlet UILabel *weekTotalLabel;

//

/**
 周报数据
 tag : 100 - 熟知量
       101 - 认识量
       102 - 模糊量
       103 - 忘记量
       104 - 不认识
 */
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *weekData;


//月份
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@end
