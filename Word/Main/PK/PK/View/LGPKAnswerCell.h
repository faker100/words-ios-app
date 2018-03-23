//
//  LGPKAnswerCell.h
//  Word
//
//  Created by Charles Cao on 2018/3/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGPKAnswerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

/**
 设置答案错误状态
 */
- (void)setWrong;


/**
 设置正常状态
 */
- (void)setNormal;

@end
