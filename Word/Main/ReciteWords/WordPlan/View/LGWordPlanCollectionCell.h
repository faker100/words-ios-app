//
//  LGWordPlanCollectionCell.h
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGProgressView.h"
#import "LGPlanModel.h"

@interface LGWordPlanCollectionCell : UICollectionViewCell

//标题
@property (weak, nonatomic) IBOutlet UIButton *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet LGProgressView *progressView;

@property (nonatomic, strong) LGPlanModel *planModel;

@end
