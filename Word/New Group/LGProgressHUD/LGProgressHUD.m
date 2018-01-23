//
//  LGProgressHUD.m
//  Word
//
//  Created by Charles Cao on 2018/1/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGProgressHUD.h"

@implementation LGProgressHUD

+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated{
	LGProgressHUD *hub = [super showHUDAddedTo:view animated:animated];
	hub.bezelView.color = [UIColor blackColor];
	hub.bezelView.alpha = 0.8;
	hub.label.text = @"aaa";
	hub.contentColor = [UIColor whiteColor];
	return hub;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
