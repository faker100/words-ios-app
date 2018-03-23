//
//  LGAtPKController.h
//  Word
//
//  Created by Charles Cao on 2018/3/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGProgressView.h"
#import "LGJPushReceiveMessageModel.h"

@interface LGAtPKController : UIViewController

@property (nonatomic, strong) LGReadyPKModel *pkModel;
@property (nonatomic, strong) LGMatchUserModel *opponentModel;    //对手信息
@property (nonatomic, strong) LGMatchUserModel *currentUserModel; //当前用户信息

//答案 table, 如果能显示完所有答案,禁止滚动
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//用户头像
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
//用户进度
@property (weak, nonatomic) IBOutlet UILabel *userProgressLabel;
//用户胜率
@property (weak, nonatomic) IBOutlet UILabel *userWinLabel;

//对手头像
@property (weak, nonatomic) IBOutlet UIImageView *opponentImageView;
//对手进度
@property (weak, nonatomic) IBOutlet UILabel *opponentProgressLabel;
//对手胜率
@property (weak, nonatomic) IBOutlet UILabel *opponentWinLabel;
//双方胜率进度
@property (weak, nonatomic) IBOutlet LGProgressView *winProgressView;
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//单词名
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
//音频
@property (weak, nonatomic) IBOutlet UIButton *audioButton;

@end
