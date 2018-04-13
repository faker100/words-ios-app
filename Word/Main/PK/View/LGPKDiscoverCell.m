//
//  LGPKDiscoverCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/4.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKDiscoverCell.h"

@implementation LGPKDiscoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDiscoverModel:(LGPKDiscoverModel *)discoverModel{
	_discoverModel = discoverModel;
	[self.bgImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(discoverModel.image)]];
	self.discoverTitleLabel.text = discoverModel.title;
	self.dateLabel.text = discoverModel.date;
}

@end
