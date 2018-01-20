//
//  LGRequest.h
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGBaseRequest.h"

@interface LGRequest : LGBaseRequest


- (void)loginRequest:(NSString *)username password:(NSString *)password completion:(comletionBlock)completion;


/**
 重置 session

 @param userInfo id
 
 */
- (void)resetSessionRequest:(id) userInfo completion:(comletionBlock)completion;

@end
