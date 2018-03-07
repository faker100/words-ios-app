//
//  LGFreeWordModel.m
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGFreeWordModel.h"

@implementation LGFreeWordModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"ID" : @"id"
			 };
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
	if ([property.name isEqualToString:@"firstStatus"]) {
		NSInteger type = [NSString stringWithFormat:@"%@",oldValue].integerValue;
		return @(type);
	}
	return oldValue;
}




@end
