//
//  LGLivePreviewCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGPeripheryModel.h"

@interface LGLivePreviewCell : UITableViewCell

@property (nonatomic, strong) LGRecentClassModel *classModel;

//几月课程
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
//课程类型
@property (weak, nonatomic) IBOutlet UILabel *courseTypeLabel;
//课程时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//课程标题
@property (weak, nonatomic) IBOutlet UILabel *courseTitleLabel;
//课程简介
@property (weak, nonatomic) IBOutlet UILabel *courseDescriptionLabel;
//老师头像
@property (weak, nonatomic) IBOutlet UIImageView *teacherImageView;
//老师名字
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLabel;

@end
