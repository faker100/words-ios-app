//
//  LGUserModel.m
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGUserModel.h"
#import "NSDate+Utilities.h"

#define LGUSER_ISREVIEW_KEY  @"LGUSER_ISREVIEW_KEY"
#define FONT_SIZE_KEY	     @"FONT_SIZE_KEY"

@implementation LGUserModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
	if ([property.name isEqualToString:@"studyModel"]) {
		NSInteger type = [NSString stringWithFormat:@"%@",oldValue].integerValue;
		return @(type);
	}
	
	return oldValue;
}

- (void)setFontSize:(NSString *)fontSize{
	[[NSUserDefaults standardUserDefaults]setObject:fontSize forKey:FONT_SIZE_KEY];
}

- (NSString *)fontSize{
	return [[NSUserDefaults standardUserDefaults]objectForKey:FONT_SIZE_KEY];
}

- (void)setIsTodayReview:(BOOL)isTodayReview{
	
	[[NSUserDefaults standardUserDefaults] setObject: isTodayReview ? [NSDate currentDay] : nil forKey:LGUSER_ISREVIEW_KEY];
}

- (BOOL)isTodayReview{
	
	NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:LGUSER_ISREVIEW_KEY];
	return [date isToday];
}

@end
