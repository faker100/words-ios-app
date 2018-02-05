//
//  LGPlanModel.h
//  Word
//
//  Created by Charles Cao on 2018/2/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGPlanModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *planDay;   //选择天数
@property (nonatomic, strong) NSString *planWords; //选择计划
@property (nonatomic, strong) NSString *total;     
@property (nonatomic, strong) NSString *userWords;
@property (nonatomic, strong) NSString *name;

//自定义字段,剩余单词
@property (nonatomic, assign, readonly) NSInteger surplusWord;

@end
