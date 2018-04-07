//
//  LGReportModel.m
//  Word
//
//  Created by caoguochi on 2018/4/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReportModel.h"

@implementation LGReportModel

- (void)mj_keyValuesDidFinishConvertingToObject{
    
    NSMutableArray *tempMonthArray = [NSMutableArray array];
    
    for (int i = 1; i <= self.data.count; i++) {
        NSDictionary *tempDic = self.data[@(i).stringValue][@"data"];
        [tempMonthArray addObject:tempDic];
    }
    self.month = [LGWeekReportModel mj_objectArrayWithKeyValuesArray:tempMonthArray];
}

@end


@implementation LGWeekReportModel



@end

