//
//  LGRecitePlanController.h
//  Word
//
//  Created by Charles Cao on 2018/2/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGProgressView.h"

@interface LGRecitePlanController : UIViewController

//坚持天数
@property (weak, nonatomic) IBOutlet UILabel *insistLabel;
//剩余天数
@property (weak, nonatomic) IBOutlet UILabel *surplusLabel;

//今天需要背单词
@property (weak, nonatomic) IBOutlet UILabel *todayWordLabel;

//累计背单词
@property (weak, nonatomic) IBOutlet UILabel *totalWordLabel;

//当前词包
@property (weak, nonatomic) IBOutlet UIButton *currentWordLibraryButton;

//进度条
@property (weak, nonatomic) IBOutlet LGProgressView *progressBarView;
//进度 label
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

//整个进度 view
@property (weak, nonatomic) IBOutlet UIView *progressView;

//今天需要背单词,今日需要复习
@property (weak, nonatomic) IBOutlet UILabel *todayPlanLabel;


@end
