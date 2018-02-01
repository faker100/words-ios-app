//
//  LGBaseRequest.h
//  Word
//
//  Created by Charles Cao on 2018/1/18.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LGErrorType) {
	LGSystemError,		//网络请求错误
	LGServiceError,     //服务器提示错误
};

@interface LGError : NSObject

@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, assign) LGErrorType errorType;

- (instancetype)initWithMessage:(NSString *)message type:(LGErrorType)type;

@end

typedef void(^comletionBlock)(id response, LGError *error);
typedef void(^downloadComletionBlock)(id response, NSURL *filePath, LGError *error);

@interface LGBaseRequest : NSObject

@property (nonatomic, strong) NSURLSessionTask *task;    
@property (nonatomic, strong) NSDictionary *parameter;   //请求参数
@property (nonatomic, strong) NSString *url;			//请求URL

- (void)getRequestCompletion:(comletionBlock) completion;

- (void)postRequestCompletion:(comletionBlock) completion;



/**
 下载文件

 @param url 下载地址
 @param path 存放文件夹, 文件名为服务器文件名
 @param completion 下载结果,downloadComletionBlock
 */
- (void)downloadRequest:(NSString *)url targetPath:(NSString *) path completion:(downloadComletionBlock) completion;

@end




