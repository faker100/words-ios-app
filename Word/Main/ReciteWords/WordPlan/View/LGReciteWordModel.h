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

@property (nonatomic, copy) NSString *packageName;		 //词包名字
@property (nonatomic, copy) NSString *insistDay;    		 //坚持天数
@property (nonatomic, copy) NSString *userPackageWords;    //当前词包已背单词
@property (nonatomic, strong) LGUserPackage *userPackage;
@property (nonatomic, copy) NSString *allWords;			 //当前词包所有单词
@property (nonatomic, copy) NSString *surplusDay;   		 //剩余天数
@property (nonatomic, copy) NSString *userAllWords; 		 //累计背单词
@property (nonatomic, copy) NSString *todayWords;   		 //今天已背单词
@property (nonatomic, copy) NSString *userReviewWords;     //已复习单词
@property (nonatomic, copy) NSString *userNeedReviewWords; //需要复习单词

@end

@interface LGUserPackage : NSObject

@property (nonatomic, copy) NSString *planWords;   //今天需背单词

@end
