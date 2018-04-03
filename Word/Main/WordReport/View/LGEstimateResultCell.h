//
//  LGEstimateResultCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/3.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGEstimateResultModel.h"

@interface LGEstimateResultCell : UITableViewCell

@property (nonatomic, strong) LGRateModel *rateModel;

//等级
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
//正确率
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@property (weak, nonatomic) IBOutlet UIView *bgView;


/**
 设置数据

 @param rateModel 正确率
 @param isLast 是否是最后一个
 */
- (void)setRateModel:(LGRateModel *)rateModel isLast:(BOOL)isLast;

@end
