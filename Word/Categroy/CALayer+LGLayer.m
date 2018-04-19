//
//  CALayer+LGLayer.m
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "CALayer+LGLayer.h"

@implementation CALayer (LGLayer)

- (void)setBorderColorFromUIColor:(UIColor *) color{
	
	if (self.borderWidth == 0) self.borderWidth = 1;
	self.borderColor = color.CGColor;
}

- (void)setShadowColorFromUIColor:(UIColor *)color{
	self.shadowColor = color.CGColor;
}

@end
