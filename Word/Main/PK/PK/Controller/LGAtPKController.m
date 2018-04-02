//
//  LGAtPKController.m
//  Word
//
//  Created by Charles Cao on 2018/3/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGAtPKController.h"
#import "LGPKAnswerCell.h"
#import "LGTool.h"
#import "JPUSHService.h"
#import "LGPlayer.h"
#import "LGJPushReceiveMessageModel.h"
#import "LGPKResultController.h"

//倒计时时间
NSInteger countDown = 20;

@interface LGAtPKController () <UITableViewDelegate, UITableViewDataSource>
{
	dispatch_source_t timer;
}
@property (nonatomic, assign) NSInteger currentWordIndex;//当前单词 在 pkModel.words 中的 index,0开始
@property (nonatomic, strong) LGPKWordModel *currentWordModel; //当前显示单词
@property (nonatomic, assign) CGFloat userRighCount; //用户答对题目总数;
@property (nonatomic, assign) NSInteger currentTime; //当前倒计时

@property (nonatomic, assign) CGFloat userAccuracy; //用户正确率  百分比
@property (nonatomic, assign) CGFloat opponentAccuracy; //对手正确率 百分比

@end

@implementation LGAtPKController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self configDefaultData];
}

//默认数据
- (void)configDefaultData{
	[self.navigationController setNavigationBarHidden:YES];
	[self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(self.currentUserModel.image)] placeholderImage:[UIImage imageNamed:@"pk_default_opponent"]];
	[self.opponentImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(self.opponentModel.image)] placeholderImage:[UIImage imageNamed:@"pk_default_opponent"]];
	self.currentWordModel = self.pkModel.words.firstObject;
	self.opponentProgressLabel.text = [NSString stringWithFormat:@"1/%ld",self.pkModel.words.count];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self addNotification];
}

- (void)viewDidDisappear:(BOOL)animated{
	[super viewDidDisappear:animated];
	[self removeNotification];
}

