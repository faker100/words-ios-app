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
    
    self.before = [NSMutableArray array];
	self.after  = [NSMutableArray array];
	
	NSArray *beforeArray = self.data[@"re"];
	NSArray *afterArray  = self.data[@"re1"];
	
    for (int i = 0; i < beforeArray.count; i++) {
		LGWeekReportModel *weak = [LGWeekReportModel mj_objectWithKeyValues:beforeArray[i][@"data"]];
		[self.before addObject:weak];
    }
	
	for (int i = 0; i < afterArray.count; i++) {
		[self.after addObject:[NSString stringWithFormat:@"%@",afterArray[i][@"data"]]];
	}
}

@end


@implementation LGWeekReportModel



@end

