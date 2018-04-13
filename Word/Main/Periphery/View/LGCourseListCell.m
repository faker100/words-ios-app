//
//  LGCourseListCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGCourseListCell.h"

@implementation LGCourseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCourseModel:(LGCourseModel *)courseModel{
	_courseModel = courseModel;
	[self.courseImageView sd_setImageWithURL:[NSURL URLWithString:courseModel.image] placeholderImage:PLACEHOLDERIMAGE];
	self.courseTitleLabel.text= courseModel.name;
	self.joinNumLabel.text= [NSString stringWithFormat:@"%@人加入",courseModel.view];
	
}

- (IBAction)tryListenAction:(id)sender {
	if (self.delegate) {
		[self.delegate tryListen:self.courseModel];
	}
}

@end
