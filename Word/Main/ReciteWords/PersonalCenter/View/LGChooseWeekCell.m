//
//  LGChooseWeekCell.m
//  Word
//
//  Created by Charles Cao on 2018/3/29.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGChooseWeekCell.h"

@implementation LGChooseWeekCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
	self.chooseImageView.highlighted = selected;
    // Configure the view for the selected state
}



@end
