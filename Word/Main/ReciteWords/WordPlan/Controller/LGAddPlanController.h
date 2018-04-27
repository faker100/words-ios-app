//
//  LGAddPlanController.h
//  Word
//
//  Created by Charles Cao on 2018/4/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGPlanTableView.h"
#import "LGPlanModel.h"
#import "LGWordLibraryModel.h"

@interface LGAddPlanController : UIViewController

@property (nonatomic, strong) LGPlanModel *selectedPlan;

@property (nonatomic, strong) LGChildWordLibraryModel *libModel;

//包名
@property (weak, nonatomic) IBOutlet UILabel *packageLabel;

//计划 label
@property (weak, nonatomic) IBOutlet UILabel *planLabel;

//选择天数
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

// 选择个数
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

//选择天数 table
@property (weak, nonatomic) IBOutlet LGPlanTableView *dayTable;

//选择个数 table
@property (weak, nonatomic) IBOutlet LGPlanTableView *numberTable;

@end
