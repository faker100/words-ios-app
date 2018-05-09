//
//  LGEstimateRankController.m
//  Word
//
//  Created by Charles Cao on 2018/4/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGEstimateRankController.h"
#import "LGEstimateRankCell.h"
#import "UITableView+LGRefresh.h"
#import "LGUserManager.h"
#import "LGTool.h"

@interface LGEstimateRankController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<LGEstimateRankModel *> *rankArray;

@end

@implementation LGEstimateRankController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.rankArray = [NSMutableArray array];
	[self requestData:YES];
	[self configUI];
}


- (void)configUI{
    
	[self.tableView setRefreshBlock:^(LGCurrentRefreshType type) {
		[self requestData:NO];
	}];
    
    LGUserModel *user = [LGUserManager shareManager].user;
    [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(user.image)] placeholderImage:PLACEHOLDERIMAGE];
    self.usernameLabel.text = user.nickname;
}

- (IBAction)shareAction:(id)sender {
    UIImage *image = [LGTool screenshotFromView:self.view.window];
    [self shareTitle:@"" text:@"" image:image url:nil type:SSDKContentTypeImage];
}


- (void)requestData:(BOOL)showLoading{
	if (showLoading) {
		[LGProgressHUD showHUDAddedTo:self.view];
	}
	[self.request requestRankList:@(self.tableView.currentPage).stringValue pageSize:@"10" completion:^(id response, LGError *error) {
		[self.tableView lg_endRefreshing];
		if ([self isNormal:error]) {
			NSMutableArray *temp = [LGEstimateRankModel mj_objectArrayWithKeyValuesArray:response[@"rank"]];
			self.rankLabel.text = [NSString stringWithFormat:@"%@",response[@"data"][@"rank"]];
			self.vocabularyLabel.text = [NSString stringWithFormat:@"%@",response[@"data"][@"num"]];
			if (self.tableView.currentPage == 1) {
				[self.rankArray setArray:temp];
				[self.tableView reloadData];
			}else{
				[self.rankArray addObjectsFromArray:temp];
				[self.tableView addMoreDataWithType:LGTableReloadOnlySection count:temp.count];
			}
		}
	}];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidDisappear:(BOOL)animated{
	[super viewDidDisappear:animated];
	[self.navigationController.navigationBar setShadowImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.rankArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGEstimateRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGEstimateRankCell"];
	[cell setRankModel:self.rankArray[indexPath.section] rank:indexPath.section + 1];
	return cell;
}

#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 1;
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
