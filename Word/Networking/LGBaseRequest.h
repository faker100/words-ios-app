//
//  LGBaseRequest.h
//  Word
//
//  Created by Charles Cao on 2018/1/18.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LGError;
typedef void(^completion)(id response, LGError *error);

@interface LGBaseRequest : NSObject

@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic, strong) NSMutableDictionary *parameter;
@property (nonatomic, strong) NSString *url;

- (void)getRequestCompletion:(completion) completion;
- (void)postRequestCompletion:(completion) completion;

@end

@interface LGError : NSObject

@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, assign) NSInteger errorCode;

@end
