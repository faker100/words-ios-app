//
//  UIColor+LGColor.h
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

//白天颜色
static NSString *const theme_Color    = @"37bc85";
static NSString *const title_1_Color  = @"454545";
static NSString *const title_2_Color  = @"7A7A7A";
static NSString *const yellow 		  = @"FFC600";
static NSString *const dark_Yellow    = @"EEC15F";
static NSString *const pk_red 		  = @"ff213b";

//夜间颜色
static NSString *const theme_Color_night    = @"222222";
static NSString *const title_1_Color_night  = @"777777";
static NSString *const title_2_Color_night  = @"777778";
//static NSString *const yellow_night 		= @"FFC600";
//static NSString *const dark_Yellow_night    = @"EEC15F";
//static NSString *const pk_red_night 	    = @"ff213b";

typedef NS_ENUM(NSUInteger, LGColorType) {
	LGColor_theme_Color,  	  //主题绿色
	LGColor_Title_1_Color,    //一级标题颜色
	LGColor_Title_2_Color,    //二级标题颜色
	LGColor_Yellow,   		  //黄色
	LGColor_Dark_Yellow,   	  //深黄色
	LGColor_pk_red			  //pk 中的 红色
	
};

@interface UIColor (LGColor)


/**
 十六进制 转换为 UIColor
 *
 */
+ (UIColor *)lg_colorWithHexString:(NSString *)color;


/**
 UIColor 转为 十六进制

 */
+ (NSString *)hexStringFromColor:(UIColor *)color;

+ (UIColor *)lg_colorWithType:(LGColorType)type;

@end
