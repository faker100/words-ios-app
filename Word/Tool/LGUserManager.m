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

+ (id)shareManager{
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

- (BOOL)isLogin{
	
	return self.user && StringNotEmpty(self.user.uid);
}


@end
