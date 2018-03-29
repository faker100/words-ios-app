//
//  LGClockListController.m
//  Word
//
//  Created by Charles Cao on 2018/3/29.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGClockListController.h"
#import "LGClockListCell.h"
#import "LGUserManager.h"
#import "LGAddClockController.h"

@interface LGClockListController () <UITableViewDelegate, UITableViewDataSource, LGAddClockControllerDelegate,LGClockListCellDelegate>

@property (nonatomic, strong) NSMutableArray<LGClockModel *> *clockArray;

@end

@implementation LGClockListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.tableView.tableFooterView = [UIView new];
	self.clockArray = [LGUserManager shareManager].clockArray;
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.clockArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGClockListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGClockListCell"];
	cell.clockModel = self.clockArray[indexPath.row];
	cell.delegate = self;
	return cell;
}

#pragma mark -UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self performSegueWithIdentifier:@"clockListToEdit" sender:self.clockArray[indexPath.row]];
}

#pragma mark - LGAddClockControllerDelegate
- (void)saveClock:(LGClockModel *)clockModel{
	
	//不在数组中,为添加新闹钟
	if (![self.clockArray containsObject:clockModel]) {
		[self.clockArray addObject:clockModel];
	}
	[LGUserManager shareManager].clockArray = self.clockArray;
	[self.tableView reloadData];
}

#pragma mark - LGClockListCellDelegate
- (void)setUseClock:(LGClockModel *)clock isUse:(BOOL)isUse{
	clock.isUse = isUse;
	[LGUserManager shareManager].clockArray = self.clockArray;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([segue.identifier isEqualToString:@"clockListToEdit"]) {
		LGAddClockController *addController = segue.destinationViewController;
		addController.clockModel = [sender isKindOfClass:[LGClockModel class]] ? sender : nil;
		addController.delegate = self;
	}
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
