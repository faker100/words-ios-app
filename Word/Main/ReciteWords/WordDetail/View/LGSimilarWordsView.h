//
//  LGSimilarWordsView.h
//  Word
//
//  Created by Charles Cao on 2018/5/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGWordDetailModel.h"

@interface LGSimilarWordsView : UIView

@property (nonatomic, strong) LGWordDetailModel *wordDetailModel;

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

//音频 button
@property (weak, nonatomic) IBOutlet UIButton *audioButton;

//翻译
@property (weak, nonatomic) IBOutlet UILabel *translateLabel;

//例句
@property (weak, nonatomic) IBOutlet UILabel *exampleLabel;

@end
