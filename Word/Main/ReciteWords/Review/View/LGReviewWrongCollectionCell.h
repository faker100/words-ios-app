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

@property (weak, nonatomic) IBOutlet UILabel *rangeLabel;

@end
