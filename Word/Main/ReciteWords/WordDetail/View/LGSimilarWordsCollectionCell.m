//
//  LGSimilarWordsCollectionCell.m
//  Word
//
//  Created by Charles Cao on 2018/5/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSimilarWordsCollectionCell.h"

@implementation LGSimilarWordsCollectionCell

- (void)setSimilarWord:(LGSimilarWordsModel *)similarWord{
	_similarWord = similarWord;
	self.wordLabel.text = similarWord.word;
}

@end
