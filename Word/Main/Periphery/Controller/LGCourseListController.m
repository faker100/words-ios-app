//
//  LGCourseListController.m
//  Word
//
//  Created by Charles Cao on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGCourseListController.h"
#import "LGCourseListCell.h"
#import "LGCourseModel.h"
#import "UIScrollView+LGRefresh.h"
#import "LGCourseDetailController.h"
#import "LGTryListenController.h"

@interface LGCourseListController ()<UITableViewDataSource, UITableViewDelegate, LGCourseListCellDelegate>

@property (nonatomic, strong) NSMutableArray<LGCourseModel *> *courseModel;

@end

@implementation LGCourseListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self requestData];
	__weak typeof(self) weakSelf = self;
	[self.tableView setHeaderRefresh:^{
		[weakSelf requestData];
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requestData{
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestCourseListWithType:self.type completion:^(id response, LGError *error) {
		[self.tableView lg_endRefreshing];
		if ([self isNormal:error]) {
			self.courseModel = [LGCourseModel mj_objectArrayWithKeyValuesArray:response];
		}
	}];
}

- (void)setCourseModel:(NSMutableArray<LGCourseModel *> *)courseModel{
	_courseModel = courseModel;
	[self.tableView reloadData];
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.courseModel.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGCourseListCell"];
	cell.courseModel = self.courseModel[indexPath.section];
	cell.delegate = self;
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
	[self performSegueWithIdentifier:@"courseListToCourseDetail" sender:self.courseModel[indexPath.section]];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - LGCourseListCellDelegate

- (void)tryListen:(LGCourseModel *)model{
	[self performSegueWithIdentifier:@"listToTryListen" sender:model];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"courseListToCourseDetail"]) {
		LGCourseDetailController *controller = segue.destinationViewController;
		controller.courseModel = sender;
	}else if ([segue.identifier isEqualToString:@"listToTryListen"]){
		LGTryListenController *controlle  = segue.destinationViewController;
		controlle.courseModel = sender;
	}
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
