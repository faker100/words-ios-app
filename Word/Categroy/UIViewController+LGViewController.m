//
//  UIViewController+LGViewController.m
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "UIViewController+LGViewController.h"
#import <objc/runtime.h>
#import "LGShareView.h"
#import "LGAlertMessageView.h"

#define MESSAGE_ALERT_TAG  9999

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

- (BOOL)isNormalNotMessage:(LGError *)error{
//	if (error.errorType == LGServiceError) {
//		<#statements#>
//	}
	return NO;
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


- (void)shareTitle:(NSString *)title text:(NSString *)text image:(id)image url:(NSString *)url type:(SSDKContentType)type{
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:text
                                     images:image
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:type];
    
    LGShareView *shareView = [[NSBundle mainBundle]loadNibNamed:@"LGShareView" owner:nil options:nil].firstObject;
    shareView.selectedPlatform = ^(SSDKPlatformType type) {
        [ShareSDK share:type parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            
        }];
    };
    shareView.frame =  self.view.window.bounds;
    [self.view.window addSubview:shareView];
}

-(void)showAlertMessage:(NSString *)message{
	
	[self removeAlertMessage];
	
	LGAlertMessageView *alertMessageView = [[NSBundle mainBundle]loadNibNamed:@"LGAlertMessageView" owner:nil options:nil].firstObject;
	alertMessageView.messageLabel.text = message;
	alertMessageView.frame = self.view.bounds;
	alertMessageView.tag = MESSAGE_ALERT_TAG;
	[self.view addSubview:alertMessageView];
}

-(void)removeAlertMessage{
	UIView *view = [self.view viewWithTag:MESSAGE_ALERT_TAG];
	if (view) {
		[view removeFromSuperview];
	}
}

@end
