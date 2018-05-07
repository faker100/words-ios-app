//
//  LGRecitePlanController.h
//  Word
//
//  Created by Charles Cao on 2018/2/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGProgressView.h"
#import "LGDottedLineView.h"

@interface LGRecitePlanController : UIViewController

//坚持天数
@property (weak, nonatomic) IBOutlet UILabel *insistLabel;
//剩余天数
@property (weak, nonatomic) IBOutlet UILabel *surplusLabel;

//今天需要背单词
@property (weak, nonatomic) IBOutlet UILabel *todayWordLabel;
//今天需背单词文案
@property (weak, nonatomic) IBOutlet UILabel *todayWordTextLabel;


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
//开始被单词 button
@property (weak, nonatomic) IBOutlet UIButton *reciteWordsButton;
//打卡
@property (weak, nonatomic) IBOutlet UIButton *signButton;


//请求首页数据
- (void)configIndexData;

//更新是否已打卡
- (void)updateIsSign;

@end
