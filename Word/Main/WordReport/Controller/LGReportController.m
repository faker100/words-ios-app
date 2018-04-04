//
//  LGReportController.m
//  Word
//
//  Created by Charles Cao on 2018/4/4.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReportController.h"
#import "UIScrollView+LGRefresh.h"

@interface LGReportController ()

@end

@implementation LGReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	__weak typeof(self) weakSelf = self;
	[self.scrollView setHeaderRefresh:^{
		[weakSelf reqeustData];
	}];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self reqeustData];
	[self changeMonthData:@"2018-03-01"];
}

//请求报表
- (void)reqeustData{
	[self.request requestReportCompletion:^(id response, LGError *error) {
		[self.scrollView lg_endRefreshing];
		if ([self isNormal:error]) {
			NSLog(@"%@",response);
		}
	}];
}

//切换月份请求 月份格式:(xxxx-xx-1)
- (void)changeMonthData:(NSString *)month{
	[self.request requestChangeMonthReport:month completion:^(id response, LGError *error) {
		if ([self isNormal:error]){
			
		}
	}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
