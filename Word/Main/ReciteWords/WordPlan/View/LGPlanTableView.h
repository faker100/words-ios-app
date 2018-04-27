//
//  LGPlanTableView.h
//  Word
//
//  Created by Charles Cao on 2018/4/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGChoosePlanType) {
	LGChooseDayPlan = 0,   //选择天数计划
	LGChooseNumPlan       //选择个数计划
};

@interface LGPlanTableView : UITableView

//对应(LGChoosePlanType) 为了在 storyboard里可视化,用NSInteger
@property (nonatomic, assign) IBInspectable NSInteger planType;

//中间高亮view
@property (nonatomic, strong) UIView *selectedCellBackgroundView;

@end
