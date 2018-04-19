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
    method_exchangeImplementations(class_getInstanceMethod(self, NSSelectorFromString(@"dealloc")),class_getInstanceMethod(self, @selector(lg_dealloc)));
}

- (void)lg_dealloc{
    NSLog(@"class:%@ 释放了",[self class]);
    [self lg_dealloc];
}

- (BOOL)isNormal:(LGError *)error{
 	return  [self isNormal:error showInView:nil];
}

- (BOOL)isNormal:(LGError *)error showInView:(UIView *)view{
	if (!view) {
		view = self.view;
	}
	[LGProgressHUD hideHUDForView:view];
	if (error) {
		[LGProgressHUD showError:error.errorMessage toView:view];
		return NO;
	}else{
		return YES;
	}
}

@end
