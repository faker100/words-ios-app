//
//  LGUserManager.m
//  Word
//
//  Created by Charles Cao on 2018/1/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGUserManager.h"

@implementation LGUserManager
@synthesize user = _user;

+ (instancetype)shareManager{
	static LGUserManager *mannager;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		mannager = [[LGUserManager alloc]init];
	});
	return mannager;
}

- (LGUserModel *)user{
	
	if (!_user) {
		NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultKey];
		_user = dic ? [LGUserModel mj_objectWithKeyValues:dic] : nil;
	}
	return _user;
}


- (void)setUser:(LGUserModel *)user{
	
	_user = user;
	if (user) {
		[[NSUserDefaults standardUserDefaults] setObject:[user mj_keyValues] forKey:UserDefaultKey];
	}else{
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:UserDefaultKey];
	}
}

- (void)setNotLoggedStudyType:(LGStudyType)notLoggedStudyType{
	[[NSUserDefaults standardUserDefaults]setInteger:notLoggedStudyType forKey:notLogged];
}

- (LGStudyType)notLoggedStudyType{ 
	return [[NSUserDefaults standardUserDefaults] integerForKey:notLogged];
}

- (BOOL)isLogin{
	return self.user && StringNotEmpty(self.user.uid);
}

- (void)logout{
	
	[LGUserManager cleanCookie];
	self.user = nil;
}

+ (void)configCookie {
	
	NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	[cookieStorage.cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull cookie, NSUInteger idx, BOOL * _Nonnull stop) {
		NSMutableDictionary *properties = [[cookie properties] mutableCopy];
		//将cookie过期时间设置为一年后
		NSDate *expiresDate = [NSDate dateWithTimeIntervalSinceNow:3600*24*30*12];
		properties[NSHTTPCookieExpires] = expiresDate;
		//删除Cookies的discard字段，应用退出，会话结束的时候继续保留Cookies
		[properties removeObjectForKey:NSHTTPCookieDiscard];
		//重新设置改动后的Cookies
		[cookieStorage setCookie:[NSHTTPCookie cookieWithProperties:properties]];
	}];
}

+ (void)cleanCookie {
	NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	[cookieStorage.cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			[cookieStorage deleteCookie:obj];
	}];
}

+ (NSString *)previousPhone{
	return [[NSUserDefaults standardUserDefaults] objectForKey:PHONE_KEY];
}

+ (NSString *)previousEmail{
	return [[NSUserDefaults standardUserDefaults] objectForKey:EMAIL_KEY];
}

+ (NSString *)previousPassword{
	return [[NSUserDefaults standardUserDefaults] objectForKey:PASSWORD_KEY];
}

- (BOOL)isFirstLaunch{
	return  ![[NSUserDefaults standardUserDefaults] boolForKey:IS_FISRT];
}

- (void)setIsFirstLaunch:(BOOL)isFirstLaunch{
	[[NSUserDefaults standardUserDefaults] setBool:isFirstLaunch forKey:IS_FISRT];
}


- (BOOL)indexSoundFlag{
	return [[NSUserDefaults standardUserDefaults] boolForKey:LGIndexSoundFlag];
}

- (void)setIndexSoundFlag:(BOOL)indexSoundFlag{
	[[NSUserDefaults standardUserDefaults] setBool:indexSoundFlag forKey:LGIndexSoundFlag];
}

- (BOOL)wordDetailSoundFlag{
	return [[NSUserDefaults standardUserDefaults] boolForKey:LGWordDetailSoundFlag];
}

- (void)setWordDetailSoundFlag:(BOOL)wordDetailSoundFlag{
	[[NSUserDefaults standardUserDefaults] setBool:wordDetailSoundFlag forKey:LGWordDetailSoundFlag];
}

- (BOOL)wordEstimateSoundFlag{
	return [[NSUserDefaults standardUserDefaults] boolForKey:LGWordEstimateSoundFlag];
}

- (void)setWordEstimateSoundFlag:(BOOL)wordEstimateSoundFlag{
	[[NSUserDefaults standardUserDefaults]setBool:wordEstimateSoundFlag forKey:LGWordEstimateSoundFlag];
}

- (BOOL)pkResultSoundFlag{
	return [[NSUserDefaults standardUserDefaults] boolForKey:LGPkResultSoundFlag];
}

- (void)setPkResultSoundFlag:(BOOL)pkResultSoundFlag{
	[[NSUserDefaults standardUserDefaults] setBool:pkResultSoundFlag forKey:LGPkResultSoundFlag];
}

- (void)setPkBackGroundSoundFlag:(BOOL)pkBackGroundSoundFlag{
	[[NSUserDefaults standardUserDefaults] setBool:pkBackGroundSoundFlag forKey:LGPkBackGroundSoundFlag];
}

- (BOOL)pkBackGroundSoundFlag{
	return [[NSUserDefaults standardUserDefaults] boolForKey:LGPkBackGroundSoundFlag];
}

- (void)setAutoplayWordFlag:(BOOL)autoplayWordFlag{
	[[NSUserDefaults standardUserDefaults] setBool:autoplayWordFlag forKey:LGAutoplayWordFlag];
}

- (BOOL)autoplayWordFlag{
	return [[NSUserDefaults standardUserDefaults]boolForKey:LGAutoplayWordFlag];
}

@end
