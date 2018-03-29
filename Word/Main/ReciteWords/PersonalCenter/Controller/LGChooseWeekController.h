//
//  LGChooseWeekController.h
//  Word
//
//  Created by Charles Cao on 2018/3/29.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LGChooseWeekControllerDelegate

- (void)selectedWeek:(NSArray *)weakArr;

@end

@interface LGChooseWeekController : UIViewController

@property (nonatomic, weak) id<LGChooseWeekControllerDelegate> delegate;

/**
 默认选中星期 @[@"1",@"2", @"3", ....]
 */
@property (nonatomic, copy) NSArray *defaultSelect;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
