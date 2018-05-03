//
//  LGWordDetailShareController.h
//  Word
//
//  Created by caoguochi on 2018/5/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGWordDetailShareController : UIViewController

//日期
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//坚持天数
@property (weak, nonatomic) IBOutlet UILabel *insistLabel;

//今日背单词
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@end
