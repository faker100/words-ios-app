//
//  LGSimilarWordsCell.h
//  Word
//
//  Created by Charles Cao on 2018/5/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGWordDetailModel.h"

@protocol LGSimilarWordsCellDelegate <NSObject>

- (void)selectedSimilar:(LGSimilarWordsModel *)similarWords;

@end

@interface LGSimilarWordsCell : UITableViewCell

@property (nonatomic, weak) id<LGSimilarWordsCellDelegate> delegate;

@property (nonatomic, copy) NSArray<LGSimilarWordsModel *> *similarWords;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//collection 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeightConstraint;

@end
