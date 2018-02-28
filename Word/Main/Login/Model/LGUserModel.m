//
//  LGUserModel.m
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGUserModel.h"

#define LGUSER_ISREVIEW_KEY  @"LGUSER_ISREVIEW_KEY"

@implementation LGUserModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
	if ([property.name isEqualToString:@"studyModel"]) {
		NSInteger type = [NSString stringWithFormat:@"%@",oldValue].integerValue;
		return @(type);
	}
	return oldValue;
}

- (void)setIsReview:(BOOL)isReview{
	[[NSUserDefaults standardUserDefaults] setBool:isReview forKey:LGUSER_ISREVIEW_KEY];
}

- (BOOL)isReview{
	return [[NSUserDefaults standardUserDefaults] boolForKey:LGUSER_ISREVIEW_KEY];
}

@end
