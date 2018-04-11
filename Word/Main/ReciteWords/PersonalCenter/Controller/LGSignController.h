//
//  LGSignController.h
//  Word
//
//  Created by Charles Cao on 2018/4/10.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGSignController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//签到按钮
@property (weak, nonatomic) IBOutlet UIButton *signButton;

//当前日期
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;

//累计打卡
@property (weak, nonatomic) IBOutlet UILabel *totalSignLabel;

//雷豆总数
@property (weak, nonatomic) IBOutlet UILabel *numLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

