//
//  UIView+LGNightView.h
//  Word
//
//  Created by Charles Cao on 2018/4/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LGNightView)



/**
 是否自定义主题颜色
 不受统一修改.
 */
@property (nonatomic, assign) IBInspectable BOOL isCustomTheme;


/**
 夜间背景颜色
 */
@property (nonatomic, assign) IBInspectable UIColor *nightBackgroundColor;

@end
