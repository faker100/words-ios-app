//
//  LGEstimateRankCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGEstimateRankCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

//词汇量
@property (weak, nonatomic) IBOutlet UILabel *vocabularyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rankIcon;

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;


@end
