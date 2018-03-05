//
//  LGWordPlanCollectionCell.m
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordPlanCollectionCell.h"

@implementation LGWordPlanCollectionCell

- (void)setSelected:(BOOL)selected{
	self.titleNameButton.selected = selected;
	self.progressLabel.highlighted = selected;
	self.progressView.trackTintColor = selected ? [UIColor lg_colorWithHexString:@"368579"] : [UIColor lg_colorWithHexString:@"c5c5c5"];
	self.bgColorView.backgroundColor = selected ? [UIColor lg_colorWithType:LGColor_theme_Color] : [UIColor lg_colorWithHexString:@"e1dfdf"];
}

- (void)setPlanModel:(LGPlanModel *)planModel{
	if (planModel != _planModel) {
		_planModel = planModel;
		NSInteger userWords = planModel.userWords.integerValue;
		NSInteger total = planModel.total.integerValue;
		[self.titleNameButton setTitle:[NSString stringWithFormat:@" %@",planModel.name] forState:UIControlStateNormal];
		self.progressLabel.text = [NSString stringWithFormat:@"(%ld/%ld)",userWords,total];
		self.progressView.progress = userWords * 1.0 / total;
	}
}

- (void)setIsEdit:(BOOL)isEdit{
	_isEdit = isEdit;
	self.deleteButton.hidden = !isEdit;
}

- (IBAction)deleteAction:(id)sender {
	[self.delegate deletePlan:self.planModel];
}

@end
