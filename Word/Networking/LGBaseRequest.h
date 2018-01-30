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

@interface LGBaseRequest : NSObject

@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic, strong) NSDictionary *parameter;
@property (nonatomic, strong) NSString *url;

- (void)getRequestCompletion:(comletionBlock) completion;
- (void)postRequestCompletion:(comletionBlock) completion;

@end




