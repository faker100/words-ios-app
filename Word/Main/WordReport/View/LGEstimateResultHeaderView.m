//
//  LGEstimateResultHeaderView.m
//  Word
//
//  Created by Charles Cao on 2018/4/3.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGEstimateResultHeaderView.h"

@implementation LGEstimateResultHeaderView

- (void)awakeFromNib{
	[super awakeFromNib];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
	[self addGestureRecognizer:tap];

}

- (void)tapAction:(id)sender {
	if (self.delegate) {
		
		CGFloat angle = M_PI - 0.01;
		//是否旋转过
		BOOL isRotate = atan2f(self.moreImageView.transform.a, self.moreImageView.transform.b) > 0;
		[UIView animateWithDuration:0.2f animations:^{
			self.moreImageView.transform = CGAffineTransformRotate(self.moreImageView.transform, isRotate ? angle : -angle);
		}];
		[self.delegate tapAction];
	}
}

- (void)setNum:(NSString *)num type:(LGEstimateResultHeaderType)type{
	
	if (num.length == 0) return;
	self.type = type;
	NSString *str = @"";
	if (type == LGEstimateResultKnow) {
		str = [NSString stringWithFormat:@"认识 (%@)",num];
		self.moreImageView.hidden = NO;
	}else{
		str = [NSString stringWithFormat:@"不认识 (%@)",num];
		self.moreImageView.hidden = YES;
	}
	
	NSRange numRange = [str rangeOfString:num];
	
	NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:str];
	[attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, str.length)];
	[attribute addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_Title_1_Color] range:NSMakeRange(0, str.length)];
	[attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(numRange.location - 1, numRange.length + 2)];
	
	self.sectionTitleLabel.attributedText = attribute;
}

@end
