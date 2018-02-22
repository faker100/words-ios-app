//
//  LGWordDetailController.h
//  Word
//
//  Created by Charles Cao on 2018/2/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGWordDetailControllerType) {
	LGWordDetailReciteWords, 	   //背单词模式
	LGWordDetailEbbinghausReview, //艾宾浩斯复习模式
};

@interface LGWordDetailController : UIViewController

@property (nonatomic, assign) LGWordDetailControllerType type;


// 艾宾浩斯复习模式(LGWordDetailEbbinghausReview)下需要复习单词的 id 列表
@property (nonatomic, strong) NSMutableArray<NSString *> *reviewWordIdArray;

//单词 label
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;


//单词距离顶部距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wordLabelTopLayout;


//播放button距离单词label 的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerButtonTopLayout;

//播放读音 button
@property (weak, nonatomic) IBOutlet UIButton *playerButton;

//译文
@property (weak, nonatomic) IBOutlet UILabel *translateLabel;
//顶部 单词区域
@property (weak, nonatomic) IBOutlet UIView *wordView;

@property (weak, nonatomic) IBOutlet UITableView *wordTabelView;


@end
