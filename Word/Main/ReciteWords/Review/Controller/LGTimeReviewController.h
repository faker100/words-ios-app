//
//  LGTimeReviewController.h
//  Word
//
//  Created by Charles Cao on 2018/3/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGTimeReviewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *startTimeTableView;

@property (weak, nonatomic) IBOutlet UITableView *endTimeTableView;

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@end
