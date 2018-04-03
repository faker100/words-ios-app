//
//  LGEstimateResultController.h
//  Word
//
//  Created by Charles Cao on 2018/4/3.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGEstimateResultController : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

//水平
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;

//打败用户
@property (weak, nonatomic) IBOutlet UILabel *winLabel;

@end
