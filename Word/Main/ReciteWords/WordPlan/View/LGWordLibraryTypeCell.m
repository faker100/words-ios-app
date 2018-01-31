//
//  LGWordLibraryTypeCell.m
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordLibraryTypeCell.h"

@implementation LGWordLibraryTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
	self.contentView.backgroundColor = selected ? [UIColor lg_colorWithHexString:@"f1efe4"] : [UIColor whiteColor];
}

- (void)setWordLibrary:(LGWordLibraryModel *)wordLibrary{
	_wordLibrary = wordLibrary;
	[self.libraryImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(wordLibrary.image)] placeholderImage:PLACEHOLDERIMAGE];
	if (wordLibrary.type == LGWordLibraryFree) {
		self.libraryTitleLabel.text = wordLibrary.name;
	}else{
		NSString *str = [NSString stringWithFormat:@"%@\n(收费)",wordLibrary.name];
		NSRange titleRange = NSMakeRange(0, wordLibrary.name.length);
		NSRange priceRange = NSMakeRange(wordLibrary.name.length, str.length - wordLibrary.name.length);
		NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
		[attributeStr addAttribute:NSFontAttributeName value:self.libraryTitleLabel.font range:titleRange];
		[attributeStr addAttribute:NSForegroundColorAttributeName value:self.libraryTitleLabel.textColor range:titleRange];
		[attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:priceRange];
		[attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_theme_Color] range:priceRange];
		self.libraryTitleLabel.attributedText = attributeStr;
	}
}

@end
