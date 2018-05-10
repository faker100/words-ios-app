//
//  LGWordDetailSelectItemCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordDetailSelectItemCell.h"
#import "NSString+LGString.h"
#import "LGUserManager.h"

@interface LGWordDetailSelectItemCell()
{
    CGFloat originalFontSize;//原来的fontsize;
}
@end
@implementation LGWordDetailSelectItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    originalFontSize = self.answerLabel.font.pointSize;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSelectedItem:(LGQuestionSelectItemModel *)selectedItem completion:(void(^)(void))completion{
	
	if (selectedItem == self.selectedItem) {
		return;
	}
	
    CGFloat newSize = originalFontSize + [LGUserManager shareManager].user.fontSizeRate.floatValue;
    
    self.selectedItem = selectedItem;
    self.itemLable.text = selectedItem.name;
	
	//带图片的 html
	if ([selectedItem.select containsString:@"<img"]) {
		[selectedItem.select htmlToAttributeStringContent:GMAT_DOMAIN(@"") width:CGRectGetWidth(self.answerLabel.bounds)  completion:^(NSMutableAttributedString *attrStr) {
			self.answerLabel.attributedText = attrStr;
            
            [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:newSize] range:NSMakeRange(0, attrStr.length)];
			completion();
		}];
	}else{
        self.answerLabel.font  = [UIFont systemFontOfSize:newSize];
		self.answerLabel.text = selectedItem.select;
	}

    if (selectedItem.isShowRightOrWrong) {
        self.circleView.backgroundColor = selectedItem.isRightAnswer ? [UIColor lg_colorWithType:LGColor_theme_Color] : [UIColor lg_colorWithType:LGColor_pk_red];
    }else{
        self.circleView.backgroundColor = [UIColor lg_colorWithHexString:@"C4C5C6"];
    }
}

@end
