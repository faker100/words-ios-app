//
//  LGPKResultCell.m
//  Word
//
//  Created by Charles Cao on 2018/5/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKResultCell.h"

@implementation LGPKResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setQuestionInfo:(LGQuestionInfoModel *)questionInfo{
	_questionInfo = questionInfo;
	self.wordLabel.text = questionInfo.words;
	self.answerLabel.text = questionInfo.answer;
	self.minRightAndWrongView.backgroundColor  = questionInfo.min ? [UIColor lg_colorWithType:LGColor_theme_Color] : [UIColor lg_colorWithHexString:@"ee6c6e"];
	self.opponentRightAndWrongView.backgroundColor = questionInfo.peer ? [UIColor lg_colorWithType:LGColor_theme_Color] : [UIColor lg_colorWithHexString:@"ee6c6e"];
}

@end
