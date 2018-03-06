//
//  LGTimeReivewCountAlertView.m
//  Word
//
//  Created by Charles Cao on 2018/3/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTimeReivewCountAlertView.h"

@implementation LGTimeReivewCountAlertView

//重新选择
- (IBAction)cancelAction:(id)sender {
	[self removeFromSuperview];
}

//开始复习
- (IBAction)beginReviewAction:(id)sender {
	[self.delegate beginReview];
	[self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
