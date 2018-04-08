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
 上传头像
 
 @param headImage 头像
 */
- (void)uploadHeaderImage:(UIImage *)headImage completion:(comletionBlock)completion;

/**
 修改手机号
 
 @param phone 新手机号
 @param code 验证码
 */
- (void)updatePhone:(NSString *)phone code:(NSString *)code completion:(comletionBlock)completion;


/**
 修改邮箱
 
 @param emial 新邮箱
 @param code 验证码
 */
- (void)updateEmail:(NSString *)emial code:(NSString *)code completion:(comletionBlock)completion;


/**
 修改密码
 
 @param oldPassword 旧密码
 @param newPassword 新密码
 */
- (void)updatePassword:(NSString *)oldPassword newPassword:(NSString *)newPassword completion:(comletionBlock)completion;


/**
 修改昵称

 @param nickname 昵称
 */
- (void)updateNickname:(NSString *)nickname completion:(comletionBlock)completion;

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
 通过单词id请求单词详情
 @param wordID 单词 id
 */
- (void)requestWordDetailWidthID:(NSString *)wordID completion:(comletionBlock)completion;


/**
 提交单词纠错

 @param type 错误类型:1-单词拼写错误, 2-格式有错误, 3-翻译错误, 4-其他
 @param content 纠错信息
 @param wordId 单词 id
 */
- (void)submitWordErrorWithType:(NSUInteger)type content:(NSString *)content wordId:(NSString *)wordId completion:(comletionBlock)completion;



/**
 每日复习弹框
 */
- (void)requestEveryDayReviewCompletion:(comletionBlock)completion;


/**
 点击每日复习弹框
 */
- (void)updateEveryDayReviewCompletion:(comletionBlock)completion;


/**
 获取今日复习单词
 @param status 选择复习单词类型
 */
- (void)requestTodayReviewWordsWithStatus:(LGWordStatus)status completion:(comletionBlock)completion;

/**
 复习模式下修改单词状态

 @param status 单词状态
 @param wordId 单词 id
 */
- (void)updateReviewWordStatus:(LGWordStatus)status wordId:(NSString *)wordId completion:(comletionBlock)completion;


/**
 请求复习页面

 */
- (void)requestReviewIndexCompletion:(comletionBlock)completion;


/**
 请求错题本
 */
- (void)requestRevieWrongWordListCompletion:(comletionBlock)completion;


/**
 错题本复习单词id

 @param start 起始位置
 */
- (void)requestReviewWrongWordsWithStart:(NSString *)start Completion:(comletionBlock)completion;


/**
 根据时间段复习单词

 @param startTime 开始时间
 @param endTime 结束时间
 */
- (void)requestRevieWordWithStartTime:(NSString *)startTime endTime:(NSString *)endTime Completion:(comletionBlock)completion;

/**
 听写练习首页
 */
- (void)requestDicationIndexCompletion:(comletionBlock)completion;



/**
 听写练习 - 复习某状态下的单词

 @param status 要复习的状态
 */
- (void)requestDictationWordsWithStatus:(LGWordStatus) status completion:(comletionBlock)completion;


/**
 PK首页排行

 */
- (void)requestPKRankCompletion:(comletionBlock)completion;


/**
 PK匹配
 
 */
- (void)requestPkMatchingCompletion:(comletionBlock)completion;

/**
 同意/取消 pk

 @param choice 同意/取消 LGPKChoice
 @param uid 对手 id

 */
- (void)requestPkChoice:(LGPKChoice)choice opponentUid:(NSString *)uid completion:(comletionBlock)completion;

/**
 PK 上传用户答案

 @param type 正确
 @param totalId 匹配时给的 totalid
 @param wordId 单词 id
 @param answer 选择答案
 @param duration 答题用时
 */
- (void)commitPKAnswer:(LGAnswerType)type totalId:(NSString *)totalId wordId:(NSString *)wordId answer:(NSString *)answer duration:(NSInteger)duration completion:(comletionBlock)completion;


/**
 PK时 app 退到后台

 @param uid 当前用户 id
 @param totalId 匹配时给的 totalid
 @param num 当前第几题,从 1 开始
 @param time 当前题目用的时长
 */
- (void)requestPKExit:(NSString *)uid totalId:(NSString *)totalId currentQuestionIndex:(NSInteger)num duration:(NSInteger)time;


/**
 PK 重连

 @param uid 当前用户 id
 @param totalId 匹配时给的 totalid
 */
- (void)requestPKConnect:(NSString *)uid totalId:(NSString *)totalId completion:(comletionBlock)completion;


/**
 PK 完成

 @param opponentUid 对手 id
 @param totalId 匹配时给的 totalid
 */
- (void)requestPKFinish:(NSString *)opponentUid totalId:(NSString *)totalId completion:(comletionBlock)completion;


/**
 PK 结果

 @param opponentUid  对手 id
 @param totalId 匹配时给的 totalid
 */
- (void)requestPKResult:(NSString *)opponentUid totalId:(NSString *)totalId completion:(comletionBlock)completion;


/**
 PK 轮循

 @param opponentUid 对手 id
 @param totalId 匹配时给的 totalid
 */
- (void)requestPKPoll:(NSString *)opponentUid totalId:(NSString *)totalId completion:(comletionBlock)completion;



/**
 PK 发现

 @param page 页数
 */
- (void)requestPKDiscoverWithPage:(NSInteger)page completion:(comletionBlock)completion;

/**
 背单词轨迹
 */
- (void)reqeustTrackCompletion:(comletionBlock)completion;



/**
 开始评估

 */
- (void)requestBeginEstimateCompletion:(comletionBlock)comletion;


/**
 评估单词

 */
- (void)reqeustEstimateWordsCompletion:(comletionBlock)completion;


/**
 提交评估答案

 @param answer 用户选择答案
 @param type 对错
 @param wordId 单词 id
 @param duration 持续做题时间
 @param isKnow 是否认识
 */
- (void)submitEstimateAnswer:(NSString *)answer type:(LGAnswerType)type wordId:(NSString *)wordId duration:(NSInteger)duration isKnow:(BOOL)isKnow completion:(comletionBlock)completion;


/**
 评估排名列表

 @param page 页数
 @param pageSize pageSize
 */
- (void)requestRankList:(NSString *)page pageSize:(NSString *)pageSize completion:(comletionBlock)completion;

/**
 评估结果
 
 */
- (void)requestEstimateResultCompletion:(comletionBlock)completion;


/**
 月报告

 */
- (void)requestReportCompletion:(comletionBlock)completion;

/**
 月报告切换

 @param month 月份 格式 xxxx-xx-01

 */
- (void)requestChangeMonthReport:(NSString *)month completion:(comletionBlock)completion;

/**
 周边

 */
- (void)requestRimCompletion:(comletionBlock)completion;


/**
 课程列表

 @param type 课程类型
 */
- (void)requestCourseListWithType:(LGCourseType)type completion:(comletionBlock)completion;



/**
 公开课列表

 @param page 页数
 */
- (void)requestPublickListWithPage:(NSInteger)page completion:(comletionBlock)completion;






@end
