//
//  LGClockListCell.m
//  Word
//
//  Created by Charles Cao on 2018/3/29.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGClockListCell.h"

@implementation LGClockListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setClockModel:(LGClockModel *)clockModel{
	_clockModel = clockModel;
	self.timeLabel.text = clockModel.time;
	self.weekLabel.text = [clockModel weakStr];
	self.useSwitch.on   = clockModel.isUse;
}

//switch action
- (IBAction)uesAction:(UISwitch *)sender {
	
	[self.delegate setUseClock:self.clockModel isUse:sender.isOn];
}



@end
