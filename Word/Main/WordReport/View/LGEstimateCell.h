//
//  LGEstimateCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGEstimateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@property (weak, nonatomic) IBOutlet UIImageView *wrongImageView;

//标记为错误
- (void)setWrong;

@end
