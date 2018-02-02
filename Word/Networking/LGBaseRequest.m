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
		
		[self dealRequestSuccessResponse:responseObject completion:completion];
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		[self dealRequestFailure:error completion:completion];
	}];
}

- (void)postRequestCompletion:(comletionBlock) completion {
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	self.task = [manager POST:self.url parameters:self.parameter progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
		
		[self dealRequestSuccessResponse:responseObject completion:completion];
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		
		[self dealRequestFailure:error completion:completion];
		
	}];
}

- (void)downloadRequest:(NSString *)url targetPath:(NSString *)path fileName:(NSString *)fileName completion:(downloadComletionBlock) completion{

	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

	NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
	
		NSLog(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
	
	} destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
	
		NSString *tempName = StringNotEmpty(fileName) ? fileName : response.suggestedFilename;
		NSString *tempPath = StringNotEmpty(path) ? path : NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
		
		return [NSURL fileURLWithPath:[tempPath stringByAppendingPathComponent:tempName]];
	
	} completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
		
		completion(filePath, [self getErrorWithCode:error.code]);
	
	}];
	
	[downloadTask resume];
}

/**
 处理请求成功返回的 object
 
 */
- (void)dealRequestSuccessResponse:(id)responseObject completion:(comletionBlock) completion{
	
#ifdef DEBUG
	NSLog(@"%@",responseObject);
#endif
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	if (completion) {
		
		NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
		
		if ([code isEqualToString:@"0"]) {
			
			NSString *message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
			completion(responseObject, [[LGError alloc]initWithMessage:message type:LGServiceError]);
			
		}else if ([code isEqualToString:@"99"]){
			
			//发出未登录通知
			NSString *message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
			[[NSNotificationCenter defaultCenter] postNotificationName:NO_LOGIN_NOTIFICATION object:nil userInfo:@{NO_LOGIN_ALERT_MESSAGE : message}];
			completion(responseObject,[[LGError alloc]initWithMessage:message type:LGServiceError]);
	
		}else{
			completion(responseObject, nil);
		}
	}
}

/**
 处理请求失败
 
 */
- (void)dealRequestFailure:(NSError *)error completion:(comletionBlock) completion{
	
#ifdef DEBUG
	NSLog(@"%@",error);
#endif
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	if (completion) {
		completion (nil,[self getErrorWithCode:error.code]);
	}
}

- (LGError *)getErrorWithCode:(NSInteger)code {

	NSString *errorMessage;
	
	if(code == -1001)       errorMessage = @"请求超时";
	else if(code == -1009)  errorMessage = @"无法连接到网络";
	else if(code == -1004)  errorMessage = @"连接服务器失败，请稍后重试";
	else if(code ==  3840)  errorMessage = @"服务器出错了!";
	
	return StringNotEmpty(errorMessage) ? [[LGError alloc]initWithMessage:errorMessage type:LGSystemError] : nil;
}


- (NSString *)url{
	if (_url) {
		_url = [_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
	}
	return _url;
	
}

@end

@implementation LGError

- (instancetype)initWithMessage:(NSString *)message type:(LGErrorType)type{
	self = [super init];
	if (self) {
		self.errorType = type;
		self.errorMessage = message;
	}
	return self;
}

@end

