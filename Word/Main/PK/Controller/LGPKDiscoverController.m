//
//  LGPKDiscoverController.m
//  Word
//
//  Created by caoguochi on 2018/4/3.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKDiscoverController.h"
#import "LGPKDiscoverCell.h"
#import "UITableView+LGRefresh.h"
#import "LGDiscoverDetailController.h"

@interface LGPKDiscoverController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<LGPKDiscoverModel *> *discoverArray;

@end

@implementation LGPKDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.discoverArray = [NSMutableArray array];
	[self configTable];
    [self requestData];
}

- (void)configTable{
	//按屏幕比例获取 cell 高度, 20为 table 左右 inset
	self.tableView.rowHeight =   183.0 / 375.0 * (SCREEN_WIDTH - 20);
	[self.tableView setRefreshBlock:^(LGCurrentRefreshType type) {
		[self requestData];
	}];
}


- (void)requestData{
    [self.request requestPKDiscoverWithPage:self.tableView.currentPage completion:^(id response, LGError *error) {
		[self.tableView lg_endRefreshing];
		if ([self isNormal:error]) {
			
			NSMutableArray *newModelArray = [LGPKDiscoverModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
			
			if (self.tableView.currentPage == 1) {
				[self.discoverArray setArray:newModelArray];
				[self.tableView reloadData];
			}else{
				[self.discoverArray addObjectsFromArray:newModelArray];
				[self.tableView addMoreDataWithType:LGTableReloadOnlySection count:newModelArray.count];
			}
		}
    }];
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.discoverArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGPKDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGPKDiscoverCell"];
	cell.discoverModel = self.discoverArray[indexPath.section];
	return cell;
}

#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self performSegueWithIdentifier:@"discoverListToDiscoverDetail" sender:self.discoverArray[indexPath.section]];
	
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	LGDiscoverDetailController *detailController = segue.destinationViewController;
	detailController.discoverModel = sender;
	
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
