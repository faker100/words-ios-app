//
//  LGEstimateRankCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGEstimateRankModel.h"

@interface LGEstimateRankCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

//词汇量
@property (weak, nonatomic) IBOutlet UILabel *vocabularyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rankIcon;

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;


/**
 设置排名

 @param model 数据
 @param rank 排名
 */
- (void)setRankModel:(LGEstimateRankModel *)model rank:(NSInteger)rank;

@end
