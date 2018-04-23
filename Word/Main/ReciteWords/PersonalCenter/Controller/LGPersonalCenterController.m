//
//  LGPersonalCenterController.m
//  Word
//
//  Created by Charles Cao on 2018/3/12.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPersonalCenterController.h"
#import "LGUserManager.h"
#import "LGThemeManager.h"

@interface LGPersonalCenterController ()

@end

@implementation LGPersonalCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
	if ([[LGUserManager shareManager] isLogin]) {
		LGUserModel *user = [LGUserManager shareManager].user;
		self.userNameLabel.text = user.nickname;
		[self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(user.image)] placeholderImage:PLACEHOLDERIMAGE];
	}else{
		self.userNameLabel.text = @"请登录";
	}
}

//跳转个人资料
- (IBAction)pushToUserInfo:(id)sender {
	if ([[LGUserManager shareManager] isLogin]) {
		[self performSegueWithIdentifier:@"personalCenterToPersonInfo" sender:nil];
	}else{
		[[NSNotificationCenter defaultCenter] postNotificationName:SHOW_LOGIN_NOTIFICATION object:nil];
	}
	
}
- (IBAction)nightThemeAction:(UIButton *)sender {
	LGThemeType type = [LGThemeManager shareManager].currentTheme;
	if (type == LGThemeNight)
	{
		[LGThemeManager shareManager].currentTheme = LGThemeDay;
	}else
	{
		[LGThemeManager shareManager].currentTheme = LGThemeNight;
	}
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
