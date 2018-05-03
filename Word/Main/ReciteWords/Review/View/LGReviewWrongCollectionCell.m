//
//  LGReviewWrongCollectionCell.m
//  Word
//
//  Created by Charles Cao on 2018/3/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReviewWrongCollectionCell.h"

@implementation LGReviewWrongCollectionCell

- (void)setWrongWordModel:(LGReviewWrongWordModel *)wrongWordModel{
	_wrongWordModel = wrongWordModel;
	self.rangeLabel.text = wrongWordModel.name;
	switch (wrongWordModel.type) {
		case LGReviewProgressNotBegin:
			self.progressLabel.text = @"未开始";
			self.progressBgImageView.tintColor = [UIColor lg_colorWithHexString:@"999999"];
			break;
		case LGReviewProgressSuspend:
			self.progressLabel.text = @"中断";
			self.progressBgImageView.tintColor = [UIColor lg_colorWithType:LGColor_pk_red];
			break;
		case LGReviewProgressFinish:
			self.progressLabel.text = @"完成";
			self.progressBgImageView.tintColor = [UIColor lg_colorWithType:LGColor_theme_Color];
			break;
			
		default:
			break;
	}
}

@end
