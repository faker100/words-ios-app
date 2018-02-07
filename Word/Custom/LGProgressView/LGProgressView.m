//
//  LGProgressView.m
//  Word
//
//  Created by Charles Cao on 2018/1/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGProgressView.h"

@interface LGProgressView ()

@property (nonatomic, strong) CALayer *progressLayer;

@end

@implementation LGProgressView

- (void)awakeFromNib{
	[super awakeFromNib];
   // [self setNeedsLayout];
    //[self layoutIfNeeded];
	self.layer.cornerRadius = self.radius;
	self.backgroundColor = self.progressTintColor;
	self.progressLayer.cornerRadius = self.radius;
	self.progressLayer.backgroundColor = self.trackTintColor.CGColor;
	self.progressLayer.frame = CGRectMake(0, 0, self.layer.frame.size.width * self.progress, self.layer.frame.size.height);
	[self.layer addSublayer:self.progressLayer];
	
}


- (void)layoutSubviews{
    self.progress = self.progress;
}

- (void)setProgress:(float)progress{
	_progress = MIN(progress, 1.0);
    self.progressLayer.frame = CGRectMake(0, 0, self.layer.frame.size.width * self.progress, self.layer.frame.size.height);
}

- (CALayer *)progressLayer{
	if (!_progressLayer) {
		_progressLayer = [CALayer layer];
	}
	return _progressLayer;
}

- (void) setTrackTintColor:(UIColor *)trackTintColor{
	_trackTintColor = trackTintColor;
	[CATransaction begin];
	[CATransaction setDisableActions:YES];
	self.progressLayer.backgroundColor = trackTintColor.CGColor;
	[CATransaction commit];
	
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	UIColor *fillColor = self.progressTintColor ? self.progressTintColor : [UIColor whiteColor];
//	CGContextSetFillColorWithColor(context, fillColor.CGColor);
//
//	UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.radius];
//	CGContextAddPath(context, path.CGPath);
//	CGContextStrokePath(context);
//}


@end
