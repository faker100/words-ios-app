//
//  LGDictationPractiseController.h
//  Word
//
//  Created by Charles Cao on 2018/3/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGDictationPractiseController : UIViewController


//复习单词 id 的数组
@property (nonatomic, strong) NSMutableArray <NSString *> *wordIDArray;

//倒计时
@property (weak, nonatomic) IBOutlet UIButton *countDownButton;

//翻译 label
@property (weak, nonatomic) IBOutlet UILabel *translateLabel;

//播放按钮
@property (weak, nonatomic) IBOutlet UIButton *playerButton;

//用户答案
@property (weak, nonatomic) IBOutlet UICollectionView *userAnswerCollection;

//答案选项
@property (weak, nonatomic) IBOutlet UICollectionView *answerCollection;

//提示
@property (weak, nonatomic) IBOutlet UIButton *promptButton;

//外部scrollview
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//当前单词顺序号 (title)
@property (nonatomic, copy) NSString *currentNum;

//单词总共个数 (title)
@property (nonatomic, copy) NSString *total;


@end
