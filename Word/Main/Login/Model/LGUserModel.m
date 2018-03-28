//
//  LGUserModel.m
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGUserModel.h"
#import "NSDate+Utilities.h"

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
	
	[[NSUserDefaults standardUserDefaults] setObject: isTodayReview ? [NSDate currentDate] : nil forKey:LGUSER_ISREVIEW_KEY];
}

- (BOOL)isTodayReview{
	
	NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:LGUSER_ISREVIEW_KEY];
	return [date isToday];
}

- (void)setEmail:(NSString *)email{
	[[NSUserDefaults standardUserDefaults]setObject:email forKey:EMAIL_KEY];
}

- (NSString *)email{
	return [[NSUserDefaults standardUserDefaults] objectForKey:EMAIL_KEY];
}

- (void)setPhone:(NSString *)phone{
	[[NSUserDefaults standardUserDefaults]setObject:phone forKey:PHONE_KEY];
}

- (NSString *)phone{
	return [[NSUserDefaults standardUserDefaults] objectForKey:PHONE_KEY];
}

- (void)setNickname:(NSString *)nickname{
	[[NSUserDefaults standardUserDefaults]setObject:nickname forKey:NICKNAME_KEY];
}

- (NSString *)nickname{
	return [[NSUserDefaults standardUserDefaults] objectForKey:NICKNAME_KEY];
}

- (void)setPassword:(NSString *)password{
	[[NSUserDefaults standardUserDefaults]setObject:password forKey:PASSWORD_KEY];
}

- (NSString *)password{
	return [[NSUserDefaults standardUserDefaults] objectForKey:PASSWORD_KEY];
}



@end
