//
//  LGWordDetailQuestionCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordDetailQuestionCell.h"
#import "NSString+LGString.h"
#import "LGUserManager.h"

@interface LGWordDetailQuestionCell()
{
    CGFloat originalFontSize;//原来的fontsize;
}
@end

@implementation LGWordDetailQuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    originalFontSize = self.questionLabel.font.pointSize;
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
			
            CGFloat newSize = originalFontSize + [LGUserManager shareManager].user.fontSizeRate.floatValue;
            [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:newSize] range:NSMakeRange(0, attrStr.length)];
            
			//高亮
			NSArray *resultArray  = [attrStr.mutableString findHighlightForWord:word];
			
				for (NSTextCheckingResult *result in resultArray) {
					[attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_theme_Color] range:result.range];
				}
			weakSelf.questionLabel.attributedText = attrStr;
            completion();
		}];
	}
}

@end
