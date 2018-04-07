//
//  LGReportPieView.h
//  Word
//
//  Created by caoguochi on 2018/4/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGReportModel.h"

//单词报表饼状图，tag - 100 总量label
@interface LGReportPieView : UIView

@property (nonatomic, strong) LGWeekReportModel *weekReportModel;

@end
