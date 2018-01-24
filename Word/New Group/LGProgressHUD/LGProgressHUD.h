//
//  LGProgressHUD.h
//  Word
//
//  Created by Charles Cao on 2018/1/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface LGProgressHUD : MBProgressHUD

+ (void)showHUDAddedTo:(UIView *)view;

+ (void)hideHUDForView:(UIView *)view;

+ (void) showError:(NSString *)text toView:(UIView *)view;

+ (void) showMessage:(NSString *)message toView:(UIView *)view;

@end
