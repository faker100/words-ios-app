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

@synthesize currentTheme = _currentTheme;

+ (instancetype)shareManager{
	static LGThemeManager *mannager;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		mannager = [[LGThemeManager alloc]init];
	});
	return mannager;
}

- (void) setCurrentTheme:(LGThemeType) type{
	_currentTheme = type;
	[[NSUserDefaults standardUserDefaults] setInteger:type forKey:THEME_USERDEFAULT_KEY];
	[[NSNotificationCenter defaultCenter] postNotificationName:THEME_CHANGE_NOTIFICATION object:nil];
}


/**
 获取主题,如果当前值为0,表示启动后第一次获取,从本地获取一次,如果本地不为夜间模式,返回LGThemeNone

 @return 主题
 */
- (LGThemeType)currentTheme{
	if (_currentTheme == 0) {
		LGThemeType theme= [[NSUserDefaults standardUserDefaults] integerForKey:THEME_USERDEFAULT_KEY];
		_currentTheme = theme == LGThemeNight ? LGThemeNight : LGThemeNone;
	}
	return _currentTheme;
}




@end
