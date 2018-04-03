//
//  LGEstimateRankController.h
//  Word
//
//  Created by Charles Cao on 2018/4/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGEstimateRankController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

//词汇量
@property (weak, nonatomic) IBOutlet UILabel *vocabularyLabel;
//排名
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

@end
