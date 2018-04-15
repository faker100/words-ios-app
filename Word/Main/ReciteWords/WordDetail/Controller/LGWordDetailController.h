//
//  LGWordDetailController.h
//  Word
//
//  Created by Charles Cao on 2018/2/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGWordDetailModel.h"

typedef NS_ENUM(NSUInteger, LGWordDetailControllerType) {
	LGWordDetailReciteWords = 0, 	   //背单词模式,默认
	LGWordDetailEbbinghausReview,      //艾宾浩斯复习模式
	LGWordDetailTodayReview,		   //今日复习
    LGWordDetailReview,                //错题本复习/时间复习
	LGWordDetailDictationPrompt,       //听写练习提示
    LGWordDetailSearch,                //搜索单词
};


@interface LGWordDetailController : UIViewController

//controller 模式
@property (nonatomic, assign) LGWordDetailControllerType controllerType;

//搜索模式下的单词
@property (nonatomic, copy) NSString *searchWordStr;
//搜索模式下的单词id
@property (nonatomic, copy) NSString *searchWordID;

//正常复习模式下的复习方式
@property (nonatomic, assign) LGSelectReviewType reviewTyep;
//正常复习模式下的复习 id 数组
@property (nonatomic, strong) NSMutableArray<NSString *> *reviewWordIdArray;

//听写练习提示模式下的提示单词
@property (nonatomic, strong) LGWordDetailModel *dictationPromptWord;

//今日复习模式下(LGWordDetailTodayReview),要复习的状态,0为全部
@property (nonatomic, assign) LGWordStatus todayReviewStatus;

// 艾宾浩斯复习模式(LGWordDetailEbbinghausReview)下需要复习单词的 id 列表
@property (nonatomic, strong) NSMutableArray<NSString *> *ebbinghausReviewWordIdArray;

//当前单词顺序号 (title)
@property (nonatomic, copy) NSString *currentNum;

//单词总共个数 (title)
@property (nonatomic, copy) NSString *total;

//单词 label
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

//播放button距离单词label 的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerButtonTopLayout;

//播放读音 button
@property (weak, nonatomic) IBOutlet UIButton *playerButton;

//译文
@property (weak, nonatomic) IBOutlet UILabel *translateLabel;

//顶部 单词区域
@property (weak, nonatomic) IBOutlet UIView *wordView;

// '模糊' / '忘记'按钮 , 复习模式下为'忘记',背单词模式下为 '模糊'
@property (weak, nonatomic) IBOutlet UIButton *vagueOrForgotButton;

@property (weak, nonatomic) IBOutlet UITableView *wordTabelView;

//底部单词状态 view 的高度约束,在听写练习提示模式下,高度为0,隐藏
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusViewHeightConstraint;

//熟识
@property (weak, nonatomic) IBOutlet UIButton *familiarItemButton;

@end
