//
//  UILabel+LGNightLabel.m
//  Word
//
//  Created by caoguochi on 2018/4/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "UILabel+LGNightLabel.h"
#import "LGThemeManager.h"
#import "LGTextLabel.h"

@implementation UILabel (LGNightLabel)

+ (void)load{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(setTextColor:)),class_getInstanceMethod(self, @selector(lg_setTextColor:)));
}

- (void)lg_setTextColor:(UIColor *)color{
    
    LGThemeType themType = [LGThemeManager shareManager].currentTheme;

    if ([self isKindOfClass:[LGTextLabel class]]) {
        NSLog(@"%@",color);
        NSLog(@"%@",self.lightTextColor);
        NSLog(@"%@",self.nightTextColor);
    }
    
    if (themType == LGThemeNone && self.lightBgColor)
    {
        [self lg_setTextColor:self.lightBgColor];
        
    }else if (themType == LGThemeNight && self.nightBgColor)
    {
        [self lg_setTextColor:self.nightBgColor];
        
    }else
    {
        [self lg_setTextColor:color];
    }
}

- (void)setNightTextColor:(UIColor *)nightTextColor{
    objc_setAssociatedObject(self, @selector(nightTextColor), nightTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self isKindOfClass:[LGTextLabel class]]) {
        LGThemeType themType = [LGThemeManager shareManager].currentTheme;
        if (themType == LGThemeNight) {
            self.textColor = nightTextColor;
        }
    }
}

- (UIColor *)nightTextColor{
    return  objc_getAssociatedObject(self, _cmd);;
}

- (void)setLightTextColor:(UIColor *)lightTextColor{
    objc_setAssociatedObject(self, @selector(lightTextColor), lightTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self isKindOfClass:[LGTextLabel class]]) {
        LGThemeType themType = [LGThemeManager shareManager].currentTheme;
        if (themType != LGThemeNight) {
            self.textColor = lightTextColor;
        }
    }
    
}

- (UIColor *)lightTextColor{
    return  objc_getAssociatedObject(self, _cmd);;
}

@end
