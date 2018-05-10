//
//  LGTimeReviewController.m
//  Word
//
//  Created by Charles Cao on 2018/3/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTimeReviewController.h"
#import "LGReviewSelectTimeCell.h"
#import "NSDate+Utilities.h"
#import "LGSelectReviewTypeView.h"
#import "LGTimeReivewCountAlertView.h"
#import "LGWordDetailController.h"
#import "LGUserManager.h"
#import "LGDictationPractiseController.h"

@interface LGTimeReviewController () <UITableViewDelegate, UITableViewDataSource, LGSelectReviewTypeViewDelegate,LGTimeReivewCountAlertViewDelegate>

@property (nonatomic, strong) NSArray<NSDate *> *startDateArray;   //开始日期数组
@property (nonatomic, strong) NSArray<NSDate *> *endDateArray;     //截止日期数组
@property (nonatomic, strong) LGSelectReviewTypeView *selectTypeView;  //选择复习方式view
@property (nonatomic, assign) LGSelectReviewType selectedReviewType;    //选择的复习方式，默认中英
@property (nonatomic, strong) LGTimeReivewCountAlertView *countAlertView;//单词总数提示框
@property (nonatomic, strong) NSMutableArray *wordIDArray;

@end

@implementation LGTimeReviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	NSDate *startTime = [LGUserManager shareManager].user.startTime ? [[NSDate defaultDateFormatter] dateFromString:[LGUserManager shareManager].user.startTime] : [NSDate currentDate];
	
	self.startDateArray = [NSDate dateArrayFrom:startTime toDate:[NSDate currentDate]];
    self.endDateArray = self.startDateArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sureAction:(id)sender {
	
	NSString *startTimeStr = self.startTimeLabel.text;
	NSString *endTimeStr   = self.endTimeLabel.text;
	
	if (StringNotEmpty(startTimeStr) && StringNotEmpty(endTimeStr)) {
        NSDate *startDate = [[NSDate defaultDateFormatter]dateFromString:startTimeStr];
        NSDate *endDate = [[NSDate defaultDateFormatter]dateFromString:endTimeStr];
		if ([startDate compare:endDate] != NSOrderedDescending) {
			[LGProgressHUD showHUDAddedTo:self.view];
			[self.request requestRevieWordWithStartTime:startTimeStr endTime:endTimeStr Completion:^(id response, LGError *error) {
				if ([self isNormal:error]) {
					[self showCountAlertView:[NSMutableArray arrayWithArray:response]];
				}
			}];
		}else{
			[LGProgressHUD showMessage:@"开始时间不能小于截止时间" toView:self.view];
		}
		
	}else{
		[LGProgressHUD showMessage:@"请选择时间段" toView:self.view];
	}
}

//选择复习方式
- (IBAction)selectReviewTypeAction:(id)sender {
	if (!self.selectTypeView) {
		self.selectTypeView = [[NSBundle mainBundle]loadNibNamed:@"LGSelectReviewTypeView" owner:nil options:nil].firstObject;
		self.selectTypeView.frame = self.view.bounds;
		self.selectTypeView.delegate = self;
	}
	
	[self.view addSubview:self.selectTypeView];
}


/**
 显示复习单词数量

 @param wordIDArray 单词数组
 */
- (void)showCountAlertView:(NSMutableArray *)wordIDArray{
	self.wordIDArray = wordIDArray;
	if (wordIDArray.count == 0) {
		[LGProgressHUD showMessage:@"该时间段内没有需要复习的单词" toView:self.view];
		return;
	}
	if (!self.countAlertView) {
		self.countAlertView = [[NSBundle mainBundle]loadNibNamed:@"LGTimeReivewCountAlertView" owner:nil options:nil].firstObject;
		self.countAlertView.delegate = self;
		self.countAlertView.frame = self.view.window.bounds;
	}
	self.countAlertView.countLabel.text = @(wordIDArray.count).stringValue;
	[self.view.window addSubview:self.countAlertView];
}

#pragma mark - LGTimeReivewCountAlertViewDelegate
- (void)beginReview{
	if (self.selectedReviewType != LGSelectReviewDictation) {
		[self performSegueWithIdentifier:@"timeReviewToWordDetail" sender:nil];
	}else{
		[self performSegueWithIdentifier:@"timeReviewToDictation" sender:nil];
	}
}

#pragma mark - LGSelectReviewTypeViewDelegate
- (void)selectedReviewType:(LGSelectReviewType)type{
	self.selectedReviewType = type;
	NSString *str;
	switch (type) {
		case LGSelectReviewChinese_English:
			str = @"中英";
			break;
		case LGSelectReviewEnglish_Chinese:
			str = @"英中";
			break;
		case LGSelectReviewDictation:
			str = @"听写";
			break;
		default:
			break;
	}
	[self.rightItemButton setTitle:str forState:UIControlStateNormal];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.startDateArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGReviewSelectTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGReviewSelectTimeCell"];
	cell.date = self.startDateArray[indexPath.row];
	return cell;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGReviewSelectTimeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (tableView == self.startTimeTableView) {
		self.startTimeLabel.text = cell.timeLabel.text;
	}else{
		self.endTimeLabel.text = cell.timeLabel.text;
	}
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([segue.identifier isEqualToString:@"timeReviewToWordDetail"]) {
		LGWordDetailController *controller  = segue.destinationViewController;
		controller.total = @(self.wordIDArray.count).stringValue;
		controller.controllerType = LGWordDetailReview;
		controller.reviewTyep = self.selectedReviewType;
		controller.reviewWordIdArray = self.wordIDArray;
	}else if ([segue.identifier isEqualToString:@"timeReviewToDictation"]){
		LGDictationPractiseController *controller = segue.destinationViewController;
		controller.wordIDArray = self.wordIDArray;
		controller.total = @(self.wordIDArray.count).stringValue;
	}
	
	
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
