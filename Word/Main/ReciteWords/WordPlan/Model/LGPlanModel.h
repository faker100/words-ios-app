//
//  LGPlanModel.h
//  Word
//
//  Created by Charles Cao on 2018/2/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGPlanModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *planDay;   //选择天数
@property (nonatomic, copy) NSString *planWords; //选择计划
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *userWords;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *catId;

//自定义字段,剩余单词
//@property (nonatomic, assign, readonly) NSInteger surplusWord;

@end
