//
//  LGPKResultCell.h
//  Word
//
//  Created by Charles Cao on 2018/5/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGPKResultModel.h"

@interface LGPKResultCell : UITableViewCell

@property (nonatomic, strong) LGQuestionInfoModel *questionInfo;

//单词
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

//翻译
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
//我的对错
@property (weak, nonatomic) IBOutlet UIView *minRightAndWrongView;

//对手的对错
@property (weak, nonatomic) IBOutlet UIView *opponentRightAndWrongView;

@end
