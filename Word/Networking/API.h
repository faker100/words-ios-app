//
//  API.h
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#ifndef API_h
#define API_h


#endif /* API_h */

/************************************* 枚举 ****************************/

//获取验证码用途
typedef NS_ENUM(NSInteger, LGCheckCodeUseType) {
	LGCheckCodeUseTypeRegister = 1,
	LGCheckCodeUseTypeForgetPassword = 2,
	LGCheckCodeUseTypeChangeUser = 3
};

//用户名类型
typedef NS_ENUM(NSInteger, LGUsernameType) {
	LGUsernamePhoneType = 1,
	LGUsernameEmailType = 2,
	
};

//单词状态
typedef NS_ENUM(NSUInteger, LGWordStatus) {
	LGWordStatusNone = 0,           //没背 / 复习模块中 0 表示全部
	LGWordStatusFamiliar = 1,       //熟识
	LGWordStatusKnow = 2,     	    //认识
	LGWordStatusIncognizance = 3,   //不认识
	LGWordStatusVague = 4,			//模糊
	LGWordStatusForget = 5          //忘记
};

//学习模式
typedef NS_ENUM(NSUInteger, LGStudyType) {
	LGStudyNone = 0,			//没有学习模式
	LGStudyEbbinghaus = 1, 		//艾宾浩斯记忆法
	LGStudyReview = 2,			//复习记忆法
	LGStudyOnlyNew = 3, 		//只背新单词
};

//复习类型
typedef NS_ENUM(NSUInteger, LGSelectReviewType) {
    LGSelectReviewChinese_English,   //中英
    LGSelectReviewEnglish_Chinese,   //英中
    LGSelectReviewDictation          //听写
};

//同意/取消 pk
typedef NS_ENUM(NSUInteger, LGPKChoice) {
	LGPKChoiceAgree = 1,  //同意 pk
	LGPKChoiceCancel = 2  //取消 pk
	
};


/**
 pk,评估 用户答案对错
 */
typedef NS_ENUM(NSUInteger, LGAnswerType) {
	LGAnswerFalse = 0, //错误
	LGAnswerTrue = 1, //正确
	
	
};

/*************************************** 各种 key **********************************/

// code = 99 未登录通知
#define SHOW_LOGIN_NOTIFICATION 	@"not_logged"

#define LOGIN_NOTIFICATION      @"login_success"

//未登录时提示语
#define NO_LOGIN_ALERT_MESSAGE  @"noLoginMessage"

/*************************************** 域名 **********************************/


#define WORD_DOMAIN(url) 	 [NSString stringWithFormat:@"http://words.viplgw.cn/%@",url]
#define GMAT_DOMAIN(url)     [NSString stringWithFormat:@"http://www.gmatonline.cn/%@",url]

/*************************************** 接口 **********************************/

//登录
#define LOGIN_URL						 @"http://login.gmatonline.cn/cn/app-api/check-login"


//获取 session
#define SESSION_URLS      				 @[@"http://www.toeflonline.cn/cn/app-api/unify-login",@"http://www.smartapply.cn/cn/app-api/unify-login",@"http://www.gmatonline.cn/index.php?web/appapi/unifyLogin",@"http://bbs.viplgw.cn/cn/app-api/unify-login",@"http://words.viplgw.cn/cn/app-api/unify-login"]

//获取验证码前先跟服务器确认
#define CHECK_CODE_SURE					@"http://login.gmatonline.cn/cn/app-api/phone-request"

//通过手机获取验证码
#define GET_CHECK_CODE_PHONE			@"http://login.gmatonline.cn/cn/app-api/phone-code"

//通过 email 获取验证码
#define GET_CHECK_CODE_EMAIL			@"http://login.gmatonline.cn/cn/app-api/send-mail"

//注册
#define REGISTER_URL					@"http://login.gmatonline.cn/cn/app-api/register"

//找回密码
#define FIND_PASSWORD_URL				@"http://login.gmatonline.cn/cn/app-api/find-pass"

//修改用户邮箱，密码，手机
#define UPDATE_USER_URL                 @"http://login.gmatonline.cn/cn/app-api/update-user"

//上传头像
#define UPDATE_HEAD_IMG_URL             @"http://words.viplgw.cn/cn/app-api/app-image"

//更改昵称
#define UPDATE_NICKNAME_URL				@"http://login.gmatonline.cn/cn/app-api/change-nickname"

//更改学习模式
#define UPDATE_STUDY_TYPE_URL			@"http://words.viplgw.cn/cn/app-api/update-model"

//用户资料
#define USER_INFO_URL					@"http://words.viplgw.cn/cn/app-api/user-info"

//我的计划
#define MY_PLAN_URL						@"http://words.viplgw.cn/cn/app-api/user-package"

