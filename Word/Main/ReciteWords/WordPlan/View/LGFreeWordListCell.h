//
//  LGFreeWordListCell.h
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFreeWordModel.h"

@interface LGFreeWordListCell : UITableViewCell

//单词
@property (weak, nonatomic) IBOutlet UILabel *wordNameLabel;
//音标
@property (weak, nonatomic) IBOutlet UILabel *wordPhonogramLabel;

//单词意思
@property (weak, nonatomic) IBOutlet UILabel *wordMeaningLabel;

@property (nonatomic, strong) LGFreeWordModel *wordModel;

@end
