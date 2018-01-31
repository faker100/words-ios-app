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


+ (void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),class_getInstanceMethod(self.class, @selector(lg_dealloc)));
}

- (void)lg_dealloc{
    NSLog(@"class:%@ 释放了",[self class]);
    [self lg_dealloc];
}

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
