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
	LGCheckCodeUseTypeForgetPassword,
	LGCheckCodeUseTypeReplacePassword
};

//用户名类型
typedef NS_ENUM(NSInteger, LGUsernameType) {
	LGUsernamePhoneType = 1,
	LGUsernameEmailType,
	
};

/*************************************** 域名 **********************************/



/*************************************** 接口 **********************************/


/***********************登录***************/

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




