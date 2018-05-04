//
//  LGReviewWrongCollectionCell.h
//  Word
//
//  Created by Charles Cao on 2018/3/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGReviewWrongWordModel.h"

@interface LGReviewWrongCollectionCell : UICollectionViewCell

@property (nonatomic, strong) LGReviewWrongWordModel *wrongWordModel;

//进度
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

//进度背景
@property (weak, nonatomic) IBOutlet UIImageView *progressBgImageView;

//范围
@property (weak, nonatomic) IBOutlet UILabel *rangeLabel;



@end
