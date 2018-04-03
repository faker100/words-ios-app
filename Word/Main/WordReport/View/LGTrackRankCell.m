//
//  LGTrackRankCell.m
//  Word
//
//  Created by Charles Cao on 2018/3/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTrackRankCell.h"

@implementation LGTrackRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTrackRankModel:(LGTrackRankModel *)rankModel rank:(NSInteger)rank{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(rankModel.image)] placeholderImage:PLACEHOLDERIMAGE];
    self.usernameLabel.text = rankModel.nickname;
    self.vocabularyLabel.text = rankModel.num;
    
    if (rank < 4) {
        NSString *rankImageName;
        if (rank == 1) rankImageName = @"pk_first";
        if (rank == 2) rankImageName = @"pk_second";
        if (rank == 3) rankImageName = @"pk_third";
        
        [self.rankButton setImage:[UIImage imageNamed:rankImageName] forState:UIControlStateNormal];
        [self.rankButton setTitle:@"" forState:UIControlStateNormal];
        
    }else{
        [self.rankButton setImage:nil forState:UIControlStateNormal];
        [self.rankButton setTitle:@(rank).stringValue forState:UIControlStateNormal];
    }
}

@end
