//
//  LGPKResultController.m
//  Word
//
//  Created by Charles Cao on 2018/3/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKResultController.h"
#import "LGPKResultModel.h"
#import "LGTool.h"
#import "LGPlayer.h"
#import "LGPKResultCell.h"
#import "LGNavigationController.h"
#import "LGUserManager.h"

@interface LGPKResultController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) LGPKResultModel *resultModel;

@end

@implementation LGPKResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.navigationController.navigationBarHidden = NO;
	self.title = @"";
	[self configUserInterface];
	[self requestPKResult];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[[LGPlayer sharedPlayer] stopPkMusic];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	
	[((LGNavigationController *)self.navigationController) transparenceBar:YES];
	
	self.edgesForExtendedLayout = UIRectEdgeTop;
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
	
}

- (void)configUserInterface{
	[self.currentUserHeadImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(self.currentUserModel.image)] placeholderImage:[UIImage imageNamed:@"pk_default_opponent"]];
	self.currentUserNicknameLabel.text = self.currentUserModel.nickname;
	
	[self.opponentHeadImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(self.opponentUserModel.image)] placeholderImage:[UIImage imageNamed:@"pk_default_opponent"]];
	self.opponentNicknameLabel.text = self.opponentUserModel.nickname;
}


/**
 请求 PK 结果
 type 1 pk胜利 0失败
 data 数组, 第一个元素是用户,第二个对手
 */
- (void)requestPKResult{
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestPKResult:self.opponentUserModel.uid totalId:self.pkModel.totalId completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.resultModel = [LGPKResultModel mj_objectWithKeyValues:response];
		}
	}];
}

- (void)setResultModel:(LGPKResultModel *)resultModel{
	_resultModel = resultModel;
	if (resultModel.type.integerValue == 1) {
		if ([LGUserManager shareManager].pkResultSoundFlag) {
			[[LGPlayer sharedPlayer] playWithAudioType:LGAudio_pk_win];
		}
		
		self.resultImageView.image = [UIImage imageNamed:@"pk_result_win"];
		self.userWinImageView.hidden = NO;
		self.currentUserHeadImageView.transform = CGAffineTransformMakeScale(1.3,1.3);
	
	}else{
		if ([LGUserManager shareManager].pkResultSoundFlag) {
			[[LGPlayer sharedPlayer] playWithAudioType:LGAudio_pk_lose];
		}
		self.resultImageView.image = [UIImage imageNamed:@"pk_result_lose"];
		self.opponentWinImageView.hidden = NO;
		self.opponentHeadImageView.transform = CGAffineTransformMakeScale(1.3,1.3);
	}
	self.currentUserWinLabel.text  = [NSString stringWithFormat:@"正确 : %@",resultModel.data.firstObject.aTrue];
	self.currentUserLoseLabel.text = [NSString stringWithFormat:@"错误 : %@",resultModel.data.firstObject.aFalse];
	self.opponentWinLabel.text  = [NSString stringWithFormat:@"正确 : %@",resultModel.data.lastObject.aTrue];
	self.opponentLoseLabel.text = [NSString stringWithFormat:@"错误 : %@",resultModel.data.lastObject.aFalse];
	
	[self.tableView reloadData];
}

//分享
- (IBAction)shareAction:(id)sender {
	//截图前先隐藏按钮
	self.againPkButton.hidden = YES;
	self.shareButton.hidden = YES;
	
	UIImage *image = [LGTool screenshotFromView:self.tableView];
	
	self.againPkButton.hidden = NO;
	self.shareButton.hidden = NO;
	
	[self shareTitle:@"" text:@"" image:image url:nil type:SSDKContentTypeImage];
}

#pragma mark -UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.resultModel.questionInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGPKResultCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"LGPKResultCell"];
	cell.questionInfo = self.resultModel.questionInfo[indexPath.row];
	return cell;
}

#pragma mark -UITableViewDelegate


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
