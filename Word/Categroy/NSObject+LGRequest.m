//
//  NSObject+LGRequest.m
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "NSObject+LGRequest.h"
#import <objc/runtime.h>

@implementation NSObject (LGRequest)

- (LGRequest *)request{
	
	LGRequest *tempRequest = objc_getAssociatedObject(self, _cmd);
	if (!tempRequest) {
		tempRequest = [[LGRequest alloc]init];
		self.request = tempRequest;
	}
	return tempRequest;
}

- (void)setRequest:(LGRequest *)request{
	objc_setAssociatedObject(self, @selector(request), request, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)lg_description{
	return [self mj_keyValues];
}

@end
