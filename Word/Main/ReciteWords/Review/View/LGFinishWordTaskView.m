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

//复习完成任务
- (IBAction)finishTaskAction:(id)sender {
	
	[self removeFromSuperview];
	if (self.sureActionBlock) {
		self.sureActionBlock();
	}
}
//休息
- (IBAction)restAction:(id)sender {
    [self removeFromSuperview];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    
}

//继续
- (IBAction)continueAction:(id)sender {
    [self removeFromSuperview];
    if (self.continueBlock) {
        self.continueBlock();
    }
    
}

+ (void)showReviewFinishToView:(UIView *)view sureBlock:(void(^)(void))sureBlock {
	LGFinishWordTaskView *alertView = [[NSBundle mainBundle]loadNibNamed:@"LGFinishWordTaskView" owner:nil options:nil].firstObject;
	alertView.frame = view.bounds;
	[view addSubview:alertView];
	alertView.sureActionBlock = sureBlock;
}

+ (void)showFinishReciteWordToView:(UIView *)view continueBlock:(void(^)(void))continueBlock cancelBlock:(void(^)(void))cancelBlock{
    LGFinishWordTaskView *alertView = [[NSBundle mainBundle]loadNibNamed:@"LGFinishWordTaskView" owner:nil options:nil].lastObject;
    alertView.frame = view.bounds;
    [view addSubview:alertView];
    alertView.continueBlock = continueBlock;
    alertView.cancelBlock = cancelBlock;
}

@end
