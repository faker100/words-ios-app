//
//  LGWordPlanCollectionCell.m
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordPlanCollectionCell.h"

@implementation LGWordPlanCollectionCell

- (void)setSelected:(BOOL)selected{
    
}

- (void)setPlanModel:(LGPlanModel *)planModel{
    _planModel = planModel;
    [self.titleNameLabel setTitle:planModel.userWords forState:UIControlStateNormal];;
}

@end
