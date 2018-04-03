//
//  LGTrackRankCell.h
//  Word
//
//  Created by Charles Cao on 2018/3/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGTrackModel.h"

@interface LGTrackRankCell : UITableViewCell

//排名
@property (weak, nonatomic) IBOutlet UIButton *rankButton;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

//用户名
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

//词汇量
@property (weak, nonatomic) IBOutlet UILabel *vocabularyLabel;


/**
 设置单词轨迹

 @param rankModel 数据
 @param rank 排名
 */
- (void)setTrackRankModel:(LGTrackRankModel *)rankModel rank:(NSInteger)rank;

@end
