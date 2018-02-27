//
//  LGIndexReviewAlertView.h
//  Word
//
//  Created by Charles Cao on 2018/2/24.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGIndexReviewModel.h"

@interface LGIndexReviewAlertView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) LGIndexReviewModel *reviewModel;

@property (weak, nonatomic) IBOutlet UILabel *wordLibNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
