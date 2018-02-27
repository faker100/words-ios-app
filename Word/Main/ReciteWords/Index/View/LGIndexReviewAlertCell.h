//
//  LGIndexReviewAlertCell.h
//  Word
//
//  Created by Charles Cao on 2018/2/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGIndexReviewModel.h"

@interface LGIndexReviewAlertCell : UITableViewCell

@property (nonatomic, strong)  LGReviewSubModel *subModel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


@end
