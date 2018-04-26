//
//  LGStudyTypeController.h
//  Word
//
//  Created by Charles Cao on 2018/1/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LGStudyTypeController : UIViewController


/**
 是否从引导页过来的
 */
@property(nonatomic, assign) BOOL isPresentFromGuide;

//艾宾浩斯记忆法
@property (weak, nonatomic) IBOutlet UIButton *ebbinghausButton;

//复习记忆法
@property (weak, nonatomic) IBOutlet UIButton *reviewButton;

//只背新单词
@property (weak, nonatomic) IBOutlet UIButton *onlyNewButton;

@end
