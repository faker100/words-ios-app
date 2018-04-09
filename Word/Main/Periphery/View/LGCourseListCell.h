//
//  LGCourseListCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGCourseModel.h"

@interface LGCourseListCell : UITableViewCell

@property (nonatomic, strong) LGCourseModel *courseModel;

@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;

@property (weak, nonatomic) IBOutlet UILabel *courseTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *joinNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *tryListenButton;

@end
