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

- (void)loginRequest:(NSString *)username password:(NSString *)password completion:(completion)completion;

@end
