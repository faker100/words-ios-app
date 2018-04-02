//
//  LGEstimateRankController.m
//  Word
//
//  Created by Charles Cao on 2018/4/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGEstimateRankController.h"
#import "LGEstimateRankCell.h"

@interface LGEstimateRankController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation LGEstimateRankController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
	return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGEstimateRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGEstimateRankCell"];
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
