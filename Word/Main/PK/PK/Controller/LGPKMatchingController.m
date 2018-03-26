//
//  LGPKMatchingController.m
//  Word
//
//  Created by Charles Cao on 2018/3/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKMatchingController.h"
#import "JPUSHService.h"
#import "LGJpushReceiveMessageModel.h"
#import "LGUserManager.h"
#import "LGTool.h"
#import "LGAtPKController.h"

@interface LGPKMatchingController ()
{
	dispatch_source_t timer;
}

@property (nonatomic, assign) BOOL disappearWithAgreePK; //离开界面时,是否因为是否同意 pk
@property (nonatomic, strong) LGMatchUserModel *opponentModel;    //对手信息
@property (nonatomic, strong) LGMatchUserModel *currentUserModel; //当前用户信息

@end

@implementation LGPKMatchingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	//倒计时图片不变形
	self.countDownButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
	//用户默认头像
	[self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN([LGUserManager shareManager].user.image)] placeholderImage:[UIImage imageNamed:@"pk_default_opponent"]];
	
	//设置匹配中
	[self setMatchType:LGMatching animated:NO];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	self.edgesForExtendedLayout=UIRectEdgeTop;
	
	[self addNotification];
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
	
}

- (void)viewDidDisappear:(BOOL)animated{
	[super viewDidDisappear:animated];
	[self removeNotification];
	
	//当界面消失时,如果不是因为同意 pk跳转的界面, 并且已经匹配成功,则调用取消匹配接口
	if ((!self.disappearWithAgreePK) && self.matchType == LGMatchSuccess) {
		[self requestPkChoice:LGPKChoiceCancel completion:nil];
	}
}

- (void)viewDidLayoutSubviews{
	
	[self uploadHeadRadius];
}

/**
 更新圆形头像
 */
- (void)uploadHeadRadius{
	CGFloat radius = CGRectGetWidth(self.opponentHeadImageView.frame) / 2.0f;
	self.opponentWordNumLabel.layer.cornerRadius = radius;
	self.opponentHeadImageView.layer.cornerRadius = radius;
	self.userWordNumLabel.layer.cornerRadius = radius;
	self.userHeadImageView.layer.cornerRadius = radius;
}

//"匹配中..." 动画
- (void)beginMatchingAnimation{
	NSArray<UIImage *> *imageArray = @[
										[UIImage imageNamed:@"pk_matching0"],
										[UIImage imageNamed:@"pk_matching1"],
										[UIImage imageNamed:@"pk_matching2"],
										[UIImage imageNamed:@"pk_matching3"],
										];
	[self.matchingImageView setAnimationImages:imageArray];
	self.matchingImageView.animationDuration = 1;
	self.matchingImageView.animationRepeatCount = 0;
	[self.matchingImageView startAnimating];
}


- (void)addNotification{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	
	/*********************** 接收自定义消息 **************************/
	
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
	
	/*********************** 退出 app 时 **************************/
	[defaultCenter addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
}

- (void)removeNotification{
	
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	
	[defaultCenter removeObserver:self name:kJPFNetworkDidReceiveMessageNotification object:nil];
	[defaultCenter removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
}

//杀死 app 时
- (void)applicationWillTerminate{
	
	[self requestPkChoice:LGPKChoiceCancel completion:nil];
}

/**
 接受自定义消息
 userInfo 中 type = 1 匹配对手成功
 			 type = 2 都准备成功,跳转 pk界面
             type = 3 取消对手
 
 */
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
	
	LGJPushReceiveMessageModel *pushModel = [LGJPushReceiveMessageModel mj_objectWithKeyValues:userInfo];
	
	if (pushModel.extras.type == 1) {
		LGMatchModel *matchModel = pushModel.extras.message;
		[self setMatchType:LGMatchSuccess animated:YES];
		if ([matchModel.user1.uid isEqualToString:[LGUserManager shareManager].user.uid]) {
			self.currentUserModel = matchModel.user1;
			self.opponentModel = matchModel.user2;
		}else{
			self.currentUserModel = matchModel.user2;
			self.opponentModel = matchModel.user1;
		}
	}else if (pushModel.extras.type == 2){
		self.disappearWithAgreePK = YES;
		[self performSegueWithIdentifier:@"matchPkToBeginPk" sender:pushModel.extras.message];
	}else if (pushModel.extras.type == 3){
		[LGProgressHUD showMessage:pushModel.content toView:self.view.window];
		[self setMatchType:LGMatching animated:YES];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重新匹配
- (IBAction)rematchAction:(id)sender {
	
	__weak typeof(self) weakSelf = self;
	[self requestPkChoice:LGPKChoiceCancel completion:^{
		[weakSelf setMatchType:LGMatching animated:YES];
	}];
}

//开始 pk
- (IBAction)beginPkAction:(id)sender {
	
	[self requestPkChoice:LGPKChoiceAgree completion:^{
		if (timer) {
			dispatch_source_cancel(timer);
		}
	}];
}

//设置对手信息
- (void)setOpponentModel:(LGMatchUserModel *)opponentModel{
	_opponentModel = opponentModel;
	self.opponentWinLabel.text     = [NSString stringWithFormat:@"win : %@",opponentModel.win];
	self.opponentLoseLabel.text    = [NSString stringWithFormat:@"lose : %@",opponentModel.lose];
	self.opponentNameLabel.text    = opponentModel.nickname;
	self.opponentWordNumLabel.attributedText = [self wordNumAttributeString:opponentModel.words];
	[self.opponentHeadImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(opponentModel.image)] placeholderImage:[UIImage imageNamed:@"pk_default_opponent"]];
}

//设置当前用户信息
- (void)setCurrentUserModel:(LGMatchUserModel *)currentUserModel{
	_currentUserModel = currentUserModel;
	self.userWinLabel.text     = [NSString stringWithFormat:@"win : %@",currentUserModel.win];
	self.userLoseLabel.text    = [NSString stringWithFormat:@"lose : %@",currentUserModel.lose];
	self.userNameLabel.text    = currentUserModel.nickname;
	self.userWordNumLabel.attributedText = [self wordNumAttributeString:currentUserModel.words];
	[self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(currentUserModel.image)] placeholderImage:[UIImage imageNamed:@"pk_default_opponent"]];
}


/**
 获取单词量的AttributeString

 @param wordNum 单词量
 */
- (NSAttributedString *)wordNumAttributeString:(NSString *)wordNum{
	NSString *str = [NSString stringWithFormat:@"词汇量 : %@",wordNum];
	NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:str];
	[attribute addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, str.length)];
	[attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, str.length)];
	[attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(str.length - wordNum.length, wordNum.length)];
	return attribute;
}


