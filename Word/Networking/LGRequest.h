//
//  LGRequest.h
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGBaseRequest.h"
#import "API.h"


@interface LGRequest : LGBaseRequest


/**
 登录
 
 */
- (void)loginRequest:(NSString *)username password:(NSString *)password completion:(comletionBlock)completion;

/**
 重置 session

 @param userInfo 用户信息,userModel 的 NSDictionary
 
 */
- (void)resetSessionRequest:(id) userInfo completion:(void(^)(void)) completion;

/**
 获取验证码前,先确认,否则获取验证码失败
 */
- (void)requestCheckCodeSure;



/**
 获取验证码

 @param username 用户名
 @param usernameType 电话/邮箱
 @param useType 用途
 */
- (void)requestCheckCode:(NSString *)username usernameType:(LGUsernameType)usernameType useType:(LGCheckCodeUseType)useType completion:(comletionBlock)completion;


/**
 注册

 @param username 用户名
 @param password 密码
 @param code 验证码
 @param usernameType 用户名类型
 */
- (void)registerRequest:(NSString *)username password:(NSString *)password code:(NSString *)code usernameType:(LGUsernameType)usernameType completion:(comletionBlock)completion;


/**
 找回密码

 @param username 用户名
 @param password 密码
 @param code 验证码
 @param usernameType 用户名类型
 */
- (void)findPasswordRequest:(NSString *)username password:(NSString *)password code:(NSString *)code usernameType:(LGUsernameType)usernameType completion:(comletionBlock)completion;


/**
 更改学习模式

 @param type 学习模式
 */
- (void)updateStudyType:(LGStudyType)type completion:(comletionBlock)completion;

/**
 请求用户资料

 */
- (void)requestUserInfo:(comletionBlock)completion;


/**
 请求用户词包计划

 */
- (void)requestUserPlan:(comletionBlock)completion;


/**
 请求词包列表
 
 */
- (void)requestWordLibraryList:(comletionBlock)completion;


/**
 获取免费词包单词列表

 @param catID 词包id
 @param page 页数
 */
- (void)requestFreeLibraryWordList:(NSString *)catID page:(NSInteger)page completion:(comletionBlock)completion;


@end
