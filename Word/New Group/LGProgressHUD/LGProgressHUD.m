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
	
	LGProgressHUD *hud = [super showHUDAddedTo:view animated:YES];
	 [LGProgressHUD configType:hud];
}

+ (void)hideHUDForView:(UIView *)view {
	
	[super hideHUDForView:view animated:YES];
}

+ (void)showError:(NSString *)text toView:(UIView *)view{
	
	LGProgressHUD *hud = [super showHUDAddedTo:view animated:YES];
	hud.label.text = text;
	hud.mode = MBProgressHUDModeCustomView;
	hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"agree_selected"]];
	[hud hideAnimated:YES afterDelay:1.5f];
	 [LGProgressHUD configType:hud];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view{
	LGProgressHUD *hud = [super showHUDAddedTo:view animated:YES];
	hud.label.text = message;
	hud.mode = MBProgressHUDModeText;
	[hud hideAnimated:YES afterDelay:1.5f];
	[LGProgressHUD configType:hud];
}

+ (LGProgressHUD *)configType:(LGProgressHUD *)hud {
	
	hud.bezelView.color = [UIColor blackColor];
	hud.bezelView.alpha = 0.8;
	hud.contentColor = [UIColor whiteColor];
	return hud;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
