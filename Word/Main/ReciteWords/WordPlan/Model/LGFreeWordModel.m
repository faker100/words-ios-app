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

- (NSString *)phonetic{
	if (self.phonetic_us.length > 0) return self.phonetic_us;
	if (self.phonetic_uk.length > 0) return self.phonetic_uk;
	return @"";
}

- (NSString *)audio{
	if (self.us_audio.length > 0) return self.us_audio;
	if (self.uk_audio.length > 0) return self.uk_audio;
	return @"";
}

@end
