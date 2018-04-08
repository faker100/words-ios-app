//
//  LGPublicCourseCollectionCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGPeripheryModel.h"

@interface LGPublicCourseCollectionCell : UICollectionViewCell

@property (nonatomic, strong) LGRecentClassModel *classModel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *courseTimeLabel;

@end
