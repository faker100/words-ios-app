//
//  LGPKMatchingController.h
//  Word
//
//  Created by Charles Cao on 2018/3/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGPKMatchingController : UIViewController

//匹配中... imageview
@property (weak, nonatomic) IBOutlet UIImageView *matchingImageView;

//对手头像
@property (weak, nonatomic) IBOutlet UIImageView *opponentHeadImageView;

//对手单词量
@property (weak, nonatomic) IBOutlet UILabel *opponentWordNumLabel;


@end



