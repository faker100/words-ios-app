//
//  LGUserModel.h
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGUserModel : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, assign) LGStudyType  studyModel; //用户学习模式;
@property (nonatomic, strong) NSString *planWords; //判断用户当前词包是否有计划; nil 没有计划

@end
