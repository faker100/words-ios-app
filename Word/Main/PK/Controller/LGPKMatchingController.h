//
//  LGPKMatchingController.h
//  Word
//
//  Created by Charles Cao on 2018/3/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

//匹配状态
typedef NS_ENUM(NSUInteger, LGMatchingType) {
	LGMatching, 	   //匹配中
	LGMatchSuccess,   //匹配成功
};

@interface LGPKMatchingController : UIViewController

@property (nonatomic, assign) LGMatchingType matchType;

//"匹配中..." imageview
@property (weak, nonatomic) IBOutlet UIImageView *matchingImageView;

//对手头像
@property (weak, nonatomic) IBOutlet UIImageView *opponentHeadImageView;

//对手单词量
@property (weak, nonatomic) IBOutlet UILabel *opponentWordNumLabel;

//对手胜利次数
@property (weak, nonatomic) IBOutlet UILabel *opponentWinLabel;
//对手失败次数
@property (weak, nonatomic) IBOutlet UILabel *opponentLoseLabel;

//对手名字
@property (weak, nonatomic) IBOutlet UILabel *opponentNameLabel;
//倒计时
@property (weak, nonatomic) IBOutlet UIButton *countDownButton;

//用户胜利
@property (weak, nonatomic) IBOutlet UILabel *userWinLabel;
//用户失败次数
@property (weak, nonatomic) IBOutlet UILabel *userLoseLabel;
//用户单词量
@property (weak, nonatomic) IBOutlet UILabel *userWordNumLabel;
//用户头像
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

//对手/用户,胜利/失败的 icon, 仅用于动画隐藏显示
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *iconArray;

//开始Pk 按钮
@property (weak, nonatomic) IBOutlet UIButton *beginPKButton;

/**
 底部 "重新匹配  "立即 Pk" button 约束
 默认, -70,隐藏是为0;
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomButtonConstraint;



@end