- (void)addNotification{
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	
	/*********************** 接收自定义消息 **************************/
	
	[defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
	
	/*********************** app 退到后台时 **************************/

	[defaultCenter addObserver:self selector:@selector(applicationExit) name:UIApplicationWillResignActiveNotification object:nil];
	
	/*********************** 激活 app 时 **************************/
	[defaultCenter addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)removeNotification{
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	[defaultCenter removeObserver:self name:kJPFNetworkDidReceiveMessageNotification object:nil];
	[defaultCenter removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
	[defaultCenter removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}


/**
 接受 jpush 应用内消息通知

 */
- (void)networkDidReceiveMessage:(NSNotification *)notification {
	
	LGJPushReceiveMessageModel *pushModel = [LGJPushReceiveMessageModel mj_objectWithKeyValues:notification.userInfo];
	if (pushModel.extras.type == 4) {
		LGAtPKModel *atPKModel = pushModel.extras.message;
		
		//找到对手model,(用户的信息本地计算)
		LGAccuracyModel *opponentUser = [atPKModel.user1.uid isEqualToString:self.currentUserModel.uid] ? atPKModel.user2 : atPKModel.user1;
		self.opponentProgressLabel.text = [NSString stringWithFormat:@"%@/%ld",opponentUser.num,self.pkModel.words.count];
		self.opponentAccuracy = opponentUser.accuracy.floatValue;
	}
	
}

//退出 app
- (void)applicationExit{
	[self.request requestPKExit:self.currentUserModel.uid totalId:self.pkModel.totalId currentQuestionIndex:self.currentWordIndex + 1 duration:countDown - self.currentTime];
}


/**
 激活 app,重连 Pk
 code = 0 超时失败,返回首页
 code = 1 重连成功
 */
- (void)applicationBecomeActive{
	[LGProgressHUD showHUDAddedTo:self.view];
	[LGTool cancelTimer:timer];
	[self.request requestPKConnect:self.currentUserModel.uid totalId:self.pkModel.totalId completion:^(id response, LGError *error) {
		if ([self isNormal:error showInView:self.view.window]) {
			
			/**
			 重连后应该到第几题,如果超过题目总数则调用结果接口
			 如果没超过题目总数,则跳转到该题目
			 num 从 1 开始
			 */
			NSInteger num = [NSString stringWithFormat:@"%@",response[@"num"]].integerValue;
			if (num > self.pkModel.words.count) {
				[self requestFinishPK];
			}else{
				NSInteger time = [NSString stringWithFormat:@"%@",response[@"time"]].integerValue;
				[self setCurrentWordModel:self.pkModel.words[num - 1] beginCountDown:time];
			}
		}else{
			[self.navigationController popToRootViewControllerAnimated:YES];
		}
	}];
}

- (IBAction)playAudio:(id)sender {
	[[LGPlayer sharedPlayer]playWithUrl:self.currentWordModel.uk_audio completion:nil];
}


#pragma mark - setter getter

- (void)setUserAccuracy:(CGFloat)userAccuracy{
	_userAccuracy = userAccuracy;
	self.userWinLabel.text = [NSString stringWithFormat:@"%.1f%%",userAccuracy];
	[self updateAccuracyProgress];
	
}

- (void)setOpponentAccuracy:(CGFloat)opponentAccuracy{
	_opponentAccuracy = opponentAccuracy;
	self.opponentWinLabel.text = [NSString stringWithFormat:@"%.1f%%",opponentAccuracy];
	[self updateAccuracyProgress];
}

/**
 设置当前题目,更新做题进度

 @param currentWordModel 当前题目
 @param time 题目倒计时时长
 */
- (void)setCurrentWordModel:(LGPKWordModel *)currentWordModel beginCountDown:(NSInteger)time{
	_currentWordModel = currentWordModel;
	self.userProgressLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentWordIndex + 1,self.pkModel.words.count];
	self.wordLabel.text = currentWordModel.word;
	[self.audioButton setTitle:currentWordModel.phonetic_uk forState:UIControlStateNormal];
	self.tableView.allowsSelection = YES;
	[self.tableView reloadData];
	[self beginCountDown:time];
}

- (void)setCurrentWordModel:(LGPKWordModel *)currentWordModel{
	_currentWordModel  = currentWordModel;
	[self setCurrentWordModel:currentWordModel beginCountDown:countDown];
}

- (void)setCurrentTime:(NSInteger)currentTime{
	_currentTime = currentTime;
	self.timeLabel.text = [NSString stringWithFormat:@"%lds",currentTime];
	if (currentTime == 0) {
		[self nextQuestionWithCurrentAnswer:@"" duration:countDown];
	}
}

- (NSInteger)currentWordIndex{
	return [self.pkModel.words indexOfObject:self.currentWordModel];
}

#pragma mark -



/**
 倒计时

 @param second 倒计时总共时长
 */
- (void)beginCountDown:(NSInteger)second{
	[LGTool cancelTimer:timer];
	timer = [LGTool beginCountDownWithSecond:second completion:^(NSInteger currtentSecond) {
		self.currentTime = currtentSecond;
	}];
}

/**
 下一题,先提交当前题目答案,不用等待服务器 response ,再刷新下一题
 如果当前题目为最后一题,则到结果页或者等待对手页

 @param answer 当前答案
 @param duration 答题所用时间
 */
- (void)nextQuestionWithCurrentAnswer:(NSString *)answer duration:(NSInteger)duration{
	//提交答案
	[self commitAnswer:answer duration:duration];
	
	NSArray<LGPKWordModel *> *words = self.pkModel.words;
	if (self.currentWordIndex == words.count - 1) {
		[self requestFinishPK];
	}else{
		self.currentWordModel = words[self.currentWordIndex + 1];

	}
}


/**
 请求结束 PK
 code = 1,跳转结果页
 code = 2,显示等待对手页面
 */
- (void)requestFinishPK{
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestPKFinish:self.opponentModel.uid totalId:self.pkModel.totalId completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSInteger code = [NSString stringWithFormat:@"%@",response[@"code"]].integerValue;
			if (code == 1) {
				[self performSegueWithIdentifier:@"PKToResult" sender:nil];
			}else{
				[self showWait];
			}
		}
	}];
}


/**
 显示等待对手页面,请求
 code = 1结果页
 code = 2每2秒请求一次轮询接口(requestPKPoll)
 */
