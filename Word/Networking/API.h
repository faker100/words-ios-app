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
	LGCheckCodeUseTypeReplacePassword = 3
};

//用户名类型
typedef NS_ENUM(NSInteger, LGUsernameType) {
	LGUsernamePhoneType = 1,
	LGUsernameEmailType = 2,
	
};

//单词状态
typedef NS_ENUM(NSUInteger, LGWordStatus) {
	LGWordStatusNone,           //没背
	LGWordStatusFamiliar,       //熟识
	LGWordStatusKnow,     	    //认识
	LGWordStatusIncognizance,   //不认识
	LGWordStatusVague,			//模糊
};

//学习模式
typedef NS_ENUM(NSUInteger, LGStudyType) {
	LGStudyNone = 0,			//没有学习模式
	LGStudyEbbinghaus = 1, 		//艾宾浩斯记忆法
	LGStudyReview = 2,			//复习记忆法
	LGStudyOnlyNew = 3, 		//只背新单词
};


/*************************************** 各种 key **********************************/

// code = 99 未登录通知
#define NO_LOGIN_NOTIFICATION 	@"not_logged"

#define LOGIN_NOTIFICATION      @"login_success"

//未登录时提示语
#define NO_LOGIN_ALERT_MESSAGE  @"noLoginMessage"

/*************************************** 域名 **********************************/


#define WORD_DOMAIN(url) 	 [NSString stringWithFormat:@"http://words.viplgw.cn/%@",url]


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

//艾宾浩斯记忆单词
#define EBBINGHAUS_REVIEW_WORD_URL		@"http://words.viplgw.cn/cn/app-api/get-words-details"

//单词纠错
#define WORD_ERROR_URL					@"http://words.viplgw.cn/cn/app-api/error-recovery"
