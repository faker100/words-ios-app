//
//  LGThirdPartyCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGThirdPartyCell.h"

@implementation LGThirdPartyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/**
 链接到第三方翻译

 @param sender tag-100-有道, tag-101-金山, tag-102-必应, tag-103-新华
 */
- (IBAction)thirdPartyAction:(UIButton *)sender {
	[self.delegate selectedThirdParty:sender.tag - 100];
}


@end
