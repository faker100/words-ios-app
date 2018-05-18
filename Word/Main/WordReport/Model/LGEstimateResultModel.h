//
//  LGEstimateResultModel.h
//  Word
//
//  Created by Charles Cao on 2018/4/3.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  LGRateModel;
@interface LGEstimateResultModel : NSObject

//水平
@property (nonatomic, copy) NSString *level;
//词汇量
@property (nonatomic, copy) NSString *num;
//四级
@property (nonatomic, copy) NSString *four;
//六级
@property (nonatomic, copy) NSString *six;

@property (nonatomic, copy) NSString *ielts;
@property (nonatomic, copy) NSString *toefl;
@property (nonatomic, copy) NSString *gmat;
@property (nonatomic, copy) NSString *gre;
@property (nonatomic, copy) NSString *know;
@property (nonatomic, copy) NSString *notKnow;

//打败多少人
@property (nonatomic, assign) CGFloat bit;

//自定义字段,筛选各种水平的正确率
@property (nonatomic, strong) NSMutableArray<LGRateModel *> *rateArray;


@end

//正确率
@interface LGRateModel : NSObject

@property (nonatomic, copy) NSString *levelName;
@property (nonatomic, copy) NSString *rate;

+ (LGRateModel *)initWithLevel:(NSString *)levelName rate:(NSString *)rate;

@end

