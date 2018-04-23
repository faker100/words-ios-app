//
//  UIView+LGNightView.m
//  Word
//
//  Created by Charles Cao on 2018/4/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "UIView+LGNightView.h"
#import "LGThemeManager.h"

@implementation UIView (LGNightView)

+ (void)load{
	method_exchangeImplementations(class_getInstanceMethod(self, @selector(setBackgroundColor:)),class_getInstanceMethod(self, @selector(lg_setBackgroundColor:)));
}

- (void)lg_setBackgroundColor:(UIColor *)color{
	
	LGThemeType themType = [LGThemeManager shareManager].currentTheme;
	
	NSLog(@"夜间颜色%@",self.nightBgColor);
	
	if (themType == LGThemeDay && self.lightBgColor)
	{
		[self lg_setBackgroundColor:self.lightBgColor];
	
	}else if (themType == LGThemeNight && self.nightBgColor)
	{
		[self lg_setBackgroundColor:self.nightBgColor];
	
	}else
	{
		[self lg_setBackgroundColor:color];
	}
}

- (UIColor *)nightBgColor{
	NSLog(@"获取夜间模式颜色:%@,%@",self.class,objc_getAssociatedObject(self, _cmd));
	return  objc_getAssociatedObject(self, _cmd);
}

- (void)setNightBgColor:(UIColor *)nightBackgroundColor{
	
	objc_setAssociatedObject(self, @selector(nightBgColor), nightBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	NSLog(@"设置夜间模式颜色:%@,%@",self.class,[self nightBgColor]);
}

- (UIColor *)lightBgColor{
	NSLog(@"获取白天模式颜色:%@,%@",self.class,objc_getAssociatedObject(self, _cmd));
	return  objc_getAssociatedObject(self, _cmd);
}

- (void)setLightBgColor:(UIColor *)lightBgColor{
	
	objc_setAssociatedObject(self, @selector(lightBgColor), lightBgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
	NSLog(@"设置夜间模式颜色:%@,%@",self.class,[self lightBgColor]);
}

@end
