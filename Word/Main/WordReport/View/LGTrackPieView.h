//
//  LGTrackPieView.h
//  Word
//
//  Created by caoguochi on 2018/4/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 轨迹饼状图
 tag - 100:每天新学单词文字label
       101:每天复习单词文字label
       200:每天新学单词数量
       201:每天复习单词数量
 */
@interface LGTrackPieView : UIView


/**
 设置饼状图
 
 @param dayStudy 平均每天新学
 @param dayReview 平均每天复习
 */
- (void) setPieDayStudy:(NSInteger)dayStudy dayReview:(NSInteger)dayReview;

@end
