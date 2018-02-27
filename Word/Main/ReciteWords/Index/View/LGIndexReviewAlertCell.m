//
//  LGIndexReviewAlertCell.m
//  Word
//
//  Created by Charles Cao on 2018/2/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGIndexReviewAlertCell.h"

@implementation LGIndexReviewAlertCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
	self.contentView.backgroundColor = [UIColor whiteColor];
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
	[super setHighlighted:highlighted animated:animated];
	self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setSubModel:(LGReviewSubModel *)subModel{
	_subModel = subModel;
	NSString *tempStr = [NSString stringWithFormat:@"%@ ( %@词 )",subModel.descriptionStr, subModel.count];
	NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:tempStr];
	
	[attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, subModel.descriptionStr.length)];
	
	[attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(subModel.descriptionStr.length, tempStr.length - subModel.descriptionStr.length)];;
	
	[attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_Title_2_Color] range:NSMakeRange(0, tempStr.length)];
	
	[attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_theme_Color] range:[tempStr rangeOfString:subModel.count]];
	
	self.descriptionLabel.attributedText = attributeString;
}

@end
