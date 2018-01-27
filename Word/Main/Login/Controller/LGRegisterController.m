//
//  LGRegisterController.m
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGRegisterController.h"

@interface LGRegisterController ()

@property (nonatomic, strong ) NSTimer *timer;
@property (nonatomic, assign) NSInteger second; //倒计时60秒;

@end

@implementation LGRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
	[self.request requestCheckCodeSure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
	
	self.checkCodeButton.enabled = YES;
	self.checkCodeButton.backgroundColor = [UIColor lg_colorWithHexString:@"0B5F8F"];
	
	if (self.timer.isValid){
		[self.timer invalidate];
	}
	self.timer = nil;
}

//开始倒计时
- (void)beginCountdown {
	self.second = 60;
	if (self.timer) {
		[self.timer setFireDate:[NSDate distantPast]];
	}else{
		self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
		[[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
	}
}

- (void)countdown{
	
	self.second --;
	if (self.second <= 0) {
		[self.timer setFireDate:[NSDate distantFuture]];
		self.checkCodeButton.enabled = YES;
		self.checkCodeButton.backgroundColor = [UIColor lg_colorWithHexString:@"0B5F8F"];
	}else{
		self.checkCodeButton.enabled = NO;
		self.checkCodeButton.backgroundColor = [UIColor grayColor];
	}

	[self.checkCodeButton setTitle:[NSString stringWithFormat:@"已发送(%ld)",(long)self.second] forState:UIControlStateDisabled];
}

//获取验证码
- (IBAction)getCheckCodeAction:(UIButton *)sender {
	LGUsernameType type;
	NSString *username = self.usernameTextField.text;
	if ([username isPhoneNum]) {
		type = LGUsernamePhoneType;
	}else if ([username isEmail]) {
		type = LGUsernameEmailType;
	}else{
		[LGProgressHUD showMessage:@"请输入正确的用户名" toView:self.view];
		return;
	}
	
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestCheckCode:self.usernameTextField.text usernameType:type useType:LGCheckCodeUseTypeRegister completion:^(id response, NSString *errorMessage) {
		[LGProgressHUD  hideHUDForView:self.view];
		if (StringNotEmpty(errorMessage)) {
			[LGProgressHUD showError:errorMessage toView:self.view];
			
		}else{
			[self beginCountdown];
		}
	}];
}

- (IBAction)registerAction:(id)sender {
	
	NSString *username = self.usernameTextField.text;
	NSString *code = self.checkCodeTextField.text;
	NSString *password = self.passwordTextField.text;
	LGUsernameType type;
	if ([username isPhoneNum]) {
		type = LGUsernamePhoneType;
	}else if ([username isEmail]) {
		type = LGUsernameEmailType;
	}else{
		[LGProgressHUD showMessage:@"请输入正确的用户名" toView:self.view];
		return;
	}
	if (!StringNotEmpty(code)) {
		[LGProgressHUD showMessage:@"请输入验证码" toView:self.view];
		return;
	}
	if (!password.isRightPassword) {
		[LGProgressHUD showMessage:@"密码为6-20个数字或大小写字母" toView:self.view];
		return;
	}
	if (!self.agreeButton.selected) {
		[LGProgressHUD showMessage:@"请阅读并同意《用户协议》" toView:self.view];
		return;
	}
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request registerRequest:username password:password code:code usernameType:type completion:^(id response, NSString *errorMessage) {
		[LGProgressHUD hideHUDForView:self.view];
		if (StringNotEmpty(errorMessage)) {
			[LGProgressHUD showError:errorMessage toView:self.view];
		}else{
			[self.navigationController popViewControllerAnimated:YES];
		}
	}];
	
}

//同意用户协议
- (IBAction)agreeAction:(UIButton *)sender {
	sender.selected = !sender.selected;
}

- (IBAction)loginAction:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
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
