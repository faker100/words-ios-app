//
//  LGTrackFinishProgressCell.h
//  Word
//
//  Created by Charles Cao on 2018/3/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGProgressView.h"
#import "LGTrackModel.h"

@interface LGTrackFinishProgressCell : UITableViewCell

@property (nonatomic, strong) LGTracPackageModel *packageModel;

//包名
@property (weak, nonatomic) IBOutlet UILabel *packageNameLabel;

//完成进度条
@property (weak, nonatomic) IBOutlet LGProgressView *progressView;

//完成情况
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end
