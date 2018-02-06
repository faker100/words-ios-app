//
//  LGUserModel.m
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGUserModel.h"

@implementation LGUserModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
	if ([property.name isEqualToString:@"studyModel"]) {
		NSInteger type = [NSString stringWithFormat:@"%@",oldValue].integerValue;
		return @(type);
	}
	return oldValue;
}

@end
