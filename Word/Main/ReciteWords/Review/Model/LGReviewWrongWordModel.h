//
//  LGReviewWrongWordModel.h
//  Word
//
//  Created by Charles Cao on 2018/3/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

//复习进度
typedef NS_ENUM(NSUInteger, LGReviewProgress) {
	LGReviewProgressNotBegin = 1, //未开始
	LGReviewProgressFinish,  //完成
	LGReviewProgressSuspend,  //中断
};

@interface LGReviewWrongWordModel : NSObject

@property (nonatomic, copy) NSString *end;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *start;
@property (nonatomic, assign) LGReviewProgress type; //复习进度

@end
