//
//  LGStudyTypeController.h
//  Word
//
//  Created by Charles Cao on 2018/1/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

//切换学习方法成功,发送通知
#define ChangeTypeNotification @"ChangeTypeNotification"

@interface LGStudyTypeController : UIViewController

//艾宾浩斯记忆法
@property (weak, nonatomic) IBOutlet UIButton *ebbinghausButton;

//复习记忆法
@property (weak, nonatomic) IBOutlet UIButton *reviewButton;

//只背新单词
@property (weak, nonatomic) IBOutlet UIButton *onlyNewButton;

@end
