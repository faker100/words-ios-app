//
//  LGReviewWrongWordModel.m
//  Word
//
//  Created by Charles Cao on 2018/3/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReviewWrongWordModel.h"

@implementation LGReviewWrongWordModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
	if ([property.name isEqualToString:@"type"]) {
		NSInteger type = [NSString stringWithFormat:@"%@",oldValue].integerValue;
		return @(type);
	}
	return oldValue;
}

@end
