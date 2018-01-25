//
//  LGFindPasswordController.m
//  Word
//
//  Created by Charles Cao on 2018/1/25.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGFindPasswordController.h"

@interface LGFindPasswordController ()

@property (nonatomic, strong ) NSTimer *timer;
@property (nonatomic, assign) NSInteger second; //倒计时60秒;

@end

@implementation LGFindPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
	[self.request requestCheckCodeSure];
}

- (void)viewDidDisappear:(BOOL)animated {
	
	self.checkCodeButton.enabled = YES;
	self.checkCodeButton.backgroundColor = [UIColor colorWithHexString:@"0B5F8F"];
	
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
		self.checkCodeButton.backgroundColor = [UIColor colorWithHexString:@"0B5F8F"];
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
	[self.request requestCheckCode:self.usernameTextField.text usernameType:type useType:LGCheckCodeUseTypeForgetPassword completion:^(id response, NSString *errorMessage) {
		[LGProgressHUD  hideHUDForView:self.view];
		if (StringNotEmpty(errorMessage)) {
			[LGProgressHUD showError:errorMessage toView:self.view];
			
		}else{
			[self beginCountdown];
		}
	}];
}

- (IBAction)submitAction:(id)sender {
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
	
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request findPasswordRequest:username password:password code:code usernameType:type completion:^(id response, NSString *errorMessage) {
		[LGProgressHUD hideHUDForView:self.view];
		if (StringNotEmpty(errorMessage)) {
			[LGProgressHUD showError:errorMessage toView:self.view];
		}else{
			[LGProgressHUD showMessage:@"修改成功" toView:self.view];
		}
	}];
	
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
