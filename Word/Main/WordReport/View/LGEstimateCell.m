//
//  LGEstimateCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGEstimateCell.h"

@implementation LGEstimateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
	
	if (selected) {
		self.contentView.backgroundColor = [UIColor lg_colorWithType:LGColor_theme_Color];
	}else{
		self.contentView.backgroundColor = [UIColor lg_colorWithHexString:@"F1EFE3"];
	}
    // Configure the view for the selected state
}

- (void)setWrong{
	self.wrongImageView.hidden = NO;
}

@end
