//
//  LGEstimateResultCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/3.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGEstimateResultCell.h"

@implementation LGEstimateResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRateModel:(LGRateModel *)rateModel isLast:(BOOL)isLast{
	self.rateModel = rateModel;
	self.gradeLabel.text = rateModel.levelName;
	self.rateLabel.text = [NSString stringWithFormat:@"正确率 : %@",rateModel.rate] ;
}

@end
