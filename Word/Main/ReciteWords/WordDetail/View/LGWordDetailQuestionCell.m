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

- (void)setQuestion:(NSString *)question word:(NSString *)word article:(NSString *)article completion:(void(^)(void))completion{
	if (![self.question isEqualToString:question]) {
		self.question = question;
		__weak typeof(self) weakSelf = self;
		
		NSString *text = [NSString stringWithFormat:@"%@\n%@",article,question];
		
		[text htmlToAttributeStringContent:GMAT_DOMAIN(@"") width:CGRectGetWidth(self.bgView.bounds) - 20 completion:^(NSMutableAttributedString *attrStr) {
			
			//高亮 word
			NSString *str = attrStr.mutableString;
			NSString *regexString = word;
			NSRegularExpression *reqular = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionDotMatchesLineSeparators error:nil];
			NSArray *resultArray  = [reqular matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
			
				for (NSTextCheckingResult *result in resultArray) {
					[attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_theme_Color] range:result.range];
				}
			
			weakSelf.questionLabel.attributedText = attrStr;
            completion();
		}];
	}
}

@end
