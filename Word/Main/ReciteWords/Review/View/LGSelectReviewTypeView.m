//
//  LGSelectReviewTypeView.m
//  Word
//
//  Created by caoguochi on 2018/3/3.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSelectReviewTypeView.h"

@implementation LGSelectReviewTypeView


- (IBAction)selectChinese_English:(id)sender {
    [self.delegate selectedReviewType:LGSelectReviewChinese_English];
    [self removeFromSuperview];
}

- (IBAction)selectEnglish_Chinese:(id)sender {
    [self.delegate selectedReviewType:LGSelectReviewEnglish_Chinese];
    [self removeFromSuperview];
}

- (IBAction)selectDictation:(id)sender {
    [self.delegate selectedReviewType:LGSelectReviewDictation];
    [self removeFromSuperview];
}

- (IBAction)tapArea:(id)sender {
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
