//
//  LGWordDetailSelectItemCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGWordDetailSelectItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;


//小圆点
@property (weak, nonatomic) IBOutlet UIView *circleView;

// A. B. C......
@property (weak, nonatomic) IBOutlet UILabel *itemLable;

@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@end
