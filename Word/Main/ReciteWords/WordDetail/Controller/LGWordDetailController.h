//
//  LGWordDetailController.h
//  Word
//
//  Created by Charles Cao on 2018/2/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGWordDetailController : UIViewController

//单词 label
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;


//单词距离顶部距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wordLabelTopLayout;


//播放button距离单词label 的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerButtonTopLayout;

//播放读音 button
@property (weak, nonatomic) IBOutlet UIButton *playerButton;

//译文
@property (weak, nonatomic) IBOutlet UILabel *translateLabel;
//顶部 单词区域
@property (weak, nonatomic) IBOutlet UIView *wordView;

//左边单词 tableView
@property (weak, nonatomic) IBOutlet UITableView *wordTabelView;


@end
