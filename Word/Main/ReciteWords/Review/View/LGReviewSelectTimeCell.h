//
//  LGReviewSelectTimeCell.h
//  Word
//
//  Created by Charles Cao on 2018/3/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGReviewSelectTimeCell : UITableViewCell

@property (nonatomic, strong) NSDate *date;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
