//
//  LGReportController.m
//  Word
//
//  Created by Charles Cao on 2018/4/4.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReportController.h"
#import "UIScrollView+LGRefresh.h"
#import "LGReportModel.h"
#import "LGReportSelectTimeController.h"
#import "NSDate+Utilities.h"

@interface LGReportController () <LGReportSelectTimeControllerDelegate>

@property (nonatomic, strong) LGReportModel *reportModel;

@property (nonatomic, copy) NSString *currentDateStr;

@end

@implementation LGReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.currentDateStr = [[NSDate currentDate] stringWithFormat:@"yyyy-MM-01"];

	__weak typeof(self) weakSelf = self;
	[self.scrollView setHeaderRefresh:^{
		self.currentDateStr = [[NSDate currentDate] stringWithFormat:@"yyyy-MM-01"];
		[weakSelf reqeustData];
	}];
		[self reqeustData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCurrentDateStr:(NSString *)currentDateStr{
	_currentDateStr = currentDateStr;
	self.monthLabel.text = currentDateStr;
}

//请求报表
- (void)reqeustData{
	[self.request requestReportCompletion:^(id response, LGError *error) {
		[self.scrollView lg_endRefreshing];
		if ([self isNormal:error]) {
            self.reportModel = [LGReportModel mj_objectWithKeyValues:response];
		}
	}];
}

//切换月份请求 月份格式:(xxxx-xx-1)
- (void)changeMonthData:(NSString *)month{
	[self.request requestChangeMonthReport:month completion:^(id response, LGError *error) {
		if ([self isNormal:error]){
            //利用 LGReportModel 解析month
            LGReportModel *report = [LGReportModel mj_objectWithKeyValues:response];
            self.lineChartView.month = report.month;
		}
	}];
}

- (void)setReportModel:(LGReportModel *)reportModel{
    _reportModel = reportModel;
    
    self.weekTotalLabel.text = [NSString stringWithFormat:@"总量:%@",reportModel.week.all];
    [self.weekData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        NSString *description;
        NSString *num;
        switch (btn.tag) {
            case 100:
                description = @"熟知量";
                num = reportModel.week.knowWell;
                break;
            case 101:
                description = @"认识量";
                num = reportModel.week.know;
                break;
            case 102:
                description = @"模糊量";
                num = reportModel.week.dim;
                break;
            case 103:
                description = @"忘记量";
                num = reportModel.week.forget;
                break;
            case 104:
                description = @"不认识";
                num = reportModel.week.notKnow;
                break;
            default:
                break;
        }
        [btn setTitle:[NSString stringWithFormat:@"%@   %@",description,num] forState:UIControlStateNormal];
    }];
    
    self.reportPieView.weekReportModel = reportModel.week;
    self.lineChartView.month = reportModel.month;
}

#pragma mark - LGReportSelectTimeController

- (void)selectedTime:(NSString *)timeStr{
	[self changeMonthData:timeStr];
	self.currentDateStr = timeStr;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"reportToSelectTime"]) {
		LGReportSelectTimeController *controller = [segue destinationViewController];
		controller.delegate = self;
	}
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
