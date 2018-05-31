//
//  LGSimilarWordsView.m
//  Word
//
//  Created by Charles Cao on 2018/5/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSimilarWordsView.h"
#import "LGPlayer.h"
#import "LGUserManager.h"
#import "LGTool.h"

@implementation LGSimilarWordsView

- (void)awakeFromNib{
	[super awakeFromNib];
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
 }
 */

- (void)setWordDetailModel:(LGWordDetailModel *)wordDetailModel{
	_wordDetailModel = wordDetailModel;
	
	[LGTool updateFontSizeForView:self.wordLabel];
	[LGTool updateFontSizeForView:self.translateLabel];
	[LGTool updateFontSizeForView:self.exampleLabel];
	[LGTool updateFontSizeForView:self.audioButton];
	self.wordLabel.text = wordDetailModel.words.word;
	
	[self.audioButton setTitle:[NSString stringWithFormat:@" %@",wordDetailModel.words.phonetic]  forState:UIControlStateNormal];
	self.translateLabel.text = wordDetailModel.words.translate;
	
	
	if (wordDetailModel.sentence.count > 0) {
		//字体;
		CGFloat addFontSize = [LGUserManager shareManager].user.fontSizeRate.floatValue;
		
		LGSentenceModel *sentence = wordDetailModel.sentence.firstObject;
		NSString *str = sentence.englishAndChinese;
		NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
		
		[attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_Title_1_Color] range:NSMakeRange(0, str.length)];
		[attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15 + addFontSize] range:NSMakeRange(0, str.length)];
		
		//高亮 word
		NSString *regexString = wordDetailModel.words.word;
		NSRegularExpression *reqular = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionDotMatchesLineSeparators error:nil];
		NSArray *resultArray  = [reqular matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
		
		for (NSTextCheckingResult *result in resultArray) {
			[attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_theme_Color] range:result.range];
		}

		self.exampleLabel.attributedText = attrStr;
	}else{
		self.exampleLabel.text = @"";
	}
}

//播放音频
- (IBAction)playAudioAction:(id)sender {
	[[LGPlayer sharedPlayer] playWithUrl:self.wordDetailModel.words.audio completion:nil];
}

- (IBAction)cancelAction:(id)sender {
	[self removeFromSuperview];
}
- (IBAction)tapAction:(id)sender {
	[self removeFromSuperview];
}


@end
