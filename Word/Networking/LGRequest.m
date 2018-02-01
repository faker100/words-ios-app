//
//  LGRequest.m
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGRequest.h"
#import "NSString+LGString.h"
#import "LGUserManager.h"

@implementation LGRequest


- (void)loginRequest:(NSString *)username password:(NSString *)password completion:(comletionBlock)completion{
	self.url = LOGIN_URL;
	self.parameter = @{
					   @"userName" : username,
					   @"userPass" : password
					   };
	[self postRequestCompletion:^(id response, LGError *error) {
		if (!error) {
			[self resetSessionRequest:response completion:^{
				completion(response,error);
			}];
		}
	}];
}

- (void)resetSessionRequest:(id) userInfo completion:(void (^)(void))completion{
	
	NSArray *urlArray = SESSION_URLS;
	dispatch_group_t requestGroup = dispatch_group_create();
	[urlArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		dispatch_group_enter(requestGroup);
		self.url = obj;
		self.parameter = userInfo;
		[self getRequestCompletion:^(id response, LGError *error) {
			dispatch_group_leave(requestGroup);
			NSLog(@"=====session:%@",response);
		}];
	}];
	dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
		
		[LGUserManager configCookie];
		if (completion) {
			completion();
		}
	});
}

- (void)requestCheckCodeSure{
	self.url = CHECK_CODE_SURE;
	[self postRequestCompletion:nil];
}

- (void)requestCheckCode:(NSString *)username usernameType:(LGUsernameType)usernameType useType:(LGCheckCodeUseType)useType completion:(comletionBlock)completion{
	self.parameter = (NSMutableDictionary *)self.parameter;
	[self.parameter setValue:@(useType) forKey:@"type"];
	if (usernameType == LGUsernamePhoneType) {
		self.url = GET_CHECK_CODE_PHONE;
		[self.parameter setValue:username forKey:@"phoneNum"];
	}else{
		self.url = GET_CHECK_CODE_EMAIL;
		[self.parameter setValue:username forKey:@"email"];
	}
	[self postRequestCompletion:completion];
}


- (void)registerRequest:(NSString *)username password:(NSString *)password code:(NSString *)code usernameType:(LGUsernameType)usernameType completion:(comletionBlock)completion {
	self.url = REGISTER_URL;
	self.parameter = @{
					   @"type" : @(usernameType),
					   @"registerStr" : username,
					   @"pass" : password,
					   @"code" : code,
					   @"userName" : username,
					   @"source" : @"5",
					   @"belong" : @"1"
					   };
	[self postRequestCompletion:completion];
}

- (void)findPasswordRequest:(NSString *)username password:(NSString *)password code:(NSString *)code usernameType:(LGUsernameType)usernameType completion:(comletionBlock)completion{
	self.url = FIND_PASSWORD_URL;
	self.parameter = @{
					   @"type":@(usernameType),
					   @"registerStr":username,
					   @"pass":password,
					   @"code":code
					   };
	[self postRequestCompletion:completion];
}


- (void)updateStudyType:(LGStudyType)type  completion:(comletionBlock)completion{
	self.url = UPDATE_STUDY_TYPE_URL;
	self.parameter = @{
					   @"status" : @(type)
					   };
	[self postRequestCompletion:completion];
}

- (void)requestUserInfo:(comletionBlock)completion{
	self.url = USER_INFO_URL;
	[self postRequestCompletion:completion];
}

- (void)requestUserPlan:(comletionBlock)completion{
	self.url = MY_PLAN_URL;
	[self postRequestCompletion:completion];
}

- (void)requestWordLibraryList:(comletionBlock)completion{
	self.url = WORD_LIBRARY_LIST_URL;
	[self postRequestCompletion:completion];
}

- (void)requestFreeLibraryWordList:(NSString *)catID page:(NSInteger)page completion:(comletionBlock)completion{
    self.url = FREE_LIBRARY_WORD_LIST_URL;
    self.parameter = @{
                       @"catId" : catID,
					   @"page"  : @(page)
                       };
    [self postRequestCompletion:completion];
}

@end
