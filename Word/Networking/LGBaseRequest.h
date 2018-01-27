//
//  LGBaseRequest.h
//  Word
//
//  Created by Charles Cao on 2018/1/18.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^comletionBlock)(id response, NSString *errorMessage);

@interface LGBaseRequest : NSObject

@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic, strong) NSDictionary *parameter;
@property (nonatomic, strong) NSString *url;

- (void)getRequestCompletion:(comletionBlock) completion;
- (void)postRequestCompletion:(comletionBlock) completion;

@end



