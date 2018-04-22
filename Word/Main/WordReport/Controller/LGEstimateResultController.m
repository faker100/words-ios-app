//
//  LGEstimateResultController.m
//  Word
//
//  Created by Charles Cao on 2018/4/3.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGEstimateResultController.h"
#import "LGEstimateResultCell.h"
#import "LGEstimateResultHeaderView.h"
#import "LGEstimateResultModel.h"
#import "LGUserManager.h"
#import "LGCoreTextArcView.h"
#import "LGUserManager.h"
#import "LGTool.h"

@interface LGEstimateResultController () <UITableViewDelegate, UITableViewDataSource,LGEstimateResultHeaderDelegate>

@property (nonatomic, strong) LGEstimateResultModel *resultModel;
@property (nonatomic, assign) BOOL isOpen;

@end

@implementation LGEstimateResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.isOpen = YES;
	[self configTable];
	[self requestData];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData{
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestEstimateResultCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.resultModel = [LGEstimateResultModel mj_objectWithKeyValues:response[@"result"]];
		}
	}];
}

- (void)configTable{
	[self.tableView registerNib:[UINib nibWithNibName:@"LGEstimateResultHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LGEstimateResultHeaderView"];
	
	LGUserModel *user = [LGUserManager shareManager].user;
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(user.image)] placeholderImage:PLACEHOLDERIMAGE];
	self.usernameLabel.text = user.nickname;
}

- (void)setResultModel:(LGEstimateResultModel *)resultModel{
	
	_resultModel = resultModel;

    /**
     * 词汇量
     */
    [LGUserManager shareManager].user.estimateWords = resultModel.num;
    NSString *vocabularyStr = [NSString stringWithFormat:@"词汇量:%@",resultModel.num];
    UIFont *font  = [UIFont boldSystemFontOfSize:18];
    
    LGCoreTextArcView *vocabulary = [[LGCoreTextArcView alloc]initWithFrame:self.textArcView.frame font:font text:vocabularyStr radius:145 arcSize:60 color:[UIColor whiteColor]];
    vocabulary.backgroundColor = [UIColor clearColor];
    [self.view addSubview:vocabulary];
    
	/**
	 * 水平 AttributedString
	 */
	NSString *levelStr = [NSString stringWithFormat:@"%@ 水平",resultModel.level];
	NSMutableAttributedString *levelAttribute = [[NSMutableAttributedString alloc]initWithString:levelStr];
	[levelAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_Title_1_Color] range:NSMakeRange(0, levelStr.length)];
	[levelAttribute addAttribute:NSFontAttributeName	 value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, levelStr.length)];
	
	[levelAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_theme_Color] range:[levelStr rangeOfString:resultModel.level]];
	[levelAttribute addAttribute:NSFontAttributeName	 value:[UIFont systemFontOfSize:20] range:[levelStr rangeOfString:resultModel.level]];
	self.gradeLabel.attributedText = levelAttribute;
	
	/**
	 * 打败全国 AttributedString
	 */
	NSString *bitStr = [NSString stringWithFormat:@"打败全国大约%ld%%的用户",resultModel.bit];
	NSRange bitRange = [bitStr rangeOfString: [NSString stringWithFormat:@"%ld%%",resultModel.bit]];
	NSMutableAttributedString *bitAttribute = [[NSMutableAttributedString alloc]initWithString:bitStr];
	[bitAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, bitStr.length)];
	[bitAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_Title_1_Color] range:NSMakeRange(0, bitStr.length)];
	[bitAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_theme_Color] range:bitRange];
	self.winLabel.attributedText = bitAttribute;
	
	[self.tableView reloadData];
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.resultModel ? 2 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return section == 0 ? self.resultModel.rateArray.count : 0;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGEstimateResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGEstimateResultCell"];
	BOOL isLast = indexPath.section == 0 && indexPath.row == self.resultModel.rateArray.count - 1;
	[cell setRateModel:self.resultModel.rateArray[indexPath.row] isLast:isLast];
	return cell;
}

#pragma mark -UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	LGEstimateResultHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LGEstimateResultHeaderView"];
	if (section == 0) {
		headView.delegate = self;
		[headView setNum:self.resultModel.know type:LGEstimateResultKnow];
	}else{
		headView.delegate = nil;
		[headView setNum:self.resultModel.notKnow type:LGEstimateResultNotKnow];
	}
	return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return self.isOpen ? 30 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - LGEstimateResultHeaderDelegate

- (void)tapAction{
	self.isOpen = !self.isOpen;
	
	NSMutableArray *indexPathArray = [NSMutableArray array];
	for (int i = 0; i < self.resultModel.rateArray.count; i++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
		[indexPathArray addObject:indexPath];
	}
	
	[self.tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
}


- (IBAction)shareAction:(id)sender {
    UIImage *image = [LGTool screenshotFromView:self.view.window];
    [self shareTitle:@"" text:@"" image:image url:nil type:SSDKContentTypeImage];
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
