//
//  LGRequest.m
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGRequest.h"
#import "API.h"

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

@end
