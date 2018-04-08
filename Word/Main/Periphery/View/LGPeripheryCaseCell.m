//
//  LGPeripheryCaseCell.m
//  Word
//
//  Created by caoguochi on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPeripheryCaseCell.h"

@implementation LGPeripheryCaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCaseModel:(LGCaseModel *)caseModel{
    _caseModel = caseModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(caseModel.image)] placeholderImage:PLACEHOLDERIMAGE];
    self.nameLabel.text = caseModel.name;
    self.contentLabel.text = caseModel.content;
}

@end
