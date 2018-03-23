//
//  LGPKAnswerCell.m
//  Word
//
//  Created by Charles Cao on 2018/3/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKAnswerCell.h"

@implementation LGPKAnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
	if (selected) {
		self.contentView.backgroundColor = [UIColor lg_colorWithType:LGColor_theme_Color];
	}else{
		[self setNormal];
	}
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
	[super setHighlighted:highlighted animated:animated];
	if (highlighted == YES) {
		self.contentView.backgroundColor = [UIColor lg_colorWithType:LGColor_theme_Color];
	}else{
		[self setNormal];
	}
}

- (void)setWrong{
	self.contentView.backgroundColor = [UIColor lg_colorWithType:LGColor_pk_red];
}

- (void)setNormal{
	self.contentView.backgroundColor = [UIColor lg_colorWithHexString:@"f1efe4"];
}

@end
