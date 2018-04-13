//
//  LGTryListenController.h
//  Word
//
//  Created by Charles Cao on 2018/4/11.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGCourseModel.h"

@class LGPlayerSlider;
@interface LGTryListenController : UIViewController

@property (nonatomic, strong) LGCourseModel *courseModel;

//整个播放 view
@property (weak, nonatomic) IBOutlet UIView *playerView;
//文档 view
@property (weak, nonatomic) IBOutlet UIView *docView;
//视频 view
@property (weak, nonatomic) IBOutlet UIView *videoView;
//播放暂停
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UILabel *courseTitleLabel;

//打开关闭视频
@property (weak, nonatomic) IBOutlet UIButton *showVideoButton;

//内容
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

//进度条
@property (weak, nonatomic) IBOutlet UISlider *slider;

//速度播放
@property (weak, nonatomic) IBOutlet UIButton *speedButton;

//当前进度时间
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
//总时间
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
//底部工具条
@property (weak, nonatomic) IBOutlet UIView *bottomToolView;
//顶部工具条
@property (weak, nonatomic) IBOutlet UIView *topToolView;

//顶部工具栏约束 用于隐藏动画,默认 (-64), 0为隐藏
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;

//底部工具栏约束 用于隐藏动画, 默认 35, 0隐藏
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;


@end

@interface LGPlayerSlider : UISlider
@end
