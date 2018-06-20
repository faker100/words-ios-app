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
#define IS_FISRT		@"IS_FISRT"
#define notLogged		@"notLogged"


NSString *const LGIndexSoundFlag	      = @"LGIndexSoundFlag";
NSString *const LGWordDetailSoundFlag     = @"LGWordDetailSoundFlag";
NSString *const LGWordEstimateSoundFlag   = @"LGWordEstimateSoundFlag";
NSString *const LGPkResultSoundFlag       = @"LGPkResultSoundFlag";
NSString *const LGPkBackGroundSoundFlag   = @"LGPkBackGroundSoundFlag";
NSString *const LGAutoplayWordFlag 		  = @"LGAutoplayWordFlag";


@interface LGUserManager : NSObject

@property (nonatomic, strong) LGUserModel *user;
@property (nonatomic, assign) BOOL isFirstLaunch; //第一次是否启动,显示引导页

/**
 首页音效音效
 */
@property (nonatomic, assign) BOOL indexSoundFlag;

/**
 单词详情音效,与单词详情静音开关相反
 */
@property (nonatomic, assign) BOOL wordDetailSoundFlag;

/**
 单词评估音效
 */
@property (nonatomic, assign) BOOL wordEstimateSoundFlag;

/**
 pk 结果页音效
 */
@property (nonatomic, assign) BOOL pkResultSoundFlag;

/**
 pk 背景音效
 */
@property (nonatomic, assign) BOOL pkBackGroundSoundFlag;


/**
 自动播放单词读音 
 */
@property (nonatomic, assign) BOOL autoplayWordFlag;

/**
 引导页过后选的的学习模式...登录后检测并上传,上传完后,设置为LGStudyNone
 */
@property (nonatomic, assign) LGStudyType notLoggedStudyType;

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
