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


@property (weak, nonatomic) IBOutlet UIView *bgColorView;

//标题
@property (weak, nonatomic) IBOutlet UIButton *titleNameButton;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet LGProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


@property (nonatomic, strong) LGPlanModel *planModel;

@end
