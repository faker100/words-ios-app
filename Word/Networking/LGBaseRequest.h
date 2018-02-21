//
//  LGBaseRequest.h
//  Word
//
//  Created by Charles Cao on 2018/1/18.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

static dispatch_group_t requestGroup;  //用于优先执行的请求,（重置session请求）

typedef NS_ENUM(NSUInteger, LGErrorType) {
	LGSystemError,		//网络请求错误
	LGServiceError,     //服务器提示错误
	LGAPPError			//app 内部错误 (比如:播放音频失败)
};



@interface LGError : NSObject

@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, assign) LGErrorType errorType;

- (instancetype)initWithMessage:(NSString *)message type:(LGErrorType)type;

@end

typedef void(^comletionBlock)(id response, LGError *error);
typedef void(^downloadComletionBlock)(NSURL *filePath, LGError *error);

@interface LGBaseRequest : NSObject

@property (nonatomic, strong) NSURLSessionTask *task;    
@property (nonatomic, strong) NSDictionary *parameter;   //请求参数,指向 NSMutableDictionary 对象
@property (nonatomic, strong) NSString *url;			//请求URL

- (void)getRequestCompletion:(comletionBlock) completion;

- (void)postRequestCompletion:(comletionBlock) completion;



/**
 下载文件

 @param url 下载地址
 @param path 存放文件夹目录, 如果为 nil, 则是 document
 @param fileName 文件名,如果为 nil, 则是服务器文件名字
 @param completion 下载结果,downloadComletionBlock
 */
- (void)downloadRequest:(NSString *)url targetPath:(NSString *) path fileName:(NSString *)fileName completion:(downloadComletionBlock) completion;

@end




