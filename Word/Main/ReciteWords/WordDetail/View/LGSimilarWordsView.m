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

@interface LGSimilarWordsView()
{
	CGFloat originallyWordLabelFontSize;
	CGFloat originallyTranslateLabelFontSize;
	CGFloat originallyExampleLabelFontSize;
	CGFloat addFontSize;
}
@end

@implementation LGSimilarWordsView

- (void)awakeFromNib{
	[super awakeFromNib];
	originallyWordLabelFontSize = self.wordLabel.font.pointSize;
	originallyTranslateLabelFontSize = self.translateLabel.font.pointSize;
	originallyExampleLabelFontSize = self.exampleLabel.font.pointSize;
	addFontSize = [LGUserManager shareManager].user.fontSizeRate.floatValue;
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
	
	//调整字体
	self.wordLabel.font = [UIFont systemFontOfSize:originallyWordLabelFontSize + addFontSize];
	self.translateLabel.font = [UIFont systemFontOfSize:originallyTranslateLabelFontSize + addFontSize];
	self.exampleLabel.font = [UIFont systemFontOfSize:originallyExampleLabelFontSize + addFontSize];
	
	self.wordLabel.text = wordDetailModel.words.word;
	[self.audioButton setTitle:[NSString stringWithFormat:@" %@",wordDetailModel.words.phonetic]  forState:UIControlStateNormal];
	self.translateLabel.text = wordDetailModel.words.translate;
	
	
	if (wordDetailModel.sentence.count > 0) {
		//字体;
		CGFloat addFontSize = [LGUserManager shareManager].user.fontSizeRate.floatValue;
		
		LGSentenceModel *sentence = wordDetailModel.sentence.firstObject;
		NSString *str = sentence.englishAndChinese;
		NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
		
		NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
		paragraph.paragraphSpacing = 7;
		paragraph.lineSpacing = 4;
		
		[attrStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, str.length)];
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
