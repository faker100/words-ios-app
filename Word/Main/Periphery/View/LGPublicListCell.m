//
//  LGPublicListCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPublicListCell.h"

@implementation LGPublicListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setClassModel:(LGRecentClassModel *)classModel{
	_classModel = classModel;
	[self.courseImageView sd_setImageWithURL:[NSURL URLWithString:OPPEN_DOMAIN(classModel.image)] placeholderImage:PLACEHOLDERIMAGE];
	self.courseNameLabel.text = classModel.title;
	self.joinLabel.text = [NSString stringWithFormat:@" %@ 人已加入",classModel.viewCount];
}

@end
