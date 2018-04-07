//
//  LGUserManager.h
//  Word
//
//  Created by Charles Cao on 2018/1/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGUserModel.h"
#import "LGClockModel.h"

#define UserDefaultKey  @"userKey"


@interface LGUserManager : NSObject

@property (nonatomic, strong) LGUserModel *user;



+ (instancetype)shareManager;

//设置 cookie
+ (void)configCookie;

//清除 cookie
+ (void)cleanCookie;

//是否登录
- (BOOL)isLogin;

//退出登录
- (void)logout;

/**
 上一个用户的电话,用于登录界面的默认值
 
 */
+ (NSString *)previousPhone;

/**
 上一个用户的邮箱,用于登录界面的默认值
 
 */
+ (NSString *)previousEmail;

/**
 上一个用户的手机,用于登录界面的默认值
 
 */
+ (NSString *)previousPassword;


@end
