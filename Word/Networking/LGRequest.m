//
//  LGRequest.m
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGRequest.h"
#import "NSString+LGString.h"

@implementation LGRequest


- (void)loginRequest:(NSString *)username password:(NSString *)password completion:(comletionBlock)completion{
	self.url = LOGIN_URL;
	self.parameter = @{
					   @"userName" : username,
					   @"userPass" : password
					   };
	[self postRequestCompletion:^(id response, NSString *errorMessage) {
		completion(response,errorMessage);
		if (!StringNotEmpty(errorMessage)) {
			[self resetSessionRequest:response completion:nil];
		}
	}];
}

- (void)resetSessionRequest:(id) userInfo completion:(comletionBlock)completion{
	NSArray *urlArray = SESSION_URLS;
	[urlArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		self.url = obj;
		self.parameter = userInfo;
		[self getRequestCompletion:^(id response, NSString *errorMessage) {
			NSLog(@"session:%@",response);
		}];
	}];
	
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

//NSMutableDictionary *requestDictionary = [@{@"type":[NSString stringWithFormat:@"%ld", requestMessageCodeStyle + 1]} mutableCopy];
//if ([HTValidateManager ht_validateMobile:phoneOrEmailString]) {
//	requestUrl = @"http://login.gmatonline.cn/cn/app-api/phone-code";
//	[requestDictionary setValue:HTPlaceholderString(phoneOrEmailString, @"") forKey:@"phoneNum"];
//} else if ([HTValidateManager ht_validateEmail:phoneOrEmailString]) {
//	requestUrl = @"http://login.gmatonline.cn/cn/app-api/send-mail";
//	[requestDictionary setValue:HTPlaceholderString(phoneOrEmailString, @"") forKey:@"email"];

@end
