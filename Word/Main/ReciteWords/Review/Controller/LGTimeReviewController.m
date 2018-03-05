//
//  LGTimeReviewController.m
//  Word
//
//  Created by Charles Cao on 2018/3/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTimeReviewController.h"
#import "LGReviewSelectTimeCell.h"
#import "NSDate+Utilities.h"


@interface LGTimeReviewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSDate *> *startDateArray;   //开始日期数组
@property (nonatomic, strong) NSArray<NSDate *> *endDateArray;     //截止日期数组


@end

@implementation LGTimeReviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.startDateArray = [NSDate dateArrayFrom:[[[NSCalendar currentCalendar] dateWithEra:1 year:2018 month:3 day:1 hour:0 minute:0 second:0 nanosecond:0]convertToSystemTimeZoneDate] toDate:[NSDate currentDay]];
    self.endDateArray = self.startDateArray;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.startTimeTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.startDateArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGReviewSelectTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGReviewSelectTimeCell"];
	cell.date = self.startDateArray[indexPath.row];
	return cell;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[tableView deselectRowAtIndexPath:indexPath animated:YES];
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
