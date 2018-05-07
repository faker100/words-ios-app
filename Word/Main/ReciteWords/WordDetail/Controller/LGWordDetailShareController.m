//
//  LGWordDetailShareController.m
//  Word
//
//  Created by caoguochi on 2018/5/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordDetailShareController.h"
#import "LGSignCollectionCell.h"
#import "LGSignModel.h"
#import "NSDate+Utilities.h"
#import "LGUserManager.h"
#import "LGReciteWordModel.h"

@interface LGWordDetailShareController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) LGSignModel *signModel;

@property (nonatomic, strong) LGReciteWordModel *reciteWordModel;

//collection 的 data
@property (nonatomic, strong) NSMutableArray<LGSignCellModel *> *calendar;



@end

@implementation LGWordDetailShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self requestData];
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
	self.dateLabel.text = [[NSDate currentDate] stringWithFormat:@"yyyy年MM月dd日"];
}

- (void)requestData{
	//签到天数
	[self.request requestUserSignCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.signModel = [LGSignModel mj_objectWithKeyValues:response];
		}
	}];
	//已坚持天数/今日背单词
	[self.request requestIndexRecitePlan:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.reciteWordModel = [LGReciteWordModel mj_objectWithKeyValues:response];
			self.insistLabel.text = self.reciteWordModel.insistDay;
			self.wordLabel.text = self.reciteWordModel.todayWords;
		}
	}];
}

- (NSMutableArray<LGSignCellModel *> *)calendar{
	
	if (!_calendar) {
		
		_calendar = [NSMutableArray array];
		NSArray *week = @[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
		
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
		
		for (int i = 1; i <= weekRange.length * 7; i++) {
			LGSignCellModel *signCellModel = [LGSignCellModel new];
			if (i < firstWeek || i > firstWeek + numOfMonth.length - 1) {
				signCellModel.day = @"";
			}else{
				NSInteger day = i - firstWeek + 1;
				signCellModel.day = @(day).stringValue;
			}
			[_calendar addObject:signCellModel];
		}
	}
	return _calendar;
}

- (void)setSignModel:(LGSignModel *)signModel{
	_signModel = signModel;
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

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.calendar.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	LGSignCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGSignCollectionCell" forIndexPath:indexPath];
	cell.signModel = self.calendar[indexPath.row];
	return cell;
}

#pragma mark - 

/**
 分享选择平台
 
 @param sender tag - 100，微信
 tag - 101, 朋友圈
 tag - 102, QQ
 tag - 103, 空间
 */
- (IBAction)platformAction:(UIButton *)sender {
	
	SSDKPlatformType platformType = 0;
	switch (sender.tag) {
		case 100:
			platformType = SSDKPlatformSubTypeWechatSession;
			break;
		case 101:
			platformType = SSDKPlatformSubTypeWechatTimeline;
			break;
		case 102:
			platformType = SSDKPlatformSubTypeQQFriend;
			break;
		case 103:
			platformType = SSDKPlatformSubTypeQZone;
			break;
	}
	NSString *url = [NSString stringWithFormat:@"wap/share/index?uid=%@&type=1",[LGUserManager shareManager].user.uid];
	
	NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
	NSString *text = [NSString stringWithFormat:@"我已在雷哥单词坚持%@天,今日已背单词%@词,累计已背%@词",self.reciteWordModel.insistDay, self.reciteWordModel.todayWords,self.reciteWordModel.userAllWords];
	[shareParams SSDKSetupShareParamsByText:text
									 images:PLACEHOLDERIMAGE
										url:[NSURL URLWithString:WORD_DOMAIN(url)]
									  title: platformType == SSDKPlatformSubTypeWechatTimeline?text : @"雷哥单词"
									   type:SSDKContentTypeWebPage];
	
	[ShareSDK share:platformType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
	}];
}


- (IBAction)cancelAction:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
	[self.delegate dismissShareController];
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
