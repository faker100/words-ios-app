//
//  LGReciteWordModel.h
//  Word
//
//  Created by caoguochi on 2018/2/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LGUserPackage;
@interface LGReciteWordModel : NSObject

@property (nonatomic, assign) NSInteger insistDay;    //坚持天数
@property (nonatomic, assign) NSInteger userPackageWords;
@property (nonatomic, strong) LGUserPackage *userPackage;
@property (nonatomic, strong) NSString *surplusDay;   //剩余天数
@property (nonatomic, strong) NSString *userAllWords; //累计背单词
@property (nonatomic, strong) NSString *todayWords;   //今天背单词
@property (nonatomic, strong) NSString *userReviewWords;     //已复习单词
@property (nonatomic, strong) NSString *userNeedReviewWords; //需要复习单词

@end

@interface LGUserPackage : NSObject


@property (nonatomic, strong) NSString *planDay;

@end
