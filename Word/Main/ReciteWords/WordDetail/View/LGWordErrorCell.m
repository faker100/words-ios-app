//
//  LGWordErrorCell.m
//  Word
//
//  Created by Charles Cao on 2018/2/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordErrorCell.h"

@implementation LGWordErrorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	[UIView animateWithDuration:0.4 animations:^{
			self.contentView.backgroundColor = [UIColor lg_colorWithHexString:@"F3F3F3"];
	} completion:nil];
}

@end
