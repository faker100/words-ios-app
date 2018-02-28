//
//  LGWordDetailCell.m
//  Word
//
//  Created by Charles Cao on 2018/2/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordDetailCell.h"

@implementation LGWordDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentStr:(NSString *)contentStr isFirst:(BOOL)isFirst isLast:(BOOL)isLast{

	NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:contentStr];
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	[paragraphStyle setLineSpacing:5];//调整行间距
	[attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributeString.length)];
	self.contentLabel.attributedText = attributeString;
	
	if (isLast && isLast) {
		self.contentBackgroundView.layer.mask = [self getRadiusLayer:UIRectCornerAllCorners cornerRadius:5];
	}else if (isFirst) {
		self.contentBackgroundView.layer.mask = [self getRadiusLayer:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadius:5] ;
	}else if (isLast) {
		self.contentBackgroundView.layer.mask = [self getRadiusLayer:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadius:5];
	}else{
		self.contentBackgroundView.layer.mask = [self getRadiusLayer:UIRectCornerAllCorners cornerRadius:0];
	}
}

- (CALayer *)getRadiusLayer:(UIRectCorner)rectCorners cornerRadius:(CGFloat)radius{
	UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentBackgroundView.bounds byRoundingCorners:rectCorners cornerRadii:CGSizeMake(radius, radius)];
	CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
	maskLayer.frame = self.contentBackgroundView.bounds;
	maskLayer.path = maskPath.CGPath;
	return  maskLayer;
}

@end
