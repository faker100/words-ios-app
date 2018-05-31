//
//  LGSimilarWordsCollectionCell.h
//  Word
//
//  Created by Charles Cao on 2018/5/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGWordDetailModel.h"

@interface LGSimilarWordsCollectionCell : UICollectionViewCell

@property (nonatomic, strong) LGSimilarWordsModel *similarWord;


@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@end
