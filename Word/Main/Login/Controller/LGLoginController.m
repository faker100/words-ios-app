//
//  LGLoginController.m
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGLoginController.h"
#import "LGUserModel.h"

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
	
	NSDictionary *attributeDic = @{
						  NSForegroundColorAttributeName:[UIColor colorWithHexString:@"b8d3e0"],
						  };
	self.userNameTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号/邮箱" attributes:attributeDic];
	self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:attributeDic];
	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissAction:(id)sender {
	
}

- (IBAction)loginAction:(id)sender {
	NSString *username = self.userNameTextField.text;
	NSString *password = self.passwordTextField.text;
	[self.request loginRequest:username password:password completion:^(id response, NSString *errorMessage) {
		if (StringNotEmpty(errorMessage)) {
			NSLog(@"登录成功");
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
