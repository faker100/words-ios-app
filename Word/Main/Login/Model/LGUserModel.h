//
//  LGUserModel.h
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGUserModel : NSObject

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, assign) LGStudyType  studyModel; //用户学习模式;
@property (nonatomic, copy) NSString *planWords; //判断用户当前词包是否有计划; nil 没有计划
@property (nonatomic, assign) BOOL isReview; //是否已经看过首页今日复习弹框

@end
