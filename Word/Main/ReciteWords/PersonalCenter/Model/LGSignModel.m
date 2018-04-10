//
//  LGSignModel.m
//  Word
//
//  Created by Charles Cao on 2018/4/10.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSignModel.h"

@implementation LGSignModel

- (void)mj_keyValuesDidFinishConvertingToObject{
	
	NSMutableArray *tempArr = [NSMutableArray array];
	[self.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[tempArr addObject:obj[@"createDay"]];
	}];
	self.data = tempArr;
}

@end
