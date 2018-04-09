//
//  LGPublicController.m
//  Word
//
//  Created by Charles Cao on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPublicController.h"
#import "UITableView+LGRefresh.h"
#import "LGPeripheryModel.h"
#import "LGPublicListCell.h"
#import "LGPublicDetailController.h"

@interface LGPublicController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <LGRecentClassModel *> *classArray;

@end

@implementation LGPublicController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self requestData:YES];
	__weak typeof(self) weakSelf = self;
	[self.tableView setRefreshBlock:^(LGCurrentRefreshType type) {
		[weakSelf requestData:NO];
	}];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)requestData:(BOOL)showLoading{
	if (showLoading) {
		[LGProgressHUD showHUDAddedTo:self.view];
	}
	[self.request requestPublickListWithPage:self.tableView.currentPage completion:^(id response, LGError *error) {
		[self.tableView lg_endRefreshing];
		if ([self isNormal:error]) {
			NSMutableArray *newArr = [LGRecentClassModel mj_objectArrayWithKeyValuesArray:response];
			if (self.tableView.currentPage == 1) {
				self.classArray = newArr;
				[self.tableView reloadData];
			}else{
				[self.classArray addObjectsFromArray:newArr];
				[self.tableView addMoreDataWithType:LGTableReloadOnlySection count:newArr.count];
			}
		}
	}];
}


#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.classArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGPublicListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGPublicListCell"];
	cell.classModel = self.classArray[indexPath.section];
	return cell;
}

#pragma mark -UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 6;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self performSegueWithIdentifier:@"publicListToPublicDetail" sender:self.classArray[indexPath.section]];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	 
	 LGPublicDetailController *controller = segue.destinationViewController;
	 controller.classModel = sender;
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 

@end
