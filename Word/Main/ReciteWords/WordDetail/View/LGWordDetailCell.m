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
	[self.contentLabel sizeToFit];
	
//	CALayer *radiusLayer;
//	CGFloat bgViewHeight = self.contentLabel.bounds.size.height + 8;
//	if (isLast && isFirst) {
//				radiusLayer = [self getRadiusLayer:UIRectCornerAllCorners cornerRadius:5 height:bgViewHeight];
//			}else if (isFirst) {
//				self.contentBackgroundView.layer.mask = [self getRadiusLayer:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadius:5 height:bgViewHeight] ;
//			}else if (isLast) {
//				self.contentBackgroundView.layer.mask = [self getRadiusLayer:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadius:5 height:bgViewHeight];
//			}else{
//				self.contentBackgroundView.layer.mask = [self getRadiusLayer:UIRectCornerAllCorners cornerRadius:0 height:bgViewHeight];
//			}
}


//- (void)layoutSubviews{
//	
//	if (self.isLast && self.isFirst) {
//		self.contentBackgroundView.layer.mask = [self getRadiusLayer:UIRectCornerAllCorners cornerRadius:5];
//	}else if (self.isFirst) {
//		self.contentBackgroundView.layer.mask = [self getRadiusLayer:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadius:5] ;
//	}else if (self.isLast) {
//		self.contentBackgroundView.layer.mask = [self getRadiusLayer:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadius:5];
//	}else{
//		self.contentBackgroundView.layer.mask = [self getRadiusLayer:UIRectCornerAllCorners cornerRadius:0];
//	}
//}

- (CALayer *)getRadiusLayer:(UIRectCorner)rectCorners cornerRadius:(CGFloat)radius height:(CGFloat)height{
	CGRect rect = self.contentBackgroundView.bounds;
	rect.size.height = height;
	UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:rectCorners cornerRadii:CGSizeMake(radius, radius)];
	CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
	maskLayer.frame = self.contentBackgroundView.bounds;
	maskLayer.path = maskPath.CGPath;
	return  maskLayer;
}

@end
