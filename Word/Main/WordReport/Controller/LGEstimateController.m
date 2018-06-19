//
//  LGEstimaController.m
//  Word
//
//  Created by caoguochi on 2018/4/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGEstimateController.h"
#import "LGEstimateCell.h"
#import "LGEstimateWordModel.h"
#import "LGPlayer.h"
#import "LGWordErrorViewController.h"
#import "LGNavigationController.h"
#import "LGTool.h"
#import "LGUserManager.h"

@interface LGEstimateController () <UITableViewDelegate, UITableViewDataSource>
{
	dispatch_source_t timer;
	NSInteger duration;
}

@property (nonatomic, strong) LGEstimateWordModel *wordModel;

@end

@implementation LGEstimateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self requestWord];
}

- (void)viewDidDisappear:(BOOL)animated{
	[super viewDidDisappear:animated];
	//判断返回
	if (!self.navigationController) {
		[LGTool cancelTimer:timer];
	}
}

//请求单词
- (void)requestWord{
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request reqeustEstimateWordsCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.wordModel = [LGEstimateWordModel mj_objectWithKeyValues:response[@"words"]];
		}
	}];
}


/**
 提交答案,如果答案为 nil,则标记为不认识
 提交成功后,跳转到下一题

 @param answer 答案
 */
- (void)submiteAnswer:(NSString *)answer{
	
	LGAnswerType type = [answer isEqualToString:self.wordModel.answer];
	
	if ([LGUserManager shareManager].wordEstimateSoundFlag) {
		if (type == LGAnswerFalse) {
			[[LGPlayer sharedPlayer] playWithAudioType:LGAudio_estimate_notKnow];
		}else{
			[[LGPlayer sharedPlayer] playWithAudioType:LGAudio_know];
		}
	}
	
	BOOL isKnow = StringNotEmpty(answer);
	
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request submitEstimateAnswer:answer type:type wordId:self.wordModel.wordsId duration:duration isKnow:isKnow completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSInteger code = [NSString stringWithFormat:@"%@",response[@"code"]].integerValue;
			if (code == 1) {
				[self pushNextController];
			}else if(code == 2){
				[self performSegueWithIdentifier:@"estimateToResult" sender:nil];
			}
		}else{
			self.tableView.allowsSelection = YES;
		}
	}];
	
}

- (void)pushNextController{
	[LGTool cancelTimer:timer];
	LGNavigationController *nav = (LGNavigationController *)self.navigationController;
	LGEstimateController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"LGEstimateController"];
	[nav lg_pushViewController:controller animated:YES];
}

- (void)setWordModel:(LGEstimateWordModel *)wordModel{
	_wordModel = wordModel;
	timer = [LGTool timerCompletion:^(NSInteger currtentSecond) {
		duration = currtentSecond;
	}];
	self.tableView.allowsSelection = YES;
	self.wordLabel.text = wordModel.word;
	self.phoneticLabel.text = wordModel.phonetic_uk;
	[self.tableView reloadData];
	
	//自动播放音频
	if ([LGUserManager shareManager].autoplayWordFlag) {
		[self playAction:nil];
	}
	
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playAction:(id)sender {
	[[LGPlayer sharedPlayer] playWithUrl:self.wordModel.uk_audio completion:nil];
}

//报错
- (IBAction)submitError:(id)sender {
	
	if (self.wordModel.wordsId) {
		LGWordErrorViewController *errorController = STORYBOARD_VIEWCONTROLLER(@"ReciteWords", @"LGWordErrorViewController");
		errorController.wordID = self.wordModel.wordsId;
		[self.navigationController pushViewController:errorController animated:YES];
	}
}

//不认识
- (IBAction)notKnowAction:(UIButton *)sender {
	self.tableView.allowsSelection = NO;
	[self submiteAnswer:nil];
}


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.wordModel.selectArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LGEstimateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGEstimateCell"];
	cell.answerLabel.text = self.wordModel.selectArray[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	

	LGEstimateCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
	NSString *userAnswer = cell.answerLabel.text;
	
	if (indexPath.section != self.wordModel.trueAnswerIndex) {
		[cell setWrong];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		[tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.wordModel.trueAnswerIndex] animated:YES scrollPosition:UITableViewScrollPositionNone];
	}
	tableView.allowsSelection = NO;
	
	[self submiteAnswer:userAnswer];
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
