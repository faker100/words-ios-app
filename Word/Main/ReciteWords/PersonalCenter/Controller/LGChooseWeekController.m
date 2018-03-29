//
//  LGChooseWeekController.m
//  Word
//
//  Created by Charles Cao on 2018/3/29.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGChooseWeekController.h"
#import "LGChooseWeekCell.h"
#import "LGClockModel.h"

@interface LGChooseWeekController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LGChooseWeekController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self.defaultSelect enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		NSInteger row = [NSString stringWithFormat:@"%@",obj].integerValue - 1;
		NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
		[self.tableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sureAction:(id)sender {
	
	NSArray<NSIndexPath *> *indexPaths = self.tableView.indexPathsForSelectedRows;
	
	indexPaths = [indexPaths sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
		return ((NSIndexPath *)obj1).row > ((NSIndexPath *)obj2).row;
	}];
	
	
	NSMutableArray *tempArr = [NSMutableArray array];
		
	[indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			[tempArr addObject:@(obj.row + 1).stringValue];
	}];
	[self.delegate selectedWeek:tempArr];
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGChooseWeekCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGChooseWeekCell"];
	cell.weekLabel.text = [LGClockModel weekNumToString:@(indexPath.row + 1).stringValue];
	return cell;
}

#pragma mark -UITableViewDelegate

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
