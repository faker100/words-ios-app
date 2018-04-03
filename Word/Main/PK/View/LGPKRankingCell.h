//
//  LGPKRankingCell.h
//  Word
//
//  Created by Charles Cao on 2018/3/13.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGPKRankModel.h"

@interface LGPKRankingCell : UITableViewCell

//排名
@property (weak, nonatomic) IBOutlet UIButton *rankButton;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (weak, nonatomic) IBOutlet UILabel *loseLabel;
//词汇量
@property (weak, nonatomic) IBOutlet UILabel *vocabularyLabel;


/**
 设置 cell model

 @param rankModel LGRank
 @param ranking 排名, 从1开始
 */
- (void)setRank:(LGRank *)rankModel rangking:(NSInteger)ranking;

@end
