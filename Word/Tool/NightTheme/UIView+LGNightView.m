//
//  UIView+LGNightView.m
//  Word
//
//  Created by Charles Cao on 2018/4/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "UIView+LGNightView.h"
#import "LGThemeManager.h"


#import "LGView.h"

@implementation UIView (LGNightView)

+ (void)load{
	method_exchangeImplementations(class_getInstanceMethod(self, @selector(setBackgroundColor:)),class_getInstanceMethod(self, @selector(lg_setBackgroundColor:)));
}

- (void)lg_setBackgroundColor:(UIColor *)color{
	
	LGThemeType themType = [LGThemeManager shareManager].currentTheme;
	

	
    if ([self isKindOfClass:[LGView class]]) {
        NSLog(@"%@",color);
        NSLog(@"%@",self.lightBgColor);
        NSLog(@"%@",self.nightBgColor);
    }
    
	if (themType == LGThemeNone && self.lightBgColor)
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
	//NSLog(@"获取夜间模式颜色:%@,%@",self.class,objc_getAssociatedObject(self, _cmd));
	return  objc_getAssociatedObject(self, _cmd);
}

- (void)setNightBgColor:(UIColor *)nightBgColor{
	
	objc_setAssociatedObject(self, @selector(nightBgColor), nightBgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    if ([self isKindOfClass:[LGView class]]) {
        
        LGThemeType themType = [LGThemeManager shareManager].currentTheme;
        if (themType == LGThemeNight) {
            self.backgroundColor = nightBgColor;
        }
            NSLog(@"设置夜间模式颜色:%@,%@",self.class,[self nightBgColor]);
    }

}

- (UIColor *)lightBgColor{
//	NSLog(@"获取白天模式颜色:%@,%@",self.class,objc_getAssociatedObject(self, _cmd));
	return  objc_getAssociatedObject(self, _cmd);
}

- (void)setLightBgColor:(UIColor *)lightBgColor{
	
	objc_setAssociatedObject(self, @selector(lightBgColor), lightBgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	

    if ([self isKindOfClass:[LGView class]]) {
        LGThemeType themType = [LGThemeManager shareManager].currentTheme;
        if (themType != LGThemeNight) {
            self.backgroundColor = lightBgColor;
        }
        NSLog(@"设置白天模式颜色:%@,%@",self.class,[self lightBgColor]);
    }
}

@end
