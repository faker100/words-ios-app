//
//  LGLoginController.m
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGLoginController.h"
#import "LGUserManager.h"
#import "JPUSHService.h"

@interface LGLoginController ()


@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LGLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self configInterface];
}

- (void)configInterface{
	
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
	NSDictionary *attributeDic = @{
						  NSForegroundColorAttributeName:[UIColor lg_colorWithHexString:@"b8d3e0"],
						  };
	self.userNameTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号/邮箱" attributes:attributeDic];
	self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:attributeDic];
	
	NSString *phone    = [LGUserManager previousPhone];
	NSString *email    = [LGUserManager previousEmail];
	NSString *password = [LGUserManager previousPassword];
	if (StringNotEmpty(phone) || StringNotEmpty(email)) {
		self.userNameTextField.text = StringNotEmpty(phone) ? phone : email;
	}
	if (StringNotEmpty(password)) {
		self.passwordTextField.text = password;
	}
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissAction:(id)sender {
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginAction:(id)sender {
	NSString *username = self.userNameTextField.text;
	NSString *password = self.passwordTextField.text;
	
	if (!([username isPhoneNum] || [username isEmail])) {
		[LGProgressHUD showMessage:@"请输入正确的用户名" toView:self.view];
		return;
	}
	
	if (!password.isRightPassword) {
		[LGProgressHUD showMessage:@"密码为6-20个数字或大小写字母" toView:self.view];
		return;
	}
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request loginRequest:username password:password completion:^(id response, LGError *error) {
        if ([self isNormal:error]) {
            LGUserModel *model = [LGUserModel mj_objectWithKeyValues:response];
            [LGUserManager shareManager].user = model;
			[JPUSHService setAlias:[NSString stringWithFormat:@"lgw%@",model.uid] completion:nil seq:0];
			[self updateStudyType:^{
				[[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_NOTIFICATION object:nil];
				[self.navigationController dismissViewControllerAnimated:YES completion:nil];
			}];
        }
	}];
}


/**
 更新本地存储的学习模式,更新成功后把本地的改为 LGStudyNone
 */
- (void)updateStudyType:(void (^)(void))finishBlock{
	 LGStudyType type = [LGUserManager shareManager].notLoggedStudyType;
	[LGProgressHUD showHUDAddedTo:self.view];
	if (type != LGStudyNone) {
		[self.request updateStudyType:type completion:^(id response, LGError *error) {
			if ([self isNormal:error]) {
				[LGUserManager shareManager].notLoggedStudyType = LGStudyNone;
			}
			finishBlock();
		}];
	}else{
		finishBlock();
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
