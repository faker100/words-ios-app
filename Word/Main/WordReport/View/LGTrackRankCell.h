//
//  LGTrackRankCell.h
//  Word
//
//  Created by Charles Cao on 2018/3/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGTrackRankCell : UITableViewCell

//排名
@property (weak, nonatomic) IBOutlet UIButton *rankButton;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

//用户名
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

//词汇量
@property (weak, nonatomic) IBOutlet UILabel *vocabularyLabel;
@end
