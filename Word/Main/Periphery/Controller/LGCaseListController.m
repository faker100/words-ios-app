//
//  LGCaseListController.m
//  Word
//
//  Created by Charles Cao on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGCaseListController.h"
#import "LGPeripheryCaseCell.h"
#import "LGPeripheryModel.h"
#import "LGCaseDetailController.h"
#import "UIScrollView+LGRefresh.h"

@interface LGCaseListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <LGCaseModel *> *caseList;

@end

@implementation LGCaseListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData:YES];
	__weak typeof(self) weakSelf = self;
	[self.tableView setHeaderRefresh:^{
        [weakSelf requestData:NO];
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData:(BOOL) showLoading{
    if (showLoading) {
        [LGProgressHUD showHUDAddedTo:self.view];
    }
	[self.request requestCaseListCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			[self.tableView lg_endRefreshing];
			self.caseList = [LGCaseModel mj_objectArrayWithKeyValuesArray:response];
		}
	}];
}

- (void)setCaseList:(NSMutableArray<LGCaseModel *> *)caseList{
	_caseList = caseList;
	[self.tableView reloadData];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.caseList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGPeripheryCaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGPeripheryCaseCell"];
	cell.caseModel = self.caseList[indexPath.row];
	return cell;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self performSegueWithIdentifier:@"caseListToCaseDetail" sender:self.caseList[indexPath.row]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	LGCaseDetailController *controller = segue.destinationViewController;
	controller.caseModel = sender;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
