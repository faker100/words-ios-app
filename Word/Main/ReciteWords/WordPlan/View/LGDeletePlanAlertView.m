//
//  LGDeletePlanAlertView.m
//  Word
//
//  Created by Charles Cao on 2018/2/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGDeletePlanAlertView.h"

@implementation LGDeletePlanAlertView

- (IBAction)cancelAction:(id)sender {
	[self removeFromSuperview];
}
- (IBAction)sureAction:(id)sender {
	if (self.deleteBlock) {
		self.deleteBlock();
	}
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
