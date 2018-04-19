//
//  LGThemeManager.m
//  Word
//
//  Created by Charles Cao on 2018/4/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#define THEME_USERDEFAULT_KEY @"THEME_USERDEFAULT_KEY"

#import "LGThemeManager.h"

@implementation LGThemeManager

+ (instancetype)shareManager{
	static LGThemeManager *mannager;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		mannager = [[LGThemeManager alloc]init];
	});
	return mannager;
}

- (void) setCurrentTheme:(LGThemeType) type{
	
	[[NSUserDefaults standardUserDefaults] setInteger:type forKey:THEME_USERDEFAULT_KEY];
	[[NSNotificationCenter defaultCenter] postNotificationName:THEME_CHANGE_NOTIFICATION object:nil];
}

- (LGThemeType)currentTheme{
	return [[NSUserDefaults standardUserDefaults] integerForKey:THEME_USERDEFAULT_KEY];
}

+ (UIColor *) colorForCurrentTheme:(UIColor *)color{
	
	NSString *hexStr = [UIColor hexStringFromColor:color];
	LGThemeManager *manager = [LGThemeManager shareManager];
	
	NSString *newHexStr;
	
	if (manager.currentTheme == LGThemeDay) {
		newHexStr = manager.dayColorDic[hexStr];
	}else{
		newHexStr = manager.nightColorDic[hexStr];
	}
	
	if (newHexStr) {
		return [UIColor lg_colorWithHexString:newHexStr];
	}else{
		return color;
	}
}


/**
 白天要换的颜色

 @return 颜色 dic
 */
- (NSDictionary *)dayColorDic{
	if (!_dayColorDic) {
		_dayColorDic = @{
					  @"ffffff"    : @"222223",
					  theme_Color   : theme_Color_night,
					  title_1_Color : title_1_Color_night,
					  title_2_Color : title_2_Color_night,
					  };
	}
	return _dayColorDic;
}


/**
 夜间要换的颜色, 与 dayColorDic 的 key value 相反

 */
- (NSDictionary *)nightColorDic{
	if (_nightColorDic) {
		_nightColorDic = @{
						   @"222223" : @"ffffff",
						   theme_Color_night   : theme_Color,
						   title_1_Color_night : title_1_Color,
						   title_2_Color_night : title_2_Color
						   };
	}
	return _nightColorDic;
}


@end
