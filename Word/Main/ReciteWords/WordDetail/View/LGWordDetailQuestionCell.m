//
//  LGWordDetailQuestionCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordDetailQuestionCell.h"
#import "NSString+LGString.h"

@implementation LGWordDetailQuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setQuestion:(NSString *)question{
	if (![_question isEqualToString:question]) {
		_question = question;
		__weak typeof(self) weakSelf = self;
		[question htmlToAttributeStringContent:GMAT_DOMAIN(@"") width:CGRectGetWidth(self.bgView.bounds) - 20 completion:^(NSMutableAttributedString *attrStr) {
			weakSelf.questionLabel.attributedText = attrStr;
		}];
	}
}

@end
