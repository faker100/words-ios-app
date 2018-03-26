//
//  LGPKResultController.h
//  Word
//
//  Created by Charles Cao on 2018/3/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGPKResultController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;

//当前用户头像
@property (weak, nonatomic) IBOutlet UIImageView *currentUserHeadImageView;

@property (weak, nonatomic) IBOutlet UILabel *currentUserNicknameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *opponentHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *opponentNicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentUserWinLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentUserLoseLabel;
@property (weak, nonatomic) IBOutlet UILabel *opponentWinLabel;
@property (weak, nonatomic) IBOutlet UILabel *opponentLoseLabel;

@end
