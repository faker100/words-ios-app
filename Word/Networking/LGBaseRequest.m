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
			manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
																 @"application/json",
																 @"text/json",
																 @"text/javascript",
																 @"text/html",
																 @"text/plain",
																 nil];
		});
		
		self.parameter = [NSMutableDictionary dictionary];
	}
	return self;
}

- (void)getRequestCompletion:(comletionBlock) completion{
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	self.task = [manager GET:self.url parameters:self.parameter progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		
		if ( (NSInteger)responseObject[@"code"] == 0) {
			NSString *message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
			completion(responseObject, message);
			
		}else{
			completion(responseObject, nil);
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		completion (nil,[self getSystemErrorMessage:error.code]);
	}];
}

- (void)postRequestCompletion:(comletionBlock) completion {
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	self.task = [manager POST:self.url parameters:self.parameter progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		
		if ( (NSInteger)responseObject[@"code"] == 0) {
			NSString *message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
			completion(responseObject, message);
		}else{
			completion(responseObject, nil);
		}
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		completion (nil,[self getSystemErrorMessage:error.code]);
	}];
}

- (NSString *)getSystemErrorMessage:(NSInteger)code {
	
	if(code == -1001)  return  @"请求超时";
	if(code == -1009)  return @"无法连接到网络";
	if(code == -1004)  return @"连接服务器失败，请稍后重试";
	return nil;
}

- (NSString *)url{
	if (_url) {
		_url = [_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
	}
	return _url;
	
}

@end
