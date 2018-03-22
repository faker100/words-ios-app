//
//  LGProgressHUD.m
//  Word
//
//  Created by Charles Cao on 2018/1/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGProgressHUD.h"

@implementation LGProgressHUD

+ (void)showHUDAddedTo:(UIView *)view {
    
    if (![super HUDForView:view]) [LGProgressHUD configTypeToView:view];
}

+ (void)hideHUDForView:(UIView *)view {
	
	[super hideHUDForView:view animated:YES];
}

+ (void)showError:(NSString *)text toView:(UIView *)view{
	
	[LGProgressHUD showError:text toView:view completionBlock:nil];
}

+ (void)showError:(NSString *)text toView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock) completionBlock{
	
	[LGProgressHUD showMessageWithIcon:@"alert_error" message:text toView:view completionBlock:completionBlock];
}

+ (void)showSuccess:(NSString *)text toView:(UIView *)view{
	[self showSuccess:text toView:view completionBlock:nil];
}

+ (void)showSuccess:(NSString *)text toView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock) completionBlock {
	
	[LGProgressHUD showMessageWithIcon:@"alert_success" message:text toView:view completionBlock:completionBlock];
	
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view{
	
	[LGProgressHUD showMessageWithIcon:nil message:message toView:view completionBlock:nil];
}

+ (LGProgressHUD *)configTypeToView:(UIView *)view {
    
	LGProgressHUD *hud = [super showHUDAddedTo:view animated:YES];
	hud.bezelView.color = [UIColor blackColor];
	hud.label.numberOfLines = 0;
	hud.bezelView.alpha = 0.8;
 //   hud.userInteractionEnabled = NO;
	hud.contentColor = [UIColor whiteColor];
	return hud;
}


+ (void)showMessageWithIcon:(NSString *)iconName message:(NSString *)message toView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock) completionBlock{
	
	
	LGProgressHUD *hud = [LGProgressHUD configTypeToView:view];
	hud.label.text = message;
	hud.completionBlock = completionBlock;
	if (StringNotEmpty(iconName)) {
		hud.mode  = MBProgressHUDModeCustomView;
		hud.minSize = CGSizeMake(150, 125);
		hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
	}else{
		hud.mode = MBProgressHUDModeText;
	}
	[hud hideAnimated:YES afterDelay:1.5f];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