- (void)showWait{
	[self beginWaitAnimation];
	self.tableView.hidden   = YES;
	self.audioButton.hidden = YES;
	self.wordLabel.hidden   = YES;
	self.timeLabel.hidden   = YES;
	self.waitView.hidden = NO;
	[self.request requestPKPoll:self.opponentModel.uid totalId:self.pkModel.totalId completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSInteger code = [NSString stringWithFormat:@"%@",response[@"code"]].integerValue;
			if (code == 1) {
				[self performSegueWithIdentifier:@"PKToResult" sender:nil];
			}else{
				//2秒之后
				dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
					[self showWait];
				});
			}
			
		}
	}];
}

/**
 "请等待..."动画
 */
- (void)beginWaitAnimation{
	if (self.waitImageView.isAnimating) return;
	
	NSArray<UIImage *> *imageArray = @[
									   [UIImage imageNamed:@"pk_wait_1"],
									   [UIImage imageNamed:@"pk_wait_2"],
									   [UIImage imageNamed:@"pk_wait_3"],
									   [UIImage imageNamed:@"pk_wait_4"],
									   ];
	[self.waitImageView setAnimationImages:imageArray];
	self.waitImageView.animationDuration = 1;
	self.waitImageView.animationRepeatCount = 0;
	[self.waitImageView startAnimating];
}

/**
 提交答案

 @param chooseAnswer 用户答案
 @param duration 使用时长
 */
- (void)commitAnswer:(NSString *)chooseAnswer duration:(NSInteger)duration{
	
	LGAnswerType type = [chooseAnswer isEqualToString:self.currentWordModel.answer] ? LGAnswerTrue : LGAnswerFalse;
	
	[self.request commitPKAnswer:type totalId:self.pkModel.totalId wordId:self.currentWordModel.wordsId answer:chooseAnswer duration:duration completion:^(id response, LGError *error) {
		
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.pkModel.words[self.currentWordIndex].selectArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGPKAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGPKAnswerCell"];
	LGPKWordModel *pkWord = self.pkModel.words[self.currentWordIndex];
    cell.answerLabel.text = pkWord.selectArray[indexPath.section];
	cell.type = LGPKAnswerCellNormal;
	return cell;
}

#pragma mark -UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//答题所用时间
	[LGTool cancelTimer:timer];
	NSInteger duration = countDown - self.currentTime;
	
	tableView.allowsSelection = NO;
	
	/**
	 * 用户选择正确答案时,正确个数+1
	 * 如果选择不是正确答案时,把正确答案改成选中状态(selected),用户选择的错误答案改成错误高亮(setWrong方法)
	 */
	if (indexPath.section == self.currentWordModel.trueAnswerIndex) {
		self.userRighCount++;
	}else{
		NSIndexPath *trueIndexPath = [NSIndexPath indexPathForRow:0 inSection:self.currentWordModel.trueAnswerIndex];
		LGPKAnswerCell *trueCell = [tableView cellForRowAtIndexPath:trueIndexPath];
		trueCell.type = LGPKAnswerCellRigh;
		
		LGPKAnswerCell *userCell = [tableView cellForRowAtIndexPath:indexPath];
		userCell.type = LGPKAnswerCellWrong;
	}
	//用户正确率 百分比
	self.userAccuracy = self.userRighCount / (self.currentWordIndex + 1) * 100;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		NSString *userAnswer = self.currentWordModel.selectArray[indexPath.section];
		[self nextQuestionWithCurrentAnswer:userAnswer duration:duration];
	});
}


/**
 更新正确率进度条
 */
- (void)updateAccuracyProgress{
	//计算双方正确率和
	CGFloat totalAccuracy = self.opponentAccuracy + self.userAccuracy;
	//当前用户正确率占比
	CGFloat userAccuracyProgress = 0;
	//对手正确率占比
	CGFloat opponentAccuracyProgress = 0;
	if (totalAccuracy != 0) {
		userAccuracyProgress = self.userAccuracy / totalAccuracy;
		opponentAccuracyProgress = self.opponentAccuracy / totalAccuracy;
	}
	//设置进度条进度,双方正确率都为0时,进度为 50%
	CGFloat tem = userAccuracyProgress + opponentAccuracyProgress;
	self.winProgressView.progress = tem == 0 ? 0.5 : userAccuracyProgress / tem;
}

- (void)dealloc{
	[LGTool cancelTimer:timer];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"PKToResult"]) {
		LGPKResultController *result = segue.destinationViewController;
		result.opponentUserModel = self.opponentModel;
		result.currentUserModel  = self.currentUserModel;
		result.pkModel = self.pkModel;
	}
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
