//
//  LGBaseRequest.m
//  Word
//
//  Created by Charles Cao on 2018/1/18.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGBaseRequest.h"
#import <AFNetworking/AFNetworking.h>

static AFHTTPSessionManager *manager;

@implementation LGBaseRequest

- (instancetype)init{
	self = [super init];
	if (self) {
		static dispatch_once_t onceToken;
		dispatch_once(&onceToken, ^{
			manager = [AFHTTPSessionManager manager];
		});
		self.parameter = [NSMutableDictionary dictionary];
	}
	return self;
}

- (void)getRequestCompletion:(completion) completion{
	
	self.task = [manager GET:self.url parameters:self.parameter progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		completion(responseObject, nil);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		completion (nil,[self getErrorMessageWithErrorCode:error.code]);
	}];
}

- (void)postRequestCompletion:(completion) completion{
	
	self.task = [manager POST:self.url parameters:self.parameter progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		completion(responseObject, nil);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		completion (nil,[self getErrorMessageWithErrorCode:error.code]);
	}];
}

- (LGError *)getErrorMessageWithErrorCode:(NSInteger)code {
	LGError *error = [LGError new];
	if(code == -1001)  error.errorMessage =  @"请求超时";
	if(code == -1009)  error.errorMessage = @"无法连接到网络";
	if(code == -1004)  error.errorMessage = @"连接服务器失败，请稍后重试";
	return error;
}


@end


@implementation LGError

@end
