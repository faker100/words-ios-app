//
//  UIColor+LGColor.h
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGColorType) {
	LGColor_theme_Color,  	//主题绿色
	LGColor_Title_1_Color,    //一级标题颜色
	LGColor_Title_2_Color,   //二级标题颜色
	LGColor_Yellow,   		//黄色
	LGColor_Dark_Yellow		//深黄色
	
};

@interface UIColor (LGColor)


/**
 十六进制 转换为 UIColor
 *
 */
+ (UIColor *)lg_colorWithHexString:(NSString *)color;


+ (UIColor *)lg_colorWithType:(LGColorType)type;

@end
