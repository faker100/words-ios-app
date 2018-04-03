//
//  LGPKResultController.h
//  Word
//
//  Created by Charles Cao on 2018/3/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGJPushReceiveMessageModel.h"

@interface LGPKResultController : UIViewController

@property (nonatomic, strong) LGReadyPKModel *pkModel;
@property (nonatomic, strong) LGMatchUserModel *currentUserModel; //当前用户信息
@property (nonatomic, strong) LGMatchUserModel *opponentUserModel;//对手信息

//结果 image
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;

//用户胜利头像 win icon
@property (weak, nonatomic) IBOutlet UIImageView *userWinImageView;
//对手胜利头像 win icon
@property (weak, nonatomic) IBOutlet UIImageView *opponentWinImageView;

//当前用户头像
@property (weak, nonatomic) IBOutlet UIImageView *currentUserHeadImageView;
//用户昵称
@property (weak, nonatomic) IBOutlet UILabel *currentUserNicknameLabel;
//对手头像
@property (weak, nonatomic) IBOutlet UIImageView *opponentHeadImageView;
//对手昵称
@property (weak, nonatomic) IBOutlet UILabel *opponentNicknameLabel;
//用户正确次数
@property (weak, nonatomic) IBOutlet UILabel *currentUserWinLabel;
//用户失败次数
@property (weak, nonatomic) IBOutlet UILabel *currentUserLoseLabel;
//对手正确次数
@property (weak, nonatomic) IBOutlet UILabel *opponentWinLabel;
//对手失败次数
@property (weak, nonatomic) IBOutlet UILabel *opponentLoseLabel;

@end
