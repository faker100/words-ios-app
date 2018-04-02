//
//  LGEstimateWordModel.h
//  Word
//
//  Created by Charles Cao on 2018/4/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGEstimateWordModel : NSObject

@property (nonatomic, copy) NSString *answer;
@property (nonatomic, copy) NSString *select;
@property (nonatomic, copy) NSString *uk_audio;
@property (nonatomic, copy) NSString *word;
@property (nonatomic, copy) NSString *wordsId;
@property (nonatomic, copy) NSString *phonetic_uk;

//自定义字段,以回车拆分 select字段
@property (nonatomic, copy) NSArray<NSString *> *selectArray;

//正确答案 idnex;
@property (nonatomic, assign) NSInteger trueAnswerIndex;

@end
