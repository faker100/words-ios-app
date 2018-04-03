//
//  LGEstimateRankCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGEstimateRankCell.h"

@implementation LGEstimateRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRankModel:(LGEstimateRankModel *)model rank:(NSInteger)rank{
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(model.image)] placeholderImage:PLACEHOLDERIMAGE];
	self.usernameLabel.text = model.nickname;
	self.vocabularyLabel.text = model.num;
	self.rankLabel.text = @(rank).stringValue;
	
	if (rank < 4) {
		self.rankIcon.image = [UIImage imageNamed:@"report_rank"];
		self.rankLabel.textColor = [UIColor whiteColor];
		switch (rank) {
			case 1:
				self.rankIcon.tintColor = [UIColor lg_colorWithType:LGColor_Yellow];
				break;
			case 2:
				self.rankIcon.tintColor = [UIColor lg_colorWithHexString:@"b5b8b5"];
				break;
			case 3:
				self.rankIcon.tintColor = [UIColor lg_colorWithHexString:@"d9a771"];
				break;
				
			default:
				break;
		}
	}else{
		self.rankIcon.image = [UIImage imageNamed:@"estimate_rank_other_bg"];
		self.rankLabel.textColor = [UIColor lg_colorWithType:LGColor_Title_2_Color];
	}
	
}

@end
