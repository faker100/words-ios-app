//
//  LGClockListCell.h
//  Word
//
//  Created by Charles Cao on 2018/3/29.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGClockModel.h"

@protocol LGClockListCellDelegate


/**
 设置闹钟是否可用

 @param clock 闹钟 model
 @param isUse  是否可用
 */
- (void)setUseClock:(LGClockModel *)clock isUse:(BOOL)isUse;

@end

@interface LGClockListCell : UITableViewCell

@property (nonatomic, weak) id<LGClockListCellDelegate> delegate;

@property (nonatomic, strong) LGClockModel *clockModel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UISwitch *useSwitch;

@end
