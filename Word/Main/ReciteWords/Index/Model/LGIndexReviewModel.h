//
//  LGIndexReviewModel.h
//  Word
//
//  Created by Charles Cao on 2018/2/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LGReviewSubModel;
@interface LGIndexReviewModel : NSObject

@property (nonatomic, copy) NSString *currentWordLibName; //当前词包名字

@property (nonatomic, copy) NSString *all;
@property (nonatomic, copy) NSString *dim;
@property (nonatomic, copy) NSString *incognizant;
@property (nonatomic, copy) NSString *know;

//去掉为0的数据
@property (nonatomic, strong) NSMutableArray<LGReviewSubModel *> *dataSourceArray;


@end

@interface LGReviewSubModel : NSObject

@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *descriptionStr;

@end

