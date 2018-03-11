//
//  LGFinishWordTaskView.h
//  Word
//
//  Created by Charles Cao on 2018/3/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGFinishWordTaskType) {
    LGFinishReciteWords, //完成"背单词"任务后提示框
    LGFinishReview       //完成"复习"任务提示框
};

@interface LGFinishWordTaskView : UIView

@property (nonatomic, copy) void(^sureActionBlock)(void);

//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

//记单词image
@property (weak, nonatomic) IBOutlet UIImageView *reciteWordsImageView;

//复习
@property (weak, nonatomic) IBOutlet UIImageView *reviewImageView;

/**
 显示单词任务完成

 @param view 加载到view
 @param type 提示框类型
 */
+ (void)showFinishToView:(UIView *)view type:(LGFinishWordTaskType)type sureBlock:(void(^)(void))sureBlock;

@end
