//
//  LGSignModel.h
//  Word
//
//  Created by Charles Cao on 2018/4/10.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGSignModel : NSObject

//是否已签到,1-已签到, 0-未签到
@property (nonatomic, assign) NSInteger type;
//雷豆数量
@property (nonatomic, copy) NSString *integral;
//签到总天数
@property (nonatomic, copy) NSString *num;

//签到日期数组
@property (nonatomic, strong) NSMutableArray *data;


@end
