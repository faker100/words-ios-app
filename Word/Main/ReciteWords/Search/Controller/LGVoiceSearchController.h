//
//  LGVoiceSearchController.h
//  Word
//
//  Created by Charles Cao on 2018/4/18.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGVoiceSearchController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
//提示语
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

//录音按钮宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
//背景圆view
@property (weak, nonatomic) IBOutlet UIView *circleView;
//背景圆view 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *circleViewHeightConstraint;

@end
