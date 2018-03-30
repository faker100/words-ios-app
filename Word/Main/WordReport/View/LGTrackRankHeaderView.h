//
//  LGTrackRankHeaderView.h
//  Word
//
//  Created by Charles Cao on 2018/3/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGTrackRankHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
//词汇量
@property (weak, nonatomic) IBOutlet UILabel *vocabularyLabel;
//排名
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

@end
