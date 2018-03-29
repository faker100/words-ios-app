//
//  LGPersonalCell.m
//  Word
//
//  Created by Charles Cao on 2018/3/12.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPersonalCell.h"

@implementation LGPersonalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSettingModel:(LGSettingModel *)settingModel{
	_settingModel = settingModel;
	self.infoLabel.text 	 = settingModel.info;
	self.infoTitleLabel.text = settingModel.infoTitle;
	
	if (settingModel.type == LGSettingHeadImage) {
		self.infoLabel.hidden = YES;
		self.moreWidthConstraint.constant = 0;
		self.headImageView.hidden = NO;
		
		[self.headImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(settingModel.info)] placeholderImage:PLACEHOLDERIMAGE];
		
	}else if (settingModel.type == LGSettingMore){
		self.infoLabel.hidden = NO;
		self.moreWidthConstraint.constant = 22;
		self.headImageView.hidden = YES;
	}else{
		self.infoLabel.hidden = NO;
		self.moreWidthConstraint.constant = 0;
		self.headImageView.hidden = YES;
	}
}


@end