//词包列表
#define WORD_LIBRARY_LIST_URL			@"http://words.viplgw.cn/cn/app-api/package-list"

//免费词包详情-单词列表
#define FREE_LIBRARY_WORD_LIST_URL      @"http://words.viplgw.cn/cn/app-api/package-details"

//添加词包
#define ADD_WORD_LIBRARY_URL			@"http://words.viplgw.cn/cn/app-api/add-package"

//删除词包
#define DELETE_WORD_LIBRARY_URL			@"http://words.viplgw.cn/cn/app-api/delete-package"

//修改词包计划
#define UPLOAD_WORD_LIBRARY_URL			@"http://words.viplgw.cn/cn/app-api/update-package"

//首页单词记忆计划
#define INDEX_RECITE_PLAN_URL           @"http://words.viplgw.cn/cn/app-api/index"

//记单词
#define WORD_DETAIL_URL					@"http://words.viplgw.cn/cn/app-api/recite-words"

//修改单词状态
#define UPDATE_WORD_STATUS_URL   	    @"http://words.viplgw.cn/cn/app-api/update-status"

//艾宾浩斯记忆列表
#define EBBINGHAUS_REVIEW_LIST_URL      @"http://words.viplgw.cn/cn/app-api/is-review"

//获取单词详情
#define GET_WORD_DETAILS_URL	    	@"http://words.viplgw.cn/cn/app-api/get-words-details"

//单词纠错
#define WORD_ERROR_URL					@"http://words.viplgw.cn/cn/app-api/error-recovery"

//每日复习弹框
#define EVERY_DAY_REVIEW_URL			@"http://words.viplgw.cn/cn/app-api/review-case"

//复习弹框获取单词
#define ALERT_REVIEW_WORD_URL			@"http://words.viplgw.cn/cn/app-api/review-case-words"

//今日是否选择复习
#define UPDATE_IS_REVIEW_URL			@"http://words.viplgw.cn/cn/app-api/update-is-review"

//获取今日复习单词
#define REVIEW_TODAY_URL				@"http://words.viplgw.cn/cn/app-api/review-case-words"

//修改复习模式单词状态
#define UPDATE_REVIEW_WORD_STATUS_URL	@"http://words.viplgw.cn/cn/app-api/review-update"

//复习首页
#define REVIEW_INDEX_URL			    @"http://words.viplgw.cn/cn/app-api/review-index"

//复习错题本列表
#define REVIEW_WRONG_WORDS_LIST_URL	    @"http://words.viplgw.cn/cn/app-api/wrong-index"

//获取错题本单词
#define GET_WROING_WORDS_URL            @"http://words.viplgw.cn/cn/app-api/wrong-words"

//根据复习时间获取单词
#define REIVEW_TIME_URL					@"http://words.viplgw.cn/cn/app-api/time-select"

//听写练习首页
#define DICTATION_INDEX_URL				@"http://words.viplgw.cn/cn/app-api/dictation-index"

//听写练习
#define DICTATION_PRACTISE_URL			@"http://words.viplgw.cn/cn/app-api/dictation-words"

//pk首页排名
#define PK_INDEX_RANK_URL				@"http://words.viplgw.cn/cn/app-api/pk-index"

//pk匹配
#define PK_MATCHING_URL					@"http://words.viplgw.cn/cn/app-api/pk-matching"

//同意/取消 pk
#define PK_CHOICE_URL					@"http://words.viplgw.cn/cn/app-api/pk-choice"

//pk 答案
#define PK_ANSWER_URL					@"http://words.viplgw.cn/cn/app-api/pk-answer"

//pk 时候 app 退后台
#define PK_BACKGROUND_URL				@"http://words.viplgw.cn/cn/app-api/user-exit"

//pk 时 激活 app 重新连接 pk
#define PK_CONNECT_URL			        @"http://words.viplgw.cn/cn/app-api/pk-connect"

//pk 完成
#define PK_FINISH_URL					@"http://words.viplgw.cn/cn/app-api/pk-finish"

//pk 结果
#define PK_RESULT_URL					@"http://words.viplgw.cn/cn/app-api/pk-result"

//pk 轮询请求
#define PK_POLL_URL						@"http://words.viplgw.cn/cn/app-api/pk-poll"

//背单词轨迹
#define PK_TACK_URL						@"http://words.viplgw.cn/cn/app-api/track"

//开始评估
#define BEGIN_ESTIMATE_URL              @"http://words.viplgw.cn/cn/app-api/ev-start"

//评估单词
#define ESTIMATE_WORD_URL               @"http://words.viplgw.cn/cn/app-api/ev-words"

//提交评估答案
#define SUBMIT_ESTIMATE_ANSWER_URL		@"http://words.viplgw.cn/cn/app-api/ev-answer"

