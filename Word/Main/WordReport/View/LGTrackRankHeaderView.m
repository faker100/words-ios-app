//
//  LGTrackRankHeaderView.m
//  Word
//
//  Created by Charles Cao on 2018/3/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTrackRankHeaderView.h"
#import "LGUserManager.h"

@implementation LGTrackRankHeaderView

- (void)setUserRankData:(LGTrackUserDataModel *)userRankData{
    _userRankData = userRankData;
    LGUserModel *user = [LGUserManager shareManager].user;
    self.usernameLabel.text = user.nickname;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(user.image)] placeholderImage:PLACEHOLDERIMAGE];
    self.vocabularyLabel.text = @(userRankData.num).stringValue;
    self.rankLabel.text = @(userRankData.rank).stringValue;
}

@end
