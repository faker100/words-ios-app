//
//  LGClockListController.m
//  Word
//
//  Created by Charles Cao on 2018/3/29.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGClockListController.h"
#import "LGClockListCell.h"
#import "LGAddClockController.h"
#import "LGClockManager.h"
#import "LGTool.h"


@interface LGClockListController () <UITableViewDelegate, UITableViewDataSource, LGAddClockControllerDelegate,LGClockListCellDelegate>


@property (nonatomic, strong) NSMutableArray<LGClockModel *> *clockArray;

@end

@implementation LGClockListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[LGClockManager shareManager] checkAllClock];
	self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 85;
	self.clockArray = [LGClockManager allClocks];
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[LGTool checkDevicePermissions:LGDeviceNotification];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.clockArray.count == 0) {
		[self showAlertMessage:@"还未添加闹钟，请点击右上角+号添加"];
	}else{
		[self removeAlertMessage];
	}
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[LGClockManager shareManager] removeClock:self.clockArray[indexPath.row]];
        [self.clockArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - LGAddClockControllerDelegate
- (void)saveClock:(LGClockModel *)clockModel{

	//不在数组中,为添加新闹钟
	if ([self.clockArray containsObject:clockModel]) {
        [[LGClockManager shareManager] updateClockDate:clockModel completion:^(BOOL isSuccess) {
            if (!isSuccess) {
                [LGProgressHUD showMessage:@"更新失败" toView:self.view];
            }
        }];
    }else{
        [[LGClockManager shareManager] addClock:clockModel completion:^(BOOL isSuccess) {
            if (isSuccess) {
                [self.clockArray addObject:clockModel];
                [self.tableView reloadData];
            }else{
                [LGProgressHUD showMessage:@"添加失败" toView:self.view];
            }
        }];
    }

	[self.tableView reloadData];
}

#pragma mark - LGClockListCellDelegate
- (void)setUseClock:(LGClockModel *)clock isUse:(BOOL)isUse{
    
    clock.isUse = isUse;
    //更新本地闹钟
    [[LGClockManager shareManager] updateClockUse:clock completion:^(BOOL isSuccess) {
        if (!isSuccess) {
            [LGProgressHUD showMessage:@"更新失败" toView:self.view];
        }
    }];
    [self.tableView reloadData];
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
