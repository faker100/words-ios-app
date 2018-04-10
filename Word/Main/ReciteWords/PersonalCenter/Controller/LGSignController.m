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
@property (nonatomic, strong) NSMutableArray *calendar;

@end

@implementation LGSignController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData{
	[self.request requestUserSignCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.signModel = [LGSignModel mj_objectWithKeyValues:response];
		}
	}];
}

- (NSMutableArray *)calendar{
	
	if (!_calendar) {
		_calendar = [NSMutableArray arrayWithArray:@[@"S",@"M",@"T",@"W",@"T",@"F",@"s"]];
		NSInteger firstWeek = [NSDate firstWeekDayOfMonth:[NSDate currentDate]];
		//当前月多少周
		NSRange weekRange = [[NSDate currentCalendar]  rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:[NSDate currentDate]];
		
		for (int i = 1; i <= weekRange.length * 7; i++) {
			if (i < firstWeek) {
				[_calendar addObject:@""];
			}else{
				[_calendar addObject:@(i - firstWeek + 1).stringValue];
			}
		}
	}
	return _calendar;
}

- (void)setSignModel:(LGSignModel *)signModel{
	_signModel = signModel;
	
	UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
	flowLayout.minimumInteritemSpacing = 0;
	flowLayout.minimumLineSpacing = 0;
	CGFloat width = CGRectGetWidth(self.collectionView.bounds) / 7.0;
	CGFloat height = CGRectGetHeight(self.collectionView.bounds) / (self.calendar.count / 7);
	flowLayout.itemSize = CGSizeMake(width, height);
	
	[self.collectionView reloadData];
}

//打卡
- (IBAction)signAction:(id)sender {
	[self setSignButtonEnable:NO];
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request reqeustSignCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
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
	[cell.dayButton setTitle:self.calendar[indexPath.row] forState:UIControlStateNormal];
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
