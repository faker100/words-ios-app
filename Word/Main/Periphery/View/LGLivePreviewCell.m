//
//  LGLivePreviewCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGLivePreviewCell.h"

@implementation LGLivePreviewCell

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
	self.monthLabel.text = classModel.month;
	self.monthLabel.hidden = classModel.month.length == 0;
	self.courseTypeLabel.text = classModel.catName;
	self.timeLabel.text = [NSString stringWithFormat:@"  %@  ",classModel.courseTime ];
	self.courseTitleLabel.text = classModel.title;
	self.courseDescriptionLabel.text = classModel.courseDescription;
	[self.teacherImageView sd_setImageWithURL:[NSURL URLWithString:OPEN_DOMAIN(classModel.teacherImage)] placeholderImage:PLACEHOLDERIMAGE];
	self.teacherNameLabel.text = classModel.teacherName;
}

//预约
- (IBAction)bespeakAction:(id)sender {
	
}


@end
