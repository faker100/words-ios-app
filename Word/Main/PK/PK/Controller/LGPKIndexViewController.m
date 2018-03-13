//
//  LGPKIndexViewController.m
//  Word
//
//  Created by Charles Cao on 2018/3/13.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKIndexViewController.h"
#import "LGPKRankingCell.h"
#import "UITableView+LGRefresh.h"
#import "LGPKRankModel.h"
#import "LGPKRankHeadView.h"

@interface LGPKIndexViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) LGPKRankModel *rankModel;

@end

@implementation LGPKIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self configTable];
}

- (void)viewWillAppear:(BOOL)animated{
	[self requestData];
}

- (void)configTable{
	
	[self configTableHeadView:[LGUserManager shareManager].user];
	[self.tableView setHeaderRefresh:^{
		[self requestData];
	}];
	[self.tableView registerNib:[UINib nibWithNibName:@"LGPKRankHeadView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LGPKRankHeadView"];
}

- (void)requestData{
	[self.request requestPKRankCompletion:^(id response, LGError *error) {
		[self.tableView lg_endRefreshing];
		if ([self isNormal:error]) {
			self.rankModel = [LGPKRankModel mj_objectWithKeyValues:response];
		}
	}];
}

- (void)setRankModel:(LGPKRankModel *)rankModel{
	_rankModel = rankModel;
	
	_rankModel.rankingList = @[rankModel.rankingList.firstObject,rankModel.rankingList.firstObject,rankModel.rankingList.firstObject,rankModel.rankingList.firstObject,rankModel.rankingList.firstObject,rankModel.rankingList.firstObject,rankModel.rankingList.firstObject,rankModel.rankingList.firstObject,rankModel.rankingList.firstObject,rankModel.rankingList.firstObject,rankModel.rankingList.firstObject,rankModel.rankingList.firstObject,rankModel.rankingList.firstObject,rankModel.rankingList.firstObject];
	
	[self configTableHeadView:rankModel.user];
	[self.tableView reloadData];
}


/**
 配置 tableview 的 headerview, 用户自己的 pk 情况

 @param user  userModel
 */
- (void)configTableHeadView:(LGUserModel *)user{
	self.uesrNameLabel.text = user.nickname;
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(user.image)] placeholderImage:PLACEHOLDERIMAGE];
	self.winProgressView.progress = user.win.floatValue / (user.win.floatValue + user.lose.floatValue);
	self.vocabularyLabel.text = user.words;
	self.winLabel.text = [NSString stringWithFormat:@"win : %ld",user.win.integerValue];
	self.loseLabel.text = [NSString stringWithFormat:@"lose : %ld",user.lose.integerValue];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return self.rankModel.rankingList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGPKRankingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGPKRankingCell"];
	[cell setRank:self.rankModel.rankingList[indexPath.row] rangking:indexPath.row + 1];
	return cell;
}

#pragma mark -UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	return [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LGPKRankHeadView"];
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
