//
//  LGSignController.m
//  Word
//
//  Created by Charles Cao on 2018/4/10.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSignController.h"
#import "LGSignCollectionCell.h"
#import "LGSignModel.h"
#import "NSDate+Utilities.h"

@interface LGSignController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)LGSignModel *signModel;

//collection 的 data
@property (nonatomic, strong) NSMutableArray<LGSignCellModel *> *calendar;

@end

@implementation LGSignController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self requestData];
	//默认先不能打卡
	self.currentLabel.text = [[NSDate currentDate] stringWithFormat:@"yyyy年MM月dd日"];
	[self setSignButtonEnable:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
	UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
	flowLayout.minimumInteritemSpacing = 0;
	flowLayout.minimumLineSpacing = 0;
	CGFloat width = CGRectGetWidth(self.collectionView.bounds) / 7.0;
	CGFloat height = CGRectGetHeight(self.collectionView.bounds) / (self.calendar.count / 7);
	flowLayout.itemSize = CGSizeMake(width, height);
}

- (void)requestData{
	[self.request requestUserSignCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.signModel = [LGSignModel mj_objectWithKeyValues:response];
		}
	}];
}

- (NSMutableArray<LGSignCellModel *> *)calendar{
	
	if (!_calendar) {
		
		_calendar = [NSMutableArray array];
		NSArray *week = @[@"S",@"M",@"T",@"W",@"T",@"F",@"s"];
		
		[week enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			LGSignCellModel *signCellModel = [LGSignCellModel new];
			signCellModel.day = obj;
			[_calendar addObject:signCellModel];
		}];
		
		NSInteger firstWeek = [NSDate firstWeekDayOfMonth:[NSDate currentDate]];
		//当前月多少周
		NSRange weekRange = [[NSDate currentCalendar]  rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:[NSDate currentDate]];
		
		//当前月多少天
		NSRange numOfMonth = [[NSDate currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate currentDate]];
		
		//今天
		NSInteger today = [NSDate currentDate].day;
		
		for (int i = 1; i <= weekRange.length * 7; i++) {
			LGSignCellModel *signCellModel = [LGSignCellModel new];
			if (i < firstWeek || i > firstWeek + numOfMonth.length - 1) {
				signCellModel.day = @"";
			}else{
				
				NSInteger day = i - firstWeek + 1;
				signCellModel.day = @(day).stringValue;
				//今天,先标记为 LGsignToday
				if (day == today) {
					signCellModel.signType = LGsignToday;
				}
			}
			[_calendar addObject:signCellModel];
		}
	}
	return _calendar;
}

- (void)setSignModel:(LGSignModel *)signModel{
	_signModel = signModel;
	[self setSignButtonEnable:signModel.type == 0];
	self.totalSignLabel.text = [NSString stringWithFormat:@"累计打卡: %@天",signModel.num];
	self.numLable.text = signModel.integral;
	
	int j = 0;

	for (int i = 0; i<signModel.data.count; i++) {
		//已打卡天数
		NSInteger day = [[NSDate defaultDateFormatter] dateFromString:signModel.data[i]].day;
		for (; j < self.calendar.count; j++) {
			//cell上的天数
			LGSignCellModel *cellModel = self.calendar[j];
			if (day == cellModel.day.integerValue) {
				//cell 上的天数 = 已打卡天数,标记为已打卡,并跳出循环
				cellModel.signType = LGSignDidSign;
				j++;
				break;
			}
		}
	}
	[self.collectionView reloadData];
}

//打卡
- (IBAction)signAction:(id)sender {
	[self setSignButtonEnable:NO];
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request reqeustSignCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			[self requestData];
			[LGProgressHUD showSuccess:@"打卡成功" toView:self.view];
		}else{
			[self setSignButtonEnable:YES];
		}
	}];
}


/**
 设置打卡是否可用

 */
- (void)setSignButtonEnable:(BOOL)flag{
	self.signButton.enabled = flag;
	[self.signButton setBackgroundColor:flag ? [UIColor lg_colorWithType:LGColor_theme_Color] : [UIColor grayColor]];
	
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.calendar.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	LGSignCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGSignCollectionCell" forIndexPath:indexPath];
	cell.signModel = self.calendar[indexPath.row];
	return cell;
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
