//
//  LGPKIndexViewController.h
//  Word
//
//  Created by Charles Cao on 2018/3/13.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGProgressView.h"

@interface LGPKIndexViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *uesrNameLabel;

//胜率
@property (weak, nonatomic) IBOutlet LGProgressView *winProgressView;

@property (weak, nonatomic) IBOutlet UILabel *winLabel;

@property (weak, nonatomic) IBOutlet UILabel *loseLabel;
//词汇量
@property (weak, nonatomic) IBOutlet UILabel *vocabularyLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
