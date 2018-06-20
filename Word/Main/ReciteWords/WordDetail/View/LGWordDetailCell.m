//
//  LGWordDetailCell.m
//  Word
//
//  Created by Charles Cao on 2018/2/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordDetailCell.h"
#import "LGUserManager.h"

@interface LGWordDetailCell()
{
    CGFloat originalFontSize;//原来的fontsize;
}

@end
@implementation LGWordDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    originalFontSize = self.contentLabel.font.pointSize;
}

- (void)setContentStr:(NSString *)contentStr highlightWord:(NSString *)highlightWord isFirst:(BOOL)isFirst isLast:(BOOL)isLast isPlay:(BOOL)isPlay{

	if (isLast) {
		self.contentBackgroundView.backgroundColor = [UIColor lg_colorWithHexString:@"F1F1F1"];
	}else{
		self.contentBackgroundView.backgroundColor = [UIColor whiteColor];
	}
	
	NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:contentStr];
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	[paragraphStyle setLineSpacing:5];//调整行间距
	[attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributeString.length)];
    
    
    CGFloat newSize = originalFontSize + [LGUserManager shareManager].user.fontSizeRate.floatValue;
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:newSize] range:NSMakeRange(0, attributeString.length)];
	
	if (highlightWord.length > 0) {
		
		//高亮
		NSArray *resultArray  = [contentStr findHighlightForWord:highlightWord];
		
		for (NSTextCheckingResult *result in resultArray) {
			[attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_theme_Color] range:result.range];
		}
	}
	//例句添加播放 icon... 检测回车位置,在回车位置处添加
	if (isPlay) {
		UIImage *img = [UIImage imageNamed:@"player_icon"];
		NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
		img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		attachment.image = img;
		CGFloat imageRate = img.size.width / img.size.height;
		attachment.bounds = CGRectMake(0, -2, imageRate * newSize , newSize);
		NSAttributedString *attrAchmentArrt = [NSAttributedString attributedStringWithAttachment:attachment];
		NSInteger playerIndex = [contentStr rangeOfString:@"\n"].location;
		[attributeString insertAttributedString:attrAchmentArrt atIndex:playerIndex];
	}
	self.contentLabel.attributedText = attributeString;

}

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
