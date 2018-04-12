//
//  LGTryListenController.h
//  Word
//
//  Created by Charles Cao on 2018/4/11.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGPlayerSlider;
@interface LGTryListenController : UIViewController

//整个播放 view
@property (weak, nonatomic) IBOutlet UIView *playerView;
//文档 view
@property (weak, nonatomic) IBOutlet UIView *docView;
//视频 view
@property (weak, nonatomic) IBOutlet UIView *videoView;
//播放暂停
@property (weak, nonatomic) IBOutlet UIButton *playButton;

//进度条
@property (weak, nonatomic) IBOutlet UISlider *slider;


//当前进度时间
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
//总时间
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
//底部工具条
@property (weak, nonatomic) IBOutlet UIView *bottomToolView;
//顶部工具条
@property (weak, nonatomic) IBOutlet UIView *topToolView;

@end

@interface LGPlayerSlider : UISlider
@end
