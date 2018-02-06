//
//  LGPlanModel.m
//  Word
//
//  Created by Charles Cao on 2018/2/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPlanModel.h"

@implementation LGPlanModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"ID" : @"id"
			 };
}

- (NSInteger)surplusWord{
	return self.total.integerValue - self.userWords.integerValue;
}


- (void)dealloc{
	NSLog(@"没了");
}

@end
