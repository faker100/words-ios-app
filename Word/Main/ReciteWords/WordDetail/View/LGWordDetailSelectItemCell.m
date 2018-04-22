//
//  LGWordDetailSelectItemCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordDetailSelectItemCell.h"

@implementation LGWordDetailSelectItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSelectedItem:(LGQuestionSelectItemModel *)selectedItem{
    _selectedItem = selectedItem;
    self.itemLable.text = selectedItem.name;
    self.answerLabel.text = selectedItem.select;
    if (selectedItem.isShowRightOrWrong) {
        self.circleView.backgroundColor = selectedItem.isRightAnswer ? [UIColor lg_colorWithType:LGColor_theme_Color] : [UIColor lg_colorWithType:LGColor_pk_red];
    }else{
        self.circleView.backgroundColor = [UIColor lg_colorWithHexString:@"C4C5C6"];
    }
}

@end
