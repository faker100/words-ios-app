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

@class LGPlanModel;
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


/**
 音频文件下载
 先找本地文件,如果没有,再请求服务器
 @param url 下载地址
 */
- (void)downloadAudioFile:(NSString *)url completion:(downloadComletionBlock)completion;


/**
 添加词包

 @param libraryId 词包 id
 */
- (void)addWordLibrary:(NSString *)libraryId completion:(comletionBlock)completion;



/**
 删除词包

 @param libraryId 词包 id
 */
- (void)deleteWordLibrary:(NSString *)libraryId completion:(comletionBlock)completion;



/**
 修改词包计划

 @param libraryArray 需要修改的词包
 */
- (void)uploadWordLibraryArray:(NSArray<LGPlanModel *> *)libraryArray completion:(comletionBlock)completion;


/**
 首页单词计划

 */
- (void)requestIndexRecitePlan:(comletionBlock)completion;


/**
 背单词 (单词详情)

 */
- (void)requestReciteWordsCompletion:(comletionBlock)completion;


/**
 修改单词状态

 @param wordId 单词 id
 @param status 单词状态
 */
- (void)updateWordStatus:(NSString *)wordId status:(LGWordStatus)status completion:(comletionBlock)completion;


/**
 请求艾宾浩斯复习单词列表
 */
- (void)requestEbbinghausReviewList:(comletionBlock)completion;


/**
 请求艾宾浩斯复习单词
 @param wordID 单词 id
 */
- (void)requestEbbinghausReviewWord:(NSString *)wordID completion:(comletionBlock)completion;


/**
 提交单词纠错

 @param type 错误类型:1-单词拼写错误, 2-格式有错误, 3-翻译错误, 4-其他
 @param content 纠错信息
 @param wordId 单词 id
 */
- (void)submitWordErrorWithType:(NSUInteger)type content:(NSString *)content wordId:(NSString *)wordId completion:(comletionBlock)completion;



/**
 每日复习
 */
- (void)requestEveryDayReviewCompletion:(comletionBlock)completion;




@end
