//
//  LGTrackFinishProgressCell.m
//  Word
//
//  Created by Charles Cao on 2018/3/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTrackFinishProgressCell.h"

@implementation LGTrackFinishProgressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setRank:(LGRank *)rankModel rangking:(NSInteger)ranking {
//	UIImage *rankImage = nil;
//	NSString *rankStr = @"";
//	if (ranking == 1) {
//		rankImage = [UIImage imageNamed:@"pk_first"];
//	}else if (ranking == 2){
//		rankImage = [UIImage imageNamed:@"pk_second"];
//	}else if (ranking == 3){
//		rankImage = [UIImage imageNamed:@"pk_third"];
//	}else{
//		rankStr = @(ranking).stringValue;
//	}
//	[self.rankButton setTitle:rankStr forState:UIControlStateNormal];
//	[self.rankButton setImage:rankImage forState:UIControlStateNormal];
//
//	self.usernameLabel.text = rankModel.nickname;
//	self.winLabel.text = [NSString stringWithFormat:@"win : %@",rankModel.win];
//	self.loseLabel.text = [NSString stringWithFormat:@"lose : %@",rankModel.lose];
//	self.vocabularyLabel.text = rankModel.userWords;
//}

@end
