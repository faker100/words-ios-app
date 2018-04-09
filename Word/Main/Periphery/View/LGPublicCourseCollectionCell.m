//
//  LGPublicCourseCollectionCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPublicCourseCollectionCell.h"

@implementation LGPublicCourseCollectionCell

- (void)setClassModel:(LGRecentClassModel *)classModel{
	_classModel = classModel;
	[self.imageView sd_setImageWithURL:[NSURL URLWithString:OPPEN_DOMAIN(classModel.image)] placeholderImage:PLACEHOLDERIMAGE];
	self.courseTimeLabel.text = classModel.courseTime;
}

@end
