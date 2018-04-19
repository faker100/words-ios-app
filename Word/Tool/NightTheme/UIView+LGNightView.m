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
	

	if (CGColorEqualToColor(color.CGColor, [UIColor lg_colorWithType:LGColor_theme_Color].CGColor)) {
		NSLog(@"%@",[LGThemeManager colorForCurrentTheme:color]);
	}
	
	[self lg_setBackgroundColor:[UIColor blueColor]];
	return;
	
	if (self.isCustomTheme) {
		[self lg_setBackgroundColor:self.nightBackgroundColor];
	}else{
		[self lg_setBackgroundColor:[LGThemeManager colorForCurrentTheme:color]];
	}
}

- (BOOL)isCustomTheme{
	NSNumber *page = objc_getAssociatedObject(self, _cmd);
	return page.integerValue == 1;
}

- (void)setIsCustomTheme:(BOOL)isCustomTheme {
	objc_setAssociatedObject(self, @selector(isCustomTheme), @(isCustomTheme), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIColor *)nightBackgroundColor{
	return  objc_getAssociatedObject(self, _cmd);
}

- (void)setNightBackgroundColor:(UIColor *)nightBackgroundColor{
	objc_setAssociatedObject(self, @selector(nightBackgroundColor), nightBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
