//
//  LGWordDetailController.m
//  Word
//
//  Created by Charles Cao on 2018/2/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordDetailController.h"
#import "LGWordDetailModel.h"
#import "LGWordDetailCell.h"
#import "LGWordDetailHeaderFooterView.h"
#import "LGPlayer.h"

@interface LGWordDetailController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) LGWordDetailModel *detailModel;

@end

@implementation LGWordDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	if (self.type == LGWordDetailReciteWords){
		[self requestReciteWordsData];
	}else if (self.type == LGWordDetailEbbinghausReview){
		[self requestEbbinghausReviewWord];
	}
	
	[self.wordTabelView registerNib:[UINib nibWithNibName:@"LGWordDetailHeaderFooterView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LGWordDetailHeaderFooterView"];
}

- (void)setDetailModel:(LGWordDetailModel *)detailModel {
	_detailModel = detailModel;
	self.wordLabel.text = detailModel.words.word;
	self.translateLabel.text = detailModel.words.translate;
	[self.playerButton setTitle:[NSString stringWithFormat:@"  %@",detailModel.words.phonetic_us] forState:UIControlStateNormal];
	[self.wordTabelView reloadData];
}


/**
 * 请求背单词接口,code = 98进入复习模式
 */
- (void)requestReciteWordsData {
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestReciteWordsCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSInteger code = [NSString stringWithFormat:@"%@",response[@"code"]].integerValue;
			if (code == 1){
				self.detailModel = [LGWordDetailModel mj_objectWithKeyValues:response];
			}else if (code == 98){
				[self requestEbbinghausReviewWordArray];
			}
		}
	}];
}


/**
 请求复习艾宾浩斯复习的第一个单词
 */
- (void)requestEbbinghausReviewWord{
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestEbbinghausReviewWord:self.reviewWordIdArray.firstObject completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.detailModel = [LGWordDetailModel mj_objectWithKeyValues:response];
		}
	}];
}

/**
 请求艾宾浩斯复习列表
 */
- (void)requestEbbinghausReviewWordArray{
	[self.request requestEbbinghausReviewList:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSMutableArray *array  = [NSMutableArray arrayWithArray:response[@"words"]];
			[self pushNextWordDetailController:LGWordDetailEbbinghausReview reviewWordIdArray:array animated:NO];
		}
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

//播放语音
- (IBAction)playeAction:(id)sender {
	[[LGPlayer sharedPlayer] playWithUrl:self.detailModel.words.us_audio completion:^(LGError *error) {
		[self isNormal:error];
	}];
}

//报错
- (IBAction)reportErrorsAction:(id)sender {
	
}

//熟识
- (IBAction)familiarAction:(id)sender {
	[self updateWordStatus:LGWordStatusFamiliar];
}

//认识
- (IBAction)knowAction:(id)sender {
	[self updateWordStatus:LGWordStatusKnow];
}

//不认识
- (IBAction)notKnowAction:(id)sender {
	[self updateWordStatus:LGWordStatusIncognizance];
}

//模糊
- (IBAction)vagueAction:(id)sender {
	[self updateWordStatus:LGWordStatusVague];
}


/**
 更新单词状态,并跳转到下一个单词
 在艾宾浩斯复习模式下,循环复习 id 列表, 如果标记单词为认识,则从复习id列表中移除该单词,
 如果标记为其他状态,则把该单词移动到复习列表最后,直到所有单词都标记为认识
 当复习id列表为空时,进入背单词模式(LGWordDetailReciteWords)
 @param status 标记单词状态
 */
- (void)updateWordStatus:(LGWordStatus) status{
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request updateWordStatus:self.detailModel.words.ID status:status completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			if (self.type == LGWordDetailEbbinghausReview) {
				NSString *wordID = self.reviewWordIdArray.firstObject;
				[self.reviewWordIdArray removeObjectAtIndex:0];
				if (status != LGWordStatusKnow) {
					[self.reviewWordIdArray addObject:wordID];
				}
				LGWordDetailControllerType tempType = ArrayNotEmpty(self.reviewWordIdArray) ? LGWordDetailEbbinghausReview : LGWordDetailReciteWords;
				[self pushNextWordDetailController:tempType reviewWordIdArray:self.reviewWordIdArray animated:YES];
			}else{
				[self pushNextWordDetailController:LGWordDetailReciteWords reviewWordIdArray:nil animated:YES];
			}
		}
	}];
}


/**
 跳转到下一个 WordDetailController

 @param type  下一个 controller 的模式
 @param array 艾宾浩斯复习模式下(LGWordDetailEbbinghausReview)需要复习的单词 id 数组,其他模式为 nil
 @param animated 是否跳转动画
 */
- (void)pushNextWordDetailController:(LGWordDetailControllerType) type reviewWordIdArray:(NSMutableArray *) array animated:(BOOL)animated{
	
	LGWordDetailController *wordDetailController = STORYBOARD_VIEWCONTROLLER(@"ReciteWords", @"LGWordDetailController");
	wordDetailController.type = type;
	wordDetailController.reviewWordIdArray = array;
	NSMutableArray *controllerArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
	[controllerArray removeObject:self];
	[controllerArray addObject:wordDetailController];
	[self.navigationController setViewControllers:controllerArray animated:animated];
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.detailModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return self.detailModel.dataSource[section].cellContent.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.wordTabelView) {
		LGWordDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGWordDetailCell"];
		cell.contentLabel.text = self.detailModel.dataSource[indexPath.section].cellContent[indexPath.row];
		return cell;
	}
	return nil;
}

#pragma mark -UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	LGWordDetailHeaderFooterView *heaerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LGWordDetailHeaderFooterView"];
	heaerView.titleLabel.text = self.detailModel.dataSource[section].sectionTitle;
	return heaerView;
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
