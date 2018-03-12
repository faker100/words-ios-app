//
//  LGPersonalCell.h
//  Word
//
//  Created by Charles Cao on 2018/3/12.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGSettingModel.h"

@interface LGPersonalCell : UITableViewCell


@property (nonatomic, strong) LGSettingModel *settingModel;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

//箭头宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreWidthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UILabel *infoTitleLabel;

@end


