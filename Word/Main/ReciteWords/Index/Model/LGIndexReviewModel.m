//
//  LGIndexReviewModel.m
//  Word
//
//  Created by Charles Cao on 2018/2/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGIndexReviewModel.h"

@implementation LGIndexReviewModel

- (void)mj_keyValuesDidFinishConvertingToObject {
	
	self.dataSourceArray = [NSMutableArray array];
	if (self.know.integerValue > 0) {
		LGReviewSubModel *model = [LGReviewSubModel new];
		model.count = self.know;
		model.descriptionStr = @"背认识的单词";
		[self.dataSourceArray addObject:model];
	}
	
	if (self.incognizant.integerValue > 0) {
		LGReviewSubModel *model = [LGReviewSubModel new];
		model.count = self.incognizant;
		model.descriptionStr = @"背不认识的单词";
		[self.dataSourceArray addObject:model];
	}
	
	if (self.dim.integerValue > 0) {
		LGReviewSubModel *model = [LGReviewSubModel new];
		model.count = self.dim;
		model.descriptionStr = @"背模糊的单词";
		[self.dataSourceArray addObject:model];
	}
	
	if (self.all.integerValue > 0) {
		LGReviewSubModel *model = [LGReviewSubModel new];
		model.count = self.all;
		model.descriptionStr = @"全部数";
		[self.dataSourceArray addObject:model];
	}
}

@end


@implementation LGReviewSubModel

@end
