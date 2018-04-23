//
//  UILabel+LGNightLabel.h
//  Word
//
//  Created by caoguochi on 2018/4/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LGNightLabel)

/**
 夜间textColor颜色
 */
@property (nonatomic, assign) IBInspectable UIColor *nightTextColor;


/**
 白天textColor颜色
 */
@property (nonatomic, assign) IBInspectable UIColor *lightTextColor;

@end
