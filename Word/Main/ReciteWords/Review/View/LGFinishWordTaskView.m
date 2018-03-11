//
//  LGFinishWordTaskView.m
//  Word
//
//  Created by Charles Cao on 2018/3/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGFinishWordTaskView.h"

@implementation LGFinishWordTaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)finishTaskAction:(id)sender {
	
	[self removeFromSuperview];
	if (self.sureActionBlock) {
		self.sureActionBlock();
	}
}


+ (void)showFinishToView:(UIView *)view type:(LGFinishWordTaskType)type sureBlock:(void(^)(void))sureBlock {
	LGFinishWordTaskView *alertView = [[NSBundle mainBundle]loadNibNamed:@"LGFinishWordTaskView" owner:nil options:nil].firstObject;
	alertView.frame = view.bounds;
    
    if (type == LGFinishReview) {
        alertView.titleLabel.text = @"今天你的复习任务";
        alertView.reviewImageView.hidden = NO;
    }else{
        alertView.titleLabel.text = @"今天单词任务";
        alertView.reciteWordsImageView.hidden = NO;
    }
	[view addSubview:alertView];
	alertView.sureActionBlock = sureBlock;
}

@end
