//
//  LGThemeManager.h
//  Word
//
//  Created by Charles Cao on 2018/4/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 主题
 */
typedef NS_ENUM(NSUInteger, LGThemeType) {
	LGThemeNone = 1,   //没换过主题,显示LGThemeDay
	LGThemeDay = 2,    //白天模式,默认
	LGThemeNight = 3   //夜间模式
	
};

//主题模式切换
#define THEME_CHANGE_NOTIFICATION	 @"THEME_CHANGE"

@interface LGThemeManager : NSObject

@property (nonatomic, copy) NSDictionary *dayColorDic;
@property (nonatomic, copy) NSDictionary *nightColorDic;

/**
 设置当前主题色,并发送通知
 */
@property (nonatomic, assign) LGThemeType currentTheme;


+ (instancetype)shareManager;

@end
