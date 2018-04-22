//
//  LGFinishWordTaskView.h
//  Word
//
//  Created by Charles Cao on 2018/3/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGFinishWordTaskView : UIView

@property (nonatomic, copy) void(^sureActionBlock)(void);
@property (nonatomic, copy) void(^continueBlock)(void);
@property (nonatomic, copy) void(^cancelBlock)(void);
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

//记单词image
@property (weak, nonatomic) IBOutlet UIImageView *reciteWordsImageView;
//副标题
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

//复习image
@property (weak, nonatomic) IBOutlet UIImageView *reviewImageView;

//休息 、 继续
@property (weak, nonatomic) IBOutlet UIView *continueView;
//复习完成确定
@property (weak, nonatomic) IBOutlet UIButton *reviewSureButton;


/**
 显示复习单词任务完成

 @param view 加载到view
 */
+ (void)showReviewFinishToView:(UIView *)view sureBlock:(void(^)(void))sureBlock;


/**
 背单词完成

 @param view 加载到view
 @param continueBlock 继续
 @param cancelBlock 休息
 */
+ (void)showFinishReciteWordToView:(UIView *)view continueBlock:(void(^)(void))continueBlock cancelBlock:(void(^)(void))cancelBlock;

@end
