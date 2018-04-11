//
//  CALayer+LGLayer.h
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (LGLayer)


/**
 用于 storyboard 的 runtime 中设置borderColor;

 @param color UIColor
 */
- (void)setBorderColorFromUIColor:(UIColor *) color;


/**
 用于 storyboard 的 runtime 中设置shadowColor;

 @param color UIColor
 */
- (void)setShadowColorFromUIColor:(UIColor *)color;

@end
