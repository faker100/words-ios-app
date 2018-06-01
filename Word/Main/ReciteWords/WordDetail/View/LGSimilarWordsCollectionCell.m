//
//  LGSimilarWordsCollectionCell.m
//  Word
//
//  Created by Charles Cao on 2018/5/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSimilarWordsCollectionCell.h"
#import "LGUserManager.h"

@implementation LGSimilarWordsCollectionCell

- (void)awakeFromNib{
	[super awakeFromNib];
	self.wordLabel.font = [UIFont systemFontOfSize: 14 + [LGUserManager shareManager].user.fontSizeRate.floatValue];
}

- (void)setSimilarWord:(LGSimilarWordsModel *)similarWord{
	_similarWord = similarWord;
	
	NSAttributedString *attr = [[NSAttributedString alloc]initWithString:similarWord.word attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
	self.wordLabel.attributedText = attr;
}

@end
