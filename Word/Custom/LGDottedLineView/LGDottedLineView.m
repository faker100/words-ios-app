//
//  LGDottedLineView.m
//  Word
//
//  Created by Charles Cao on 2018/2/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGDottedLineView.h"

@interface LGDottedLineView()

//@property (nonatomic, assign) CGFloat *floatLenghts;

@end

@implementation LGDottedLineView

- (void)drawRect:(CGRect)rect{
	[super drawRect:rect];
	
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	//设置虚线颜色
	CGContextSetStrokeColorWithColor(currentContext, self.strokeColor.CGColor);
	//设置虚线宽度
	CGContextSetLineWidth(currentContext, 2);
	CGContextSetShouldAntialias(currentContext, NO);
	//设置虚线绘制起点
	CGContextMoveToPoint(currentContext, 0, 0);
	//设置虚线绘制终点
	CGContextAddLineToPoint(currentContext, CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));
	
	//设置虚线点
	NSArray <NSString *> *array = [self.lengths componentsSeparatedByString:@","];
	CGFloat floatLength[array.count];
	if (ArrayNotEmpty(array)) {
		for (int i = 0; i < array.count; i++) {
			floatLength[i] = array[i].floatValue;
			}
	}
	
	CGContextSetLineDash(currentContext, 0, floatLength, array.count);
	CGContextDrawPath(currentContext, kCGPathStroke);
}

@end
