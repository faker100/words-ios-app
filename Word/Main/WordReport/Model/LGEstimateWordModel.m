//
//  LGEstimateWordModel.m
//  Word
//
//  Created by Charles Cao on 2018/4/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGEstimateWordModel.h"

@implementation LGEstimateWordModel

- (void)mj_keyValuesDidFinishConvertingToObject{
	
	NSArray *temp = [self.select componentsSeparatedByString:@"\n"];
	//随机打乱
	self.selectArray =  [temp sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
		return arc4random_uniform(3) - 1;
	}];
	
	[self.selectArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([obj isEqualToString:self.answer]) {
			self.trueAnswerIndex = idx;
			*stop = YES;
		}
	}];
	
}


@end
