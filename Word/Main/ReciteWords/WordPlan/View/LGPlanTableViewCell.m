//
//  LGPlanTableViewCell.m
//  Word
//
//  Created by Charles Cao on 2018/2/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPlanTableViewCell.h"

@interface LGPlanTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *planTitleLabel;

@end

@implementation LGPlanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNum:(NSInteger)num{
    _num = num;
    NSString *unit = self.planType == LGPlanDayNum ? @"天" : @"个";
    self.planTitleLabel.text = [NSString stringWithFormat:@"%ld%@",num,unit];
}

@end
