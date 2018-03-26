//
//  LGJpushReceiveMessageModel.m
//  Word
//
//  Created by Charles Cao on 2018/3/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGJPushReceiveMessageModel.h"

@implementation LGJPushReceiveMessageModel

@end


@implementation LGExtrasModel

- (void)mj_keyValuesDidFinishConvertingToObject{
	if (self.type == 1) {
		self.message = [LGMatchModel mj_objectWithKeyValues:self.message];
	}else if (self.type == 2){
		self.message = [LGReadyPKModel mj_objectWithKeyValues:self.message];
	}else if (self.type == 4){
		self.message = [LGAtPKModel mj_objectWithKeyValues:self.message];
	}
}

@end


@implementation LGMatchModel

@end

@implementation LGMatchUserModel

@end

@implementation LGReadyPKModel

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"words" : @"LGPKWordModel"
			 };
}

@end

@implementation LGPKWordModel

- (void)mj_keyValuesDidFinishConvertingToObject{
	
	NSMutableArray<NSString *> *tempArray = [NSMutableArray arrayWithArray:[self.select componentsSeparatedByString:@"\n"]];
	
	//随机打乱答案数组,(随机返回 NSComparisonResult)
	[tempArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
		return arc4random_uniform(3) - 1;
	}];
	
	//找到正确答案 index
	[tempArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([obj isEqualToString:self.answer]) {
			self.trueAnswerIndex = idx;
			*stop = YES;
		}
	}];
	
	self.selectArray = tempArray;
}

@end

@implementation LGAccuracyModel

@end

@implementation LGAtPKModel

@end

