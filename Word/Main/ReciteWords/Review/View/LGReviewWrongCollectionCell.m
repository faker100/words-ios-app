//
//  LGReviewWrongCollectionCell.m
//  Word
//
//  Created by Charles Cao on 2018/3/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReviewWrongCollectionCell.h"

@implementation LGReviewWrongCollectionCell

- (void)setWrongWordModel:(LGReviewWrongWordModel *)wrongWordModel{
	_wrongWordModel = wrongWordModel;
	self.rangeLabel.text = wrongWordModel.name;
}

@end
