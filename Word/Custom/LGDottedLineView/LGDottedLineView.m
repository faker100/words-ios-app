//
//  LGDottedLineView.m
//  Word
//
//  Created by Charles Cao on 2018/2/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGDottedLineView.h"

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
	if (self.direction == 0) {
		CGContextAddLineToPoint(currentContext, self.bounds.size.width, 0);
	}else{
		CGContextAddLineToPoint(currentContext, 0, self.bounds.size.height);
	}
	
	//设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制2个点再绘制1个点
	NSArray <NSString *> *array = [self.lengths componentsSeparatedByString:@","];
	//下面最后一个参数“1”代表排列的个数。
	
	CGFloat arr[] = {array.firstObject.floatValue,array.lastObject.floatValue};
	CGContextSetLineDash(currentContext, 0, arr, 1);
	CGContextDrawPath(currentContext, kCGPathStroke);
}

@end
