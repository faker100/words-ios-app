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

//倒计时时间
NSInteger countDown = 10;

@interface LGAtPKController () <UITableViewDelegate, UITableViewDataSource>
{
	dispatch_source_t timer;
}
@property (nonatomic, assign) NSInteger currentWordIndex;//当前单词 在 pkModel.words 中的 index
@property (nonatomic, strong) LGPKWordModel *currentWordModel; //当前显示单词

@property (nonatomic, assign) NSInteger currentTime; //当前倒计时

@end

@implementation LGAtPKController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self.navigationController setNavigationBarHidden:YES];
	[self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(self.currentUserModel.image)] placeholderImage:[UIImage imageNamed:@"pk_default_opponent"]];
	[self.opponentImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(self.opponentModel.image)] placeholderImage:[UIImage imageNamed:@"pk_default_opponent"]];
	self.currentWordModel = self.pkModel.words.firstObject;
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

- (void)networkDidReceiveMessage:(NSNotification *)notification {
	NSLog(@"%@",notification.userInfo);
}

//退出 app
- (void)applicationExit{
	[self.request requestPKExit:self.currentUserModel.uid totalId:self.pkModel.totalId currentQuestionIndex:self.currentWordIndex duration:countDown - self.currentTime];
}

//激活 app
- (void)applicationBecomeActive{
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestPKConnect:self.currentUserModel.uid totalId:self.pkModel.totalId completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			
		}
	}];
}

- (IBAction)playAudio:(id)sender {
	[[LGPlayer sharedPlayer]playWithUrl:self.currentWordModel.uk_audio completion:nil];
}


#pragma mark - setter getter
- (void)setCurrentWordModel:(LGPKWordModel *)currentWordModel{
	_currentWordModel = currentWordModel;
	self.wordLabel.text = currentWordModel.word;
	[self.audioButton setTitle:currentWordModel.phonetic_uk forState:UIControlStateNormal];
	self.tableView.allowsSelection = YES;
	[self.tableView reloadData];
	[self beginCountDown:countDown];
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
	if (timer) {
		dispatch_source_cancel(timer);
	}
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
		
	}else{
		self.currentWordModel = words[self.currentWordIndex + 1];
	}
}


/**
 提交答案

 @param chooseAnswer 用户答案
 @param duration 使用时长
 */
- (void)commitAnswer:(NSString *)chooseAnswer duration:(NSInteger)duration{
	
	LGPKAnswerType type = [chooseAnswer isEqualToString:self.currentWordModel.answer] ? LGPKAnswerTrue : LGPKAnswerFalse;
	
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
	[cell setNormal];
	return cell;
}

#pragma mark -UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 48;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//答题所用时间
	if (timer) {
		dispatch_source_cancel(timer);
	}
	NSInteger duration = countDown - self.currentTime;
	
	tableView.allowsSelection = NO;
	
	//如果选择不是正确答案时,把正确答案高亮(setWrong)
	if (indexPath.section != self.currentWordModel.trueAnswerIndex) {
		NSIndexPath *trueIndexPath = [NSIndexPath indexPathForRow:0 inSection:self.currentWordModel.trueAnswerIndex];
		LGPKAnswerCell *cell = [tableView cellForRowAtIndexPath:trueIndexPath];
		[cell setWrong];
	}
	//1秒之后
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		NSString *userAnswer = self.currentWordModel.selectArray[indexPath.section];
		[self nextQuestionWithCurrentAnswer:userAnswer duration:duration];
	});
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
