//
//  LGPeripherySectionHeader.m
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPeripherySectionHeader.h"

@implementation LGPeripherySectionHeader

- (void)setType:(LGPeripherySectionHeaderType)type{
	_type = type;
	switch (type) {
		case LGPeripherySectionLive:
			self.sectionTitleLabel.text = @"直播预告";
			self.moreButton.hidden = NO;
			break;
		case LGPeripherySectionClassic:
			self.sectionTitleLabel.text = @"经典课程";
			self.moreButton.hidden = YES;
			break;
		case LGPeripherySectionCase:
			self.sectionTitleLabel.text = @"学员评价";
			self.moreButton.hidden = NO;
			break;
		default:
			break;
	}
}
- (IBAction)moreAction:(id)sender {
	if (self.delegate) {
		[self.delegate moreWithType:self.type];
	}
}

@end
