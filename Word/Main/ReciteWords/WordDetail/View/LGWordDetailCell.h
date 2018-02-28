//
//  LGWordDetailCell.h
//  Word
//
//  Created by Charles Cao on 2018/2/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGWordDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *contentBackgroundView;


/**
 设置 cell 内容,每个 section 的首尾cell需要圆角设置

 @param contentStr 内容
 @param isFirst 是否第一个 cell
 @param isLast 是否最后一个 cell
 */
- (void) setContentStr:(NSString *)contentStr isFirst:(BOOL)isFirst isLast:(BOOL)isLast;

@end
