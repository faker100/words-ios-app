//
//  LGEstimateResultModel.m
//  Word
//
//  Created by Charles Cao on 2018/4/3.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGEstimateResultModel.h"

@implementation LGEstimateResultModel


- (void)mj_keyValuesDidFinishConvertingToObject{
	self.rateArray = [NSMutableArray array];
	
	if (self.four.floatValue > 0) {
		[self.rateArray addObject:[LGRateModel initWithLevel:@"四级" rate:self.four]];
	}
	if (self.six.floatValue > 0) {
		[self.rateArray addObject:[LGRateModel initWithLevel:@"六级" rate:self.six]];
	}
	
	if (self.gmat.floatValue > 0) {
		[self.rateArray addObject:[LGRateModel initWithLevel:@"GMAT" rate:self.gmat]];
	}
	
	if (self.gre.floatValue > 0) {
		[self.rateArray addObject:[LGRateModel initWithLevel:@"GRE" rate:self.gre]];
	}
	
}

@end

@implementation LGRateModel

+ (LGRateModel *)initWithLevel:(NSString *)levelName rate:(NSString *)rate{
	LGRateModel *rateModel = [LGRateModel new];
	rateModel.levelName = levelName;
	rateModel.rate = [NSString stringWithFormat:@"%@%%",rate];
	return rateModel;
}

@end
