//
//  UIViewController+LGViewController.m
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "UIViewController+LGViewController.h"
#import <objc/runtime.h>


@implementation UIViewController (LGViewController)

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

@end
