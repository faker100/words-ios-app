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
 夜间背景颜色
 */
@property (nonatomic, assign) IBInspectable UIColor *nightBgColor;


/**
 白天背景颜色
 */
@property (nonatomic, assign) IBInspectable UIColor *lightBgColor;


@end
