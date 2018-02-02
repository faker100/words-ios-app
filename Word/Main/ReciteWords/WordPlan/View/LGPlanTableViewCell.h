//
//  LGPlanTableViewCell.h
//  Word
//
//  Created by Charles Cao on 2018/2/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGPlanTableViewCellType) {
	LGPlanDayNum = 0,   //天数 cell
	LGplanWordNum   //单词个数
	
};

@interface LGPlanTableViewCell : UITableViewCell

//对应(LGPlanTableViewCellType) 为了在 storyboard里可视化,用NSInteger
@property (nonatomic, assign) IBInspectable NSInteger planType;

//设置数量
@property (nonatomic, assign) NSInteger *num;


@end
