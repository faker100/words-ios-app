//
//  LGWordPlanController.h
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGChoosePlanType) {
	LGChooseDayPlan = 0,   //选择天数计划
	LGChooseNumPlan       //选择个数计划
};

@class LGPlanTableView;
@interface LGWordPlanController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//编辑按钮
@property (weak, nonatomic) IBOutlet UIButton *editButton;

//词包列表
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//选择天数
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

// 选择个数
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

//选择天数 table
@property (weak, nonatomic) IBOutlet LGPlanTableView *dayTable;

//选择个数 table
@property (weak, nonatomic) IBOutlet LGPlanTableView *numberTable;

@end

@interface LGPlanTableView : UITableView

//对应(LGChoosePlanType) 为了在 storyboard里可视化,用NSInteger
@property (nonatomic, assign) IBInspectable NSInteger planType;

//中间高亮view
@property (nonatomic, strong) UIView *selectedCellBackgroundView;

@end