/**
 同意 / 取消 pk

 @param choice  pk选择
 @completion 请求后回调
 */
- (void)requestPkChoice:(LGPKChoice)choice completion:(void(^)(void))completion {
	
	[self.request requestPkChoice:choice opponentUid:self.opponentModel.uid completion:^(id response, LGError *error) {
		
		if ([self isNormal:error]) {
			if (completion) completion();
		}
	}];
}

/**
 切换 匹配中/匹配成功状态

 @param matchType 状态
 @param animated 是否动画
 */
- (void)setMatchType:(LGMatchingType)matchType animated: (BOOL)animated{
	self.matchType = matchType;
	
	//切换 匹配中 后 发起匹配请求
	if (matchType == LGMatching) {
		[self.request requestPkMatchingCompletion:^(id response, LGError *error) {
			if ([self isNormal:error]) {
				
			}
		}];
	}
	
	//隐藏动画持续时间
	NSTimeInterval duration = animated ? 0.3 : 0;
	
	//是否匹配中
	BOOL isMatching = matchType == LGMatching;
	
	//所有需要隐藏的view
	NSMutableArray <UIView *> *hiddenView = [NSMutableArray arrayWithArray:@[
									   self.countDownButton,
									   self.opponentWinLabel,
									   self.opponentWordNumLabel,
									   self.opponentNameLabel,
									   self.opponentLoseLabel,
									   self.userWinLabel,
									   self.userLoseLabel,
									   self.userWordNumLabel,
									   self.userNameLabel,
									   ]];
	[hiddenView addObjectsFromArray:self.iconArray];
	
	//遍历隐藏
	[hiddenView enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		
		[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			obj.alpha = isMatching ? 0 : 1;
		} completion:^(BOOL finished) {
			obj.hidden = isMatching;
		}];
	}];
	//隐藏底部按钮
	self.bottomButtonConstraint.constant = isMatching ? 0 : -70;
	[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		[self.view layoutIfNeeded];
		[self uploadHeadRadius];
	} completion:nil];
	//重新倒计时,取消之前的倒计时
	if (timer) {
		dispatch_source_cancel(timer);
	}
	
	//显示 "匹配中..."
	if (isMatching) {
		[self beginMatchingAnimation];
	}else{
		[self.matchingImageView stopAnimating];
		self.matchingImageView.image = [UIImage imageNamed:@"pk_match_success"];
		
		//倒计时到了后,取消匹配
		timer = [LGTool beginCountDownWithSecond:15 completion:^(NSInteger currtentSecond) {
			[self.countDownButton setTitle:[NSString stringWithFormat:@"倒计时 : %lds",currtentSecond] forState:UIControlStateNormal];
			if (currtentSecond == 0) {
				[self.navigationController popViewControllerAnimated:YES];
			}
		}];
	}
}


- (void)dealloc{
	if (timer) {
		dispatch_source_cancel(timer);
	}
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([segue.identifier isEqualToString:@"matchPkToBeginPk"]) {
		LGAtPKController *atPKController = segue.destinationViewController;
		atPKController.pkModel = sender;
		atPKController.opponentModel = self.opponentModel;
		atPKController.currentUserModel = self.currentUserModel;
	}
}

@end


@implementation  LGMatchToPKSegue


/**
 自定义跳转,先正常 push保证匹配页面controller的 各种 生命周期函数调用, 再在 navigation.controllers 中去移除匹配页面,使pk页面返回时,不出现匹配页面
 */
- (void)perform{
	
	UIViewController *sourceVC = self.sourceViewController;
	UIViewController *destinationVC = self.destinationViewController;
	[sourceVC.navigationController pushViewController:destinationVC animated:YES];
	
	NSMutableArray  *controllers = [NSMutableArray arrayWithArray:sourceVC.navigationController.viewControllers];
	[controllers removeObject:sourceVC];
	[sourceVC.navigationController setViewControllers:controllers animated:YES];
}

@end



