//
//  LGClockModel.m
//  Word
//
//  Created by Charles Cao on 2018/3/29.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGClockModel.h"

@implementation LGClockModel


- (NSString *)weakStr{
	
	if (self.week.count == 7) {
		return @"每天";
	}else if (self.week.count == 0){
		return @"";
	}else{
		NSMutableString *temp = [NSMutableString string];
		[self.week enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			[temp appendFormat:@"%@  ",[LGClockModel weekNumToString:obj]];
		}];
		
		return temp;
	}
}

- (NSString *)time{
	return [NSString stringWithFormat:@"%02ld:%02ld",self.hour,self.minute];
}

+ (NSString *)weekNumToString:(NSString *)weekNum{
	NSInteger num = weekNum.integerValue;
	if (num == 1) return @"星期一";
	if (num == 2) return @"星期二";
	if (num == 3) return @"星期三";
	if (num == 4) return @"星期四";
	if (num == 5) return @"星期五";
	if (num == 6) return @"星期六";
	if (num == 7) return @"星期日";
	return @"";
}

@end
